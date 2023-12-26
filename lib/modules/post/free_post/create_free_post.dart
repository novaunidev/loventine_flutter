import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:loventine_flutter/models/province/vn_provinces.dart';
import 'package:loventine_flutter/modules/post/free_post/widgets/media_service.dart';
import 'package:loventine_flutter/modules/profile/pages/my_profile_page.dart';
import 'package:loventine_flutter/modules/profile/widgets/check_text.dart';
import 'package:loventine_flutter/values/app_color.dart';
import 'package:loventine_flutter/widgets/button/spring_button.dart';
import 'package:loventine_flutter/widgets/cupertino_bottom_sheet/src/bottom_sheets/cupertino_bottom_sheet.dart';
import 'package:loventine_flutter/widgets/custom_dropdown/custom_dropdown.dart';
import 'package:loventine_flutter/widgets/custom_popup_menu_button.dart';
import 'package:loventine_flutter/widgets/custom_snackbar.dart';
import 'package:loventine_flutter/widgets/emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:loventine_flutter/widgets/user_information/avatar_widget.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';
import '../../../config.dart';
import '../../../main.dart';
import '../../../providers/page/message_page/card_profile_provider.dart';
import '../../../providers/page/message_page/message_page_provider.dart';
import '../../../widgets/button/add_to_cart_button.dart';
import 'models/free_post.dart';
import 'package:flutter/foundation.dart' as foundation;

class CreateFreePost extends StatefulWidget {
  const CreateFreePost({super.key});

  @override
  State<CreateFreePost> createState() => _CreateFreePostState();
}

class _CreateFreePostState extends State<CreateFreePost> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _titleController1 = TextEditingController();
  final TextEditingController _titleController2 = TextEditingController();
  final provinceController = TextEditingController();
  List<String> provinces = VNProvinces().allProvince(keyword: "");
  ScrollController scrollController = ScrollController();
  AssetPathEntity? selectedAlbum;
  List<AssetPathEntity> albumList = [];
  List<AssetEntity> assetList = [];
  List<AssetEntity> selectedAssetList = [];
  List<String> images = [];
  List<File> files = [];
  List<CloudinaryFile> cloudinaryList = [];
  bool isShowImagePicker = false;
  bool isShowEmojiPicker = false;
  late String current_user_id;
  List<String> purposes = [
    "Người yêu",
    "Bạn hẹn hò lâu dài",
    "Bất kì điều gì có thể",
    "Quan hệ không ràng buộc",
    "Những người bạn mới",
    "Mình cũng chưa rõ lắm"
  ];
  List<String> emojis = ["💘", "😍", "🥂", "🎉", "👋", "🤔"];
  AddToCartButtonStateId stateId = AddToCartButtonStateId.idle;
  FocusNode contentFocusNode = FocusNode();
  String address = "";
  List<String> parts = [];
  bool isShowAddress = false;
  bool isShowTextAddress = false;
  bool _isPublic = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titleController1.text = emojis[0];
    _titleController2.text = purposes[0];
    _titleController1.addListener(
      () {
        if (_titleController1.text.length > 2) {
          _titleController1.text = _titleController1.text.substring(2, 4);
        }
        setState(() {});
      },
    );
    MediaServices().loadAlbums(RequestType.image).then(
      (value) {
        setState(() {
          albumList = value;
          selectedAlbum = value[0];
        });
        //LOAD RECENT ASSETS
        MediaServices().loadAssets(selectedAlbum!).then(
          (value) {
            setState(() {
              assetList = value;
            });
          },
        );
      },
    );
    contentFocusNode.addListener(() {
      if (contentFocusNode.hasFocus) {
        setState(() {
          isShowImagePicker = false;
          isShowEmojiPicker = false;
        });
      }
    });
    current_user_id = Provider.of<MessagePageProvider>(context, listen: false)
        .current_user_id;
    final userCurrent =
        Provider.of<CardProfileProvider>(context, listen: false).user;
    if (userCurrent.address != null) {
      if (userCurrent.address!.contains("Tỉnh") ||
          userCurrent.address!.contains("Tp")) {
        parts = userCurrent.address!.split(', ');
        address = parts.last;
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _descriptionController.dispose();
  }

  final cloudinary = CloudinaryPublic('dkkdavbbq', 'mtrkthmf', cache: false);

  Future<void> uploadImages(List<AssetEntity> assets) async {
    try {
      if (address == "") {
        CustomSnackbar.show(context,
            title: "Hãy chọn nơi bạn đang sống", type: SnackbarType.failure);
        setState(() {
          stateId = AddToCartButtonStateId.idle;
        });
      } else {
        if (assets.isNotEmpty) {
          await convertAssetsToCloudinaryFiles(assets);
          final responses = await cloudinary.uploadFiles(cloudinaryList);
          for (var response in responses) {
            images.add(response.secureUrl);
          }
          for (var file in files) {
            file.delete();
          }
        }
        await createFreePost();
      }
    } catch (e) {
      print(e);
    }
  }

  Future createFreePost() async {
    FreePost freePost = FreePost(
        userId: current_user_id,
        title: _titleController1.text + _titleController2.text,
        content: _descriptionController.text,
        postingTime: DateTime.now().toIso8601String(),
        images: images,
        userAddress: address,
        isPublic: _isPublic);

    try {
      var response = await Dio().post(
          "$baseUrl/post/createPost/${freePost.userId}",
          data: freePost.toMap());

      if (response.statusCode == 200) {
        if (address != "" && (parts.isEmpty || address != parts.last)) {
          Provider.of<CardProfileProvider>(context, listen: false)
              .updateAddress(address, current_user_id);
        }
        Future.delayed(const Duration(seconds: 3), () {
          setState(() {
            stateId = AddToCartButtonStateId.done;
          });
          Future.delayed(const Duration(seconds: 2), () {
            CustomSnackbar.show(
              context,
              title: ' Đăng bài thành công',
              message:
                  'Bây giờ, Bạn có thể nhìn thấy bài đăng của bạn trên tab cộng đồng',
              type: SnackbarType.success,
            );
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => const MainPage(
                  currentIndex: 0,
                ),
              ),
            );
          });
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<File?> compressFile(File? file) async {
    const minKb = 150 * 1024;
    File? result = file;
    if (result!.lengthSync() < minKb) {
      return result;
    } else {
      try {
        int quality = (100 -
                (((result.lengthSync() - minKb) / result.lengthSync()) * 100))
            .toInt();
        print(quality);
        result = await FlutterImageCompress.compressAndGetFile(
          result.absolute.path,
          "${result.path}.jpg",
          quality: quality > 50 ? quality : (quality * 2) + 1,
        );

        return result;
      } catch (e) {
        print(e);
        print("object");
        return result;
      }
    }
  }

  Future convertAssetsToCloudinaryFiles(List<AssetEntity> assetEntities) async {
    for (var i = 0; i < assetEntities.length; i++) {
      final File? _file = await assetEntities[i].file;
      final file = await compressFile(_file!);
      final cloudinaryFile = CloudinaryFile.fromFile(file!.path,
          resourceType: CloudinaryResourceType.Image, folder: "post_free");
      files.add(file);
      cloudinaryList.add(cloudinaryFile);
    }
  }

  Widget titleTag() => Container(
        padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(children: [
          const SizedBox(
            width: 5,
          ),
          SvgPicture.asset('assets/svgs/search-favorite.svg'),
          const SizedBox(
            width: 5,
          ),
          const Text(
            "Mình đang tìm",
            style: TextStyle(
                color: Color(0xFF150B3D),
                fontFamily: 'Loventine-Regular',
                fontSize: 15),
          ),
          const Spacer(),
          InkWell(
            onTap: () {
              showModalBottomSheet(
                backgroundColor: Colors.white,
                isScrollControlled: true,
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                ),
                builder: (context) {
                  return const BottomSheetTitle();
                },
              ).then((value) {
                setState(() {
                  _titleController1.text = emojis[value];
                  _titleController2.text = purposes[value];
                });
              });
            },
            child: Row(
              children: [
                Text(
                  "${_titleController1.text}${_titleController2.text}",
                  style: const TextStyle(
                      color: Color(0xFF150B3D),
                      fontFamily: 'Loventine-Regular',
                      fontSize: 15),
                ),
                const SizedBox(
                  width: 3,
                ),
                const Image(
                    width: 9,
                    height: 17,
                    image: AssetImage('assets/images/Select.png')),
                const SizedBox(
                  width: 3,
                ),
              ],
            ),
          ),
        ]),
      );

  Widget describe() => Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Stack(
            children: [
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade200,
                          blurRadius: 7.0,
                          spreadRadius: 3,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Form(
                              key: _formKey,
                              child: TextFormField(
                                cursorColor: AppColor.mainColor,
                                controller: _descriptionController,
                                keyboardType: TextInputType.multiline,
                                focusNode: contentFocusNode,
                                decoration: InputDecoration(
                                  hoverColor: Colors.transparent,
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 30.0, horizontal: 30.0),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  hintText:
                                      "Thả đôi dòng về bản thân và mong muốn của bạn, để chúng tôi làm 'điều hòa tình yêu' cho bạn🥰",
                                  hintStyle: const TextStyle(
                                      color: Color(0xff616161),
                                      fontSize: 15,
                                      fontFamily: "Loventine-Regular"),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                                style: const TextStyle(
                                    fontFamily: "Loventine-Regular"),
                                maxLines: 100,
                                minLines: 1,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (checkText(value!)) {
                                    return "Văn bản chứa từ không phù hợp!";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            )
                          ],
                        ),
                        Positioned(
                          bottom: 0,
                          left: 35,
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColor.mainColor.withOpacity(0.1),
                    width: 2.5,
                  ),
                ),
                child: const AvatarWidget(
                  size: 39,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  showCupertinoModalBottomSheet(
                      expand: false,
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (context) => MyProfilePage(
                            isMe: true,
                            userId: current_user_id,
                            avatar: "",
                          ));
                },
                child: const Text(
                  "Chỉnh sửa profile",
                  style: TextStyle(
                      fontFamily: 'Loventine-Regular',
                      color: AppColor.describetextcolor,
                      fontWeight: FontWeight.w400),
                ),
              )
            ],
          ),
          Positioned(
            bottom: 32,
            left: 25,
            child: Container(
              width: 15,
              height: 15,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFFfafafd),
        elevation: 0.0,
        title: const Text(
          "Đăng bài miễn phí",
          style: TextStyle(
            fontFamily: "Montserrat-Bold",
            color: Color(0xFF000000),
            fontSize: 16,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: AppColor.borderButton,
            height: 1.0,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: scrollController,
            physics: const BouncingScrollPhysics(),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isShowImagePicker = false;
                  isShowEmojiPicker = false;
                });
              },
              child: Container(
                color: const Color(0xFFfafafd),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        "Mục đích của bạn",
                        style: TextStyle(
                          fontFamily: 'Loventine-Bold',
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      titleTag(),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                            onPressed: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              setState(() {
                                isShowImagePicker = false;
                                isShowEmojiPicker = true;
                              });
                            },
                            child: const Text(
                              "Tùy chỉnh icon",
                              style: TextStyle(
                                fontFamily: 'Loventine-Semibold',
                                color: AppColor.mainColor,
                              ),
                            )),
                      ),
                      const Divider(color: AppColor.borderButton),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Hãy nói một điều gì đó khiến mọi người hiểu bạn hơn",
                        style: TextStyle(
                          fontFamily: 'Loventine-Bold',
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      describe(),
                      const Divider(color: AppColor.borderButton),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Đối tượng xem bình luận",
                        style: TextStyle(
                          fontFamily: 'Loventine-Bold',
                          fontSize: 18,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 13, horizontal: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(children: [
                          const SizedBox(
                            width: 5,
                          ),
                          SvgPicture.asset(
                            "assets/svgs/lock-circle.svg",
                            color: AppColor.blackColor,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            "Chọn đối tượng",
                            style: TextStyle(
                                color: Color(0xFF150B3D),
                                fontFamily: 'Loventine-Regular',
                                fontSize: 15),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                backgroundColor: Colors.white,
                                isScrollControlled: false,
                                context: context,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25.0),
                                    topRight: Radius.circular(25.0),
                                  ),
                                ),
                                builder: (context) {
                                  return EditObject(
                                    isPublic: _isPublic,
                                  );
                                },
                              ).then((value) {
                                if (value != null) {
                                  if (value == Option.public) {
                                    if (_isPublic == false) {
                                      setState(() {
                                        _isPublic = true;
                                      });
                                    }
                                  } else {
                                    if (_isPublic) {
                                      setState(() {
                                        _isPublic = false;
                                      });
                                    }
                                  }
                                }
                              });
                            },
                            child: Row(
                              children: [
                                Text(
                                  _isPublic ? "Công khai" : "Chỉ mình tôi",
                                  style: const TextStyle(
                                      color: Color(0xFF150B3D),
                                      fontFamily: 'Loventine-Regular',
                                      fontSize: 15),
                                ),
                                const SizedBox(
                                  width: 3,
                                ),
                                const Image(
                                    width: 9,
                                    height: 17,
                                    image:
                                        AssetImage('assets/images/Select.png')),
                                const SizedBox(
                                  width: 3,
                                ),
                              ],
                            ),
                          ),
                        ]),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(color: AppColor.borderButton),
                      const SizedBox(
                        height: 10,
                      ),
                      if (address == "") ...[
                        const Text(
                          "Bạn đang sống ở đâu?",
                          style: TextStyle(
                            fontFamily: 'Loventine-Bold',
                            fontSize: 22,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomDropdown.search(
                          hintText: 'Tỉnh/Thành Phố',
                          hintStyle:
                              const TextStyle(fontFamily: "Loventine-Regular"),
                          selectedStyle:
                              const TextStyle(fontFamily: "Loventine-Regular"),
                          controller: provinceController,
                          items: provinces,
                          onChanged: (p0) {
                            address = p0;
                          },
                        ),
                      ] else ...[
                        isShowTextAddress
                            ? Text(
                                "Sống tại ${provinceController.text}",
                                style: const TextStyle(
                                  fontFamily: 'Loventine-Bold',
                                  color: AppColor.blackColor,
                                  fontSize: 18,
                                ),
                              )
                            : RichText(
                                textAlign: TextAlign.start,
                                text: TextSpan(
                                  children: <InlineSpan>[
                                    TextSpan(
                                      text:
                                          'Bạn vẫn đang còn ở $address đúng chứ? ',
                                      style: const TextStyle(
                                        color: AppColor.blackColor,
                                        fontFamily: 'Loventine-Bold',
                                        fontSize: 18,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Không, tôi ở nơi khác',
                                      style: const TextStyle(
                                        color: AppColor.mainColor,
                                        fontFamily: 'Loventine-Regular',
                                        fontSize: 18,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          setState(() {
                                            isShowAddress = true;
                                          });
                                        },
                                    ),
                                  ],
                                ),
                              ),
                        const SizedBox(
                          height: 10,
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          height: isShowAddress ? 40 : 0,
                          child: CustomDropdown.search(
                            hintText: 'Tỉnh/Thành Phố',
                            errorStyle: const TextStyle(
                                fontFamily: "Loventine-Regular"),
                            listItemStyle: const TextStyle(
                                fontFamily: "Loventine-Regular"),
                            hintStyle: const TextStyle(
                                fontFamily: "Loventine-Regular"),
                            selectedStyle: const TextStyle(
                                fontFamily: "Loventine-Regular"),
                            controller: provinceController,
                            items: provinces,
                            fieldSuffixIcon: isShowAddress
                                ? const Icon(
                                    Icons.expand_more,
                                    color: AppColor.blackColor,
                                  )
                                : const SizedBox(),
                            onChanged: (p0) {
                              address = p0;
                              if (provinceController.text.isNotEmpty) {
                                setState(() {
                                  isShowTextAddress = true;
                                });
                              }
                            },
                          ),
                        )
                      ],
                      const SizedBox(
                        height: 10,
                      ),
                      GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: 0.75,
                        ),
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(bottom: 16),
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: selectedAssetList.isEmpty
                            ? 1
                            : selectedAssetList.length + 1,
                        itemBuilder: (context, index) {
                          return selectedAssetList.isEmpty
                              ? InkWell(
                                  onTap: () {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    scrollController.animateTo(
                                      scrollController.position.maxScrollExtent,
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.easeInOut,
                                    );
                                    setState(() {
                                      isShowImagePicker = true;
                                      isShowEmojiPicker = false;
                                    });
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 1,
                                        ),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: const Stack(
                                          fit: StackFit.expand,
                                          children: [
                                            Positioned(
                                              top: 5.0,
                                              right: 5.0,
                                              child: Material(
                                                elevation: 3.0,
                                                shape: CircleBorder(),
                                                child: Icon(
                                                  Icons.add_circle,
                                                  size: 25,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                )
                              : index == selectedAssetList.length
                                  ? selectedAssetList.length == 5
                                      ? const SizedBox()
                                      : InkWell(
                                          onTap: () {
                                            scrollController.animateTo(
                                              scrollController
                                                  .position.maxScrollExtent,
                                              duration: const Duration(
                                                  milliseconds: 500),
                                              curve: Curves.easeInOut,
                                            );
                                            setState(() {
                                              isShowImagePicker = true;

                                              isShowEmojiPicker = false;
                                            });
                                          },
                                          child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                  color: Colors.grey,
                                                  width: 1,
                                                ),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: const Stack(
                                                  fit: StackFit.expand,
                                                  children: [
                                                    Positioned(
                                                      top: 5.0,
                                                      right: 5.0,
                                                      child: Material(
                                                        elevation: 3.0,
                                                        shape: CircleBorder(),
                                                        child: Icon(
                                                          Icons.add_circle,
                                                          size: 25,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )),
                                        )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Stack(
                                        fit: StackFit.expand,
                                        children: [
                                          AssetEntityImage(
                                            selectedAssetList[index],
                                            isOriginal: false,
                                            thumbnailSize:
                                                const ThumbnailSize.square(
                                                    1000),
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return const Center(
                                                child: Icon(
                                                  Icons.error,
                                                  color: Colors.red,
                                                ),
                                              );
                                            },
                                          ),
                                          Positioned(
                                            right: 3,
                                            top: 3,
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  selectedAssetList.remove(
                                                      selectedAssetList[index]);
                                                });
                                              },
                                              child: Container(
                                                width: 20,
                                                height: 20,
                                                decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  shape: BoxShape.circle,
                                                  // border: Border.all(
                                                  //   color: AppColor.blackColor,
                                                  //   width: 1,
                                                  // ),
                                                ),
                                                child: Center(
                                                  child: Icon(
                                                    Icons.close,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .secondary,
                                                    size: 16,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                        },
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              "assets/svgs/danger_bold.svg",
                              height: 20,
                              color: Colors.red,
                            ),
                            const Text(
                              "Tối đa 5 hình ảnh",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontFamily: "Loventine-Bold"),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      AddToCartButton(
                        trolley: Lottie.asset('assets/lotties/love_done.json',
                            height: 45),
                        textLoading: "Chờ xíu nhanh thui mà...",
                        text: const Text(
                          'Đăng bài viết',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Loventine-Bold',
                            fontSize: 16,
                            color: Color(0xffffffff),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                        ),
                        check: Lottie.asset("assets/lotties/love_done.json",
                            height: 50),
                        borderRadius: BorderRadius.circular(24),
                        backgroundColor: AppColor.mainColor,
                        onPressed: (id) {
                          if (_formKey.currentState!.validate()) {
                            if (id == AddToCartButtonStateId.idle) {
                              setState(() {
                                stateId = AddToCartButtonStateId.loading;
                              });
                              uploadImages(selectedAssetList);
                            } else if (id == AddToCartButtonStateId.done) {
                              setState(() {
                                stateId = AddToCartButtonStateId.idle;
                              });
                            }
                          }
                        },
                        stateId: stateId,
                      ),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          isShowImagePicker == false
              ? const SizedBox()
              : DraggableScrollableSheet(
                  initialChildSize: 0.4,
                  maxChildSize: 0.9,
                  minChildSize: 0.4,
                  builder: (context, scroll) {
                    return Container(
                      color: Colors.white,
                      child: CustomScrollView(
                        controller: scroll,
                        physics: const BouncingScrollPhysics(),
                        slivers: [
                          SliverPersistentHeader(
                            pinned: true,
                            floating: true,
                            delegate: _SliverAppBarDelegate(
                              minHeight:
                                  40, // Chiều cao tối thiểu của SliverAppBar là 20
                              maxHeight:
                                  40, // Chiều cao tối đa của SliverAppBar là 40
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey
                                            .withOpacity(0.5), // Màu của bóng
                                        spreadRadius:
                                            -3, // Độ xổ của bóng (lớn hơn giá trị, bóng càng lớn)
                                        blurRadius:
                                            7, // Độ mờ của bóng (lớn hơn giá trị, bóng càng mờ)
                                        offset: const Offset(0,
                                            -3), // Vị trí của bóng (thay đổi giá trị X và Y để di chuyển bóng)
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        if (selectedAlbum != null)
                                          GestureDetector(
                                            onTap: () {
                                              albums(size.height);
                                            },
                                            child: Text(
                                              selectedAlbum!.name == "Recent"
                                                  ? "Gallery"
                                                  : selectedAlbum!.name,
                                              style: const TextStyle(
                                                color: AppColor.blackColor,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 13,
                                              ),
                                            ),
                                          ),
                                        const Padding(
                                          padding: EdgeInsets.only(
                                            left: 5,
                                          ),
                                          child: Icon(
                                            Icons.arrow_downward,
                                            color: AppColor.blackColor,
                                            size: 15,
                                          ),
                                        ),
                                        const Spacer(),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              isShowImagePicker = false;
                                            });
                                          },
                                          child: const Text(
                                            "OK",
                                            style: TextStyle(
                                              color: AppColor.blackColor,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SliverGrid(
                              delegate: SliverChildBuilderDelegate(
                                  childCount: assetList.length,
                                  (context, index) {
                                AssetEntity assetEntity = assetList[index];
                                return assetWidget(assetEntity);
                              }),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4))
                        ],
                      ),
                    );
                  }),
          isShowEmojiPicker == false
              ? const SizedBox()
              : DraggableScrollableSheet(
                  initialChildSize: 0.4,
                  maxChildSize: 0.8,
                  minChildSize: 0.4,
                  builder: (context, scrollEmoji) {
                    return EmojiPicker(
                      success: () {
                        setState(() {
                          isShowEmojiPicker = false;
                        });
                      },
                      scrollController: scrollEmoji,
                      textEditingController: _titleController1,
                      onBackspacePressed: () {
                        _titleController1
                          ..text = _titleController1.text.characters.toString()
                          ..selection = TextSelection.fromPosition(TextPosition(
                              offset: _titleController1.text.length));
                      },
                      config: Config(
                        columns: 8,
                        emojiSizeMax: 32 *
                            (foundation.defaultTargetPlatform ==
                                    TargetPlatform.iOS
                                ? 1.30
                                : 1.0), // Issue: https://github.com/flutter/flutter/issues/28894
                        verticalSpacing: 0,
                        horizontalSpacing: 0,
                        gridPadding: EdgeInsets.zero,
                        initCategory: Category.RECENT,
                        bgColor: Colors.white,
                        indicatorColor: Colors.blue,
                        iconColor: Colors.grey,
                        iconColorSelected: Colors.blue,
                        backspaceColor: Colors.blue,
                        skinToneDialogBgColor: Colors.white,
                        skinToneIndicatorColor: Colors.grey,
                        enableSkinTones: true,
                        recentTabBehavior: RecentTabBehavior.RECENT,
                        recentsLimit: 28,
                        noRecents: const Text(
                          'No Recents',
                          style: TextStyle(
                              fontSize: 20, color: AppColor.blackColor),
                          textAlign: TextAlign.center,
                        ), // Needs to be const Widget
                        loadingIndicator:
                            const SizedBox.shrink(), // Needs to be const Widget
                        tabIndicatorAnimDuration: kTabScrollDuration,
                        categoryIcons: const CategoryIcons(),
                        buttonMode: ButtonMode.MATERIAL,
                      ),
                    );
                  })
        ],
      ),
    );
  }

  Widget assetWidget(AssetEntity assetEntity) => GestureDetector(
        onTap: () {
          if (selectedAssetList.contains(assetEntity)) {
            setState(() {
              selectedAssetList.remove(assetEntity);
            });
          } else if (selectedAssetList.length < 5) {
            setState(() {
              selectedAssetList.add(assetEntity);
            });
          }
        },
        child: Padding(
          padding: EdgeInsets.all(
              selectedAssetList.contains(assetEntity) == true ? 5 : 0),
          child: Stack(
            children: [
              Positioned.fill(
                child: AssetEntityImage(
                  assetEntity,
                  isOriginal: false,
                  thumbnailSize: const ThumbnailSize.square(250),
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Icon(
                        Icons.error,
                        color: Colors.red,
                      ),
                    );
                  },
                ),
              ),
              selectedAssetList.contains(assetEntity) == false
                  ? const SizedBox()
                  : Positioned.fill(
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 1.5,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                "${selectedAssetList.indexOf(assetEntity) + 1}",
                                style: const TextStyle(
                                    fontSize: 10, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      );
  void albums(height) {
    showModalBottomSheet(
      backgroundColor: const Color(0xff101010),
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      builder: (context) {
        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: albumList.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () async {
                setState(() {
                  selectedAlbum = albumList[index];
                });
                await MediaServices().loadAssets(albumList[index]).then(
                  (value) {
                    setState(() {
                      assetList = value;
                    });
                    Navigator.pop(context);
                  },
                );
              },
              title: Text(
                albumList[index].name == "Recent"
                    ? "Gallery"
                    : albumList[index].name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

class BottomSheetTitle extends StatefulWidget {
  const BottomSheetTitle({super.key});

  @override
  State<BottomSheetTitle> createState() => _BottomSheetTitleState();
}

class _BottomSheetTitleState extends State<BottomSheetTitle> {
  List<String> purposesView = [
    "Người yêu",
    "Bạn hẹn hò lâu dài",
    "Bất kì điều gì có thể",
    "Quan hệ không ràng buộc",
    "Những người bạn mới",
    "Mình cũng chưa rõ lắm"
  ];

  List<String> emojis = ["💘", "😍", "🥂", "🎉", "👋", "🤔"];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Bây giờ mình đang tìm...",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Loventine-Bold',
                  fontSize: 22,
                  color: AppColor.blackColor),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Chia sẽ mục đích để tìm được \"người ấy\"!",
              style: TextStyle(
                color: AppColor.blackColor,
                fontFamily: 'Loventine-Regular',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  childAspectRatio: 0.85,
                  crossAxisCount: 3,
                ),
                itemCount: purposesView.length,
                itemBuilder: (context, index) {
                  return SpringButton(
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 237, 237, 242),
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            emojis[index],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: AppColor.blackColor,
                                fontFamily: 'Loventine-Regular',
                                fontSize: 28),
                          ),
                          Text(
                            purposesView[index],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: AppColor.blackColor,
                                fontFamily: 'Loventine-Regular',
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    onTapDown: (details) {
                      Future.delayed(const Duration(milliseconds: 150), () {
                        Navigator.pop(context, index);
                      });
                    },
                  );
                }),
          ],
        ),
      ),
    );
  }
}
