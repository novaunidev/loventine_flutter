// ignore_for_file: body_might_complete_normally_nullable, use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:loventine_flutter/config.dart';
import 'package:loventine_flutter/modules/profile/services/otp.dart';
import 'package:loventine_flutter/modules/profile/widgets/check_text.dart';
import 'package:loventine_flutter/modules/profile/widgets/info_profile.dart';
import 'package:loventine_flutter/pages/auth/verify_page.dart';
import 'package:loventine_flutter/providers/page/message_page/message_page_provider.dart';
import 'package:loventine_flutter/widgets/app_text.dart';
import 'package:loventine_flutter/widgets/back_icon.dart';
import 'package:loventine_flutter/widgets/cupertino_bottom_sheet/src/bottom_sheets/cupertino_bottom_sheet.dart';
import 'package:loventine_flutter/widgets/custom_date_picker.dart';
import 'package:loventine_flutter/widgets/custom_snackbar.dart';
import 'package:loventine_flutter/widgets/user_information/avatar_widget.dart';
import '../../../widgets/button/action_button.dart';
import '../../../widgets/cupertino_bottom_sheet/modals/floating_modal.dart';
import '../widgets/bottom_sheet_add_address.dart';
import '../../../providers/page/message_page/card_profile_provider.dart';
import '/providers/page/message_page/user_image_provider.dart';
import 'package:provider/provider.dart';
import '/modules/profile/services/controller.dart';
import 'package:get/get.dart';
import '/modules/profile/widgets/bottom_sheet_widget.dart';
import '/values/app_color.dart';

class EditProfilePage extends StatefulWidget {
  //final List<UserImage> image_uploads;
  final User? user;
  final bool isMe;
  final String avatar;
  const EditProfilePage(
      {super.key,
      //required this.image_uploads,
      required this.user,
      required this.isMe,
      required this.avatar});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

enum Gender { male, female }

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  late String current_user_id;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isExistPhone = false;
  bool isExistEmail = false;
  Gender gender = Gender.male;
  DateTime currentDateTime = DateTime.now();
  bool isChange = false;
  String sexValue = "Không muốn trả lời";
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.user?.about != null) {
      _descriptionController.text = '${widget.user?.about}';
    }
    if (widget.user?.name != null) {
      _nameController.text = '${widget.user?.name}';
    }
    if (widget.user?.birthday != null) {
      _dateController.text = '${widget.user?.birthday}';
    }
    if (widget.user?.email != null) {
      _emailController.text = '${widget.user?.email}';
    }
    if (widget.user?.phone != null) {
      _phoneController.text = '${widget.user?.phone}';
    }
    if (widget.user?.address != null) {
      _addressController.text = '${widget.user?.address}';
    }
    if (widget.user?.sex != null) {
      sexValue = '${widget.user?.sex}';
    }
    if (widget.user!.birthday != "" && widget.user!.birthday != null) {
      currentDateTime = DateFormat('dd/MM/yyyy').parse(widget.user!.birthday!);
    }
    // current_user_id = Provider.of<MessagePageProvider>(context, listen: false)
    //     .current_user_id;
  }

  checkPhone(String value) async {
    try {
      var response = await Dio().get("$baseUrl/auth/checkPhone/$value");
      if (response.statusCode == 200) {
        String message = response.data["message"];
        if (message == "Phone already exists" && value != widget.user?.phone) {
          if (mounted) {
            setState(() {
              isExistPhone = true;
            });
          }
        } else {
          if (mounted) {
            setState(() {
              isExistPhone = false;
            });
          }
        }
      }
    } catch (e) {
      print(e);
    }
  }

  checkEmail(String value) async {
    try {
      var response = await Dio().get("$baseUrl/auth/checkEmail/$value");
      if (response.statusCode == 200) {
        String message = response.data["message"];
        if (message == "Email already exists" && value != widget.user?.email) {
          if (mounted) {
            setState(() {
              isExistEmail = true;
            });
          }
        } else {
          if (mounted) {
            setState(() {
              isExistEmail = false;
            });
          }
        }
      }
    } catch (e) {
      print(e);
    }
  }

  void updateUser() async {
    if (_emailController.text != widget.user?.email) {
      await checkEmail(_emailController.text);
    }
    if (_phoneController.text != widget.user?.phone) {
      await checkPhone(_phoneController.text);
    }

    if (isExistEmail && isExistPhone) {
      CustomSnackbar.show(context,
          type: SnackbarType.warning,
          title: "Email và Số điện thoại đã tồn tại!",
          message: "Vui lòng điền email và số điện thoại khác");
      setState(() {
        isLoading = false;
        isExistEmail = false;
        isExistPhone = false;
      });
    } else if (isExistEmail) {
      CustomSnackbar.show(context,
          type: SnackbarType.warning,
          title: "Email đã tồn tại!",
          message: "Vui lòng điền email khác");
      setState(() {
        isLoading = false;
        isExistEmail = false;
        isExistPhone = false;
      });
    } else if (isExistPhone) {
      CustomSnackbar.show(context,
          type: SnackbarType.warning,
          title: "Số điện thoại đã tồn tại!",
          message: "Vui lòng điền số điện thoại khác");
      setState(() {
        isLoading = false;
        isExistEmail = false;
        isExistPhone = false;
      });
    } else {
      if (_emailController.text != widget.user?.email) {
        await OTPService()
            .sendOTPbyEmail(context, _emailController.text)
            .then((value) {
          value == 200
              ? Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => VerifyPage(
                            email: _emailController.text,
                            type: "update",
                            phoneNumber: _phoneController.text,
                          )),
                ).then((value) async {
                  if (value) {
                    String userID =
                        Provider.of<MessagePageProvider>(context, listen: false)
                            .current_user_id;
                    await Provider.of<CardProfileProvider>(context,
                            listen: false)
                        .updateCardProfile(
                            userID,
                            _descriptionController.text,
                            _nameController.text,
                            _dateController.text,
                            _emailController.text,
                            _phoneController.text,
                            sexValue,
                            _addressController.text,
                            context);
                  } else {
                    CustomSnackbar.show(
                      context,
                      type: SnackbarType.warning,
                      title: "Xác nhận otp không thành công",
                    );
                    setState(() {
                      isLoading = false;
                      isExistEmail = false;
                      isExistPhone = false;
                    });
                  }
                })
              : value == 429
                  ? {
                      CustomSnackbar.show(context,
                          type: SnackbarType.warning,
                          title: "Cảnh báo",
                          message:
                              "Bạn đã gửi quá 5 Otp. Vui lòng quay lại sau một giờ"),
                      setState(() {
                        isLoading = false;
                      })
                    }
                  : {
                      CustomSnackbar.show(context,
                          type: SnackbarType.failure,
                          title: "Lỗi",
                          message: "Lỗi gửi Otp. Vui lòng thử lại sau"),
                      setState(() {
                        isLoading = false;
                      })
                    };
        });
      } else {
        String userID = Provider.of<MessagePageProvider>(context, listen: false)
            .current_user_id;
        await Provider.of<CardProfileProvider>(context, listen: false)
            .updateCardProfile(
                userID,
                _descriptionController.text,
                _nameController.text,
                _dateController.text,
                _emailController.text,
                _phoneController.text,
                sexValue,
                _addressController.text,
                context);
      }
    }
  }

  //

  @override
  Widget build(BuildContext context) {
    String avatar =
        Provider.of<UserImageProvider>(context, listen: false).avatar;
    final size = MediaQuery.sizeOf(context);
    const double sizeBackground = 300;
    final ProfileController profilerController = Get.put(ProfileController());
    snack(String type) {
      if (type == "chưa chọn ảnh") {
        CustomSnackbar.show(context,
            type: SnackbarType.warning,
            title: "Lỗi",
            message: "Chưa chọn hình ảnh");
      } else if (type == "thành công") {
        CustomSnackbar.show(context,
            type: SnackbarType.success,
            title: "Thành công",
            message: "Hình ảnh đã được cập nhật thành công");
      } else {
        CustomSnackbar.show(context,
            type: SnackbarType.failure, title: "Lỗi", message: type);
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: false,
        bottom: false,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.zero,
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Column(
                  children: [
                    SizedBox(
                        height: 190,
                        width: double.infinity,
                        child: Image.asset(
                          'assets/images/edit_profile.jpg',
                          fit: BoxFit.cover,
                        )),
                    Container(
                      height: 70,
                    )
                  ],
                ),
                Positioned(
                  top: sizeBackground - 180,
                  left: size.width / 2 - 60,
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 40,
                        ),
                      ],
                    ),
                    child: SizedBox(
                      height: 115,
                      width: 115,
                      child: Stack(
                        fit: StackFit.expand,
                        clipBehavior: Clip.none,
                        children: [
                          Obx(() {
                            if (profilerController.isLoading.value) {
                              return const CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/images/no_user.jpg'),
                                child: Center(
                                    child: CircularProgressIndicator(
                                  backgroundColor: Colors.white,
                                )),
                              );
                            } else {
                              if (avatar.isNotEmpty) {
                                return Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color.fromRGBO(100, 100, 111, 0.3),
                                        offset: Offset(0, 5),
                                        blurRadius: 29,
                                      ),
                                    ],
                                  ),
                                  width: 100,
                                  height: 100,
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: widget.isMe
                                          ? const AvatarWidget()
                                          : ClipOval(
                                              child: Image.network(
                                                widget.avatar,
                                                fit: BoxFit.cover,
                                              ),
                                            )),
                                );
                              } else {
                                return const CircleAvatar(
                                  backgroundImage:
                                      AssetImage('assets/images/no_user.jpg'),
                                );
                              }
                            }
                          }),
                          widget.isMe
                              ? Positioned(
                                  right: -16,
                                  bottom: 0,
                                  child: SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: TextButton(
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                        )),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                const Color(0xffe3e3e3)),
                                      ),
                                      onPressed: () {
                                        showFloatingModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return SingleChildScrollView(
                                              child: SizedBox(
                                                height: 100,
                                                child: BottomSheetWidget(
                                                  snack: (type) {
                                                    snack(type);
                                                  },
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: SvgPicture.asset(
                                          "assets/svgs/camera.svg"),
                                    ),
                                  ),
                                )
                              : const SizedBox()
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 30,
                  left: 15,
                  width: 40,
                  height: 40,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: BackIcon(),
                  ),
                ),
              ],
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widget.isMe
                          ? TextFormField(
                              controller: _descriptionController,
                              maxLines: 100,
                              minLines: 1,
                              maxLength: 140,
                              cursorColor: AppColor.mainColor,
                              enabled: widget.isMe,
                              decoration: const InputDecoration(
                                hintText: 'Kể cho tôi nghe về bạn.',
                                fillColor: Colors.white,
                                filled: true,
                                contentPadding: EdgeInsets.only(
                                    top: 15, bottom: 15, left: 15),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                              ),
                              style: const TextStyle(
                                fontFamily: 'Loventine-Regular',
                              ),
                              onChanged: (value) {
                                if (value != widget.user!.about) {
                                  setState(() {
                                    isChange = true;
                                  });
                                } else {
                                  setState(() {
                                    isChange = false;
                                  });
                                }
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (checkText(value!)) {
                                  return "Văn bản chứa từ không phù hợp!";
                                }
                              },
                            )
                          : Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Center(
                                child: Text(
                                  _descriptionController.text,
                                  style: const TextStyle(
                                      fontFamily: 'Loventine-Regular',
                                      fontSize: 16),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                      const Divider(
                        color: AppColor.borderButton,
                      ),
                      Text(
                        'Họ và tên',
                        style: AppText.titleHeader(),
                      ),

                      const SizedBox(height: 10),
                      widget.isMe
                          ? TextFormField(
                              controller: _nameController,
                              maxLength: 40,
                              cursorColor: AppColor.mainColor,
                              decoration: const InputDecoration(
                                hintText: 'Ví dụ: Nguyễn Văn A',
                                fillColor: Colors.white,
                                filled: true,
                                contentPadding: EdgeInsets.only(
                                    top: 15, bottom: 15, left: 15),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                              ),
                              style: const TextStyle(
                                fontFamily: 'Loventine-Regular',
                              ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Điền Họ tên!";
                                } else {
                                  if (checkText(value)) {
                                    return "Văn bản chứa từ không phù hợp!";
                                  } else {
                                    return null;
                                  }
                                }
                              },
                              onChanged: (value) {
                                if (value != widget.user!.name) {
                                  setState(() {
                                    isChange = true;
                                  });
                                } else {
                                  setState(() {
                                    isChange = false;
                                  });
                                }
                              },
                            )
                          : Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: InfoProfile(
                                  text: _nameController.text,
                                  svgPath:
                                      'assets/svgs/Profile-Bold-32px.svg')),
                      const Divider(
                        color: AppColor.borderButton,
                      ),
                      Text(
                        'Ngày sinh',
                        style: AppText.titleHeader(),
                      ),
                      const SizedBox(height: 10),
                      widget.isMe
                          ? Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: TextFormField(
                                controller: _dateController,
                                cursorColor: AppColor.mainColor,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: IconButton(
                                      onPressed: () {
                                        customDatePicker(
                                          context,
                                          _dateController,
                                          initialDate: currentDateTime,
                                          onDateSelected: (p0) {
                                            if (p0 != null) {
                                              setState(() {
                                                currentDateTime = p0;
                                              });
                                            }
                                          },
                                        );
                                      },
                                      icon: SvgPicture.asset(
                                        'assets/svgs/calendar-edit.svg',
                                      )),
                                ),
                                style: const TextStyle(
                                  fontFamily: 'Loventine-Regular',
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  RegExp regex =
                                      RegExp(r'^\d{1,2}/\d{1,2}/\d{4}$');
                                  if (regex.hasMatch(value!) == false &&
                                      value.isNotEmpty) {
                                    return "Nhập định dạng dd/MM/yyyy";
                                  }
                                },
                                onChanged: (value) {
                                  if (value != widget.user!.birthday) {
                                    setState(() {
                                      isChange = true;
                                    });
                                  } else {
                                    setState(() {
                                      isChange = false;
                                    });
                                  }
                                },
                              ),
                            )
                          : InfoProfile(
                              text: _dateController.text,
                              svgPath: 'assets/svgs/calendar_b.svg'),
                      const SizedBox(height: 15),
                      const Divider(
                        color: AppColor.borderButton,
                      ),
                      Text('Giới tính', style: AppText.titleHeader()),
                      const SizedBox(height: 10),
                      widget.isMe
                          ? Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding:
                                  const EdgeInsets.only(left: 15, right: 10),
                              child: DropdownButton<String>(
                                value: sexValue,
                                borderRadius: BorderRadius.circular(12),
                                underline: const SizedBox(),
                                items: const [
                                  DropdownMenuItem<String>(
                                      value: "Không muốn trả lời",
                                      child: Text(
                                        "Không muốn trả lời",
                                        style: TextStyle(
                                          fontFamily: 'Loventine-Regular',
                                        ),
                                      )),
                                  DropdownMenuItem<String>(
                                      value: "Nam",
                                      child: Text(
                                        "Nam",
                                        style: TextStyle(
                                          fontFamily: 'Loventine-Regular',
                                        ),
                                      )),
                                  DropdownMenuItem<String>(
                                      value: "Nữ",
                                      child: Text(
                                        "Nữ",
                                        style: TextStyle(
                                          fontFamily: 'Loventine-Regular',
                                        ),
                                      )),
                                  DropdownMenuItem<String>(
                                      value: "Đồng tính nam",
                                      child: Text(
                                        "Đồng tính nam",
                                        style: TextStyle(
                                          fontFamily: 'Loventine-Regular',
                                        ),
                                      )),
                                  DropdownMenuItem<String>(
                                      value: "Đồng tính nữ",
                                      child: Text(
                                        "Đồng tính nữ",
                                        style: TextStyle(
                                          fontFamily: 'Loventine-Regular',
                                        ),
                                      )),
                                  DropdownMenuItem<String>(
                                      value: "Song tính",
                                      child: Text(
                                        "Song tính",
                                        style: TextStyle(
                                          fontFamily: 'Loventine-Regular',
                                        ),
                                      )),
                                  DropdownMenuItem<String>(
                                      value: "Chuyển giới",
                                      child: Text(
                                        "Chuyển giới",
                                        style: TextStyle(
                                          fontFamily: 'Loventine-Regular',
                                        ),
                                      )),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    if (value != widget.user!.sex) {
                                      sexValue = value!;
                                      isChange = true;
                                    } else {
                                      isChange = false;
                                      sexValue = value!;
                                    }
                                  });
                                },
                              ),
                            )
                          : InfoProfile(
                              text: sexValue, svgPath: 'assets/svgs/sex_b.svg'),
                      const SizedBox(height: 10),
                      const Divider(
                        color: AppColor.borderButton,
                      ),
                      Text('Email', style: AppText.titleHeader()),
                      const SizedBox(height: 10),
                      widget.isMe
                          ? TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              maxLines: null,
                              decoration: const InputDecoration(
                                hintText: 'Ví dụ: novauniversemail@gmail.com',
                                fillColor: Colors.white,
                                filled: true,
                                contentPadding: EdgeInsets.only(
                                    top: 15, bottom: 15, left: 15),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                              ),
                              style: const TextStyle(
                                fontFamily: 'Loventine-Regular',
                              ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Điền email!";
                                } else {
                                  RegExp regex = RegExp(r'^[^ ]+@gmail\.com$');
                                  if (!regex.hasMatch(value)) {
                                    return "Nhập định dạng @gmail.com";
                                  } else {
                                    if (isExistEmail) {
                                      return "Email đã tồn tại";
                                    } else {
                                      return null;
                                    }
                                  }
                                }
                              },
                              onChanged: (value) {
                                if (value != widget.user!.email) {
                                  setState(() {
                                    isChange = true;
                                  });
                                } else {
                                  setState(() {
                                    isChange = false;
                                  });
                                }
                              },
                            )
                          : InfoProfile(
                              text: _emailController.text,
                              svgPath: 'assets/svgs/at_sign_b.svg'),
                      const SizedBox(height: 15),
                      // const Text(
                      //   'Số điện thoại',
                      //   style: TextStyle(
                      //     fontFamily: 'Loventine-Black',
                      //     fontWeight: FontWeight.bold,
                      //     fontSize: 16,
                      //   ),
                      // ),
                      // const SizedBox(height: 10),
                      // widget.isMe
                      //     ? TextFormField(
                      //         controller: _phoneController,
                      //         keyboardType: TextInputType.number,
                      //         decoration: const InputDecoration(
                      //           hintText: 'Ví dụ: 0377712971',
                      //           fillColor: Colors.white,
                      //           filled: true,
                      //           contentPadding: EdgeInsets.only(
                      //               top: 15, bottom: 15, left: 15),
                      //           border: OutlineInputBorder(
                      //               borderSide: BorderSide.none,
                      //               borderRadius:
                      //                   BorderRadius.all(Radius.circular(10))),
                      //         ),
                      //         style: const TextStyle(
                      //           fontFamily: 'Loventine-Regular',
                      //         ),
                      //         autovalidateMode:
                      //             AutovalidateMode.onUserInteraction,
                      //         validator: (value) {
                      //           if (_emailController.text.isEmpty) {
                      //             if (value!.isEmpty) {
                      //               return "Điền số điện thoại!";
                      //             } else {
                      //               // Kiểm tra giá trị chỉ chứa các kí tự số
                      //               RegExp regex = RegExp(r'^[0-9]+$');
                      //               if (!regex.hasMatch(value)) {
                      //                 return "Điền số điện thoại!";
                      //               } else {
                      //                 if (isExistPhone) {
                      //                   return "Số điện thoại đã tồn tại";
                      //                 } else {
                      //                   return null;
                      //                 }
                      //               }
                      //             }
                      //           } else {
                      //             RegExp regex = RegExp(r'^[0-9]+$');
                      //             if (!regex.hasMatch(value!) &&
                      //                 value.isNotEmpty) {
                      //               return "Điền số điện thoại!";
                      //             } else {
                      //               return null;
                      //             }
                      //           }
                      //         },
                      //         onChanged: (value) {
                      //           if (value != widget.user!.phone) {
                      //             setState(() {
                      //               isChange = true;
                      //             });
                      //           } else {
                      //             setState(() {
                      //               isChange = false;
                      //             });
                      //           }
                      //         },
                      //       )
                      //     : ContainerText(
                      //         width: double.infinity,
                      //         text: _phoneController.text,
                      //       ),
                      // const SizedBox(height: 15),
                      const Divider(
                        color: AppColor.borderButton,
                      ),
                      Text('Địa chỉ', style: AppText.titleHeader()),
                      const SizedBox(height: 10),
                      widget.isMe
                          ? InkWell(
                              onTap: () {
                                showCupertinoModalBottomSheet(
                                        expand: false,
                                        context: context,
                                        backgroundColor: Colors.transparent,
                                        builder: (context) => AddAddress())
                                    .then((value) {
                                  if (value != null) {
                                    setState(() {
                                      _addressController.text = value;
                                      if (value != widget.user!.address) {
                                        isChange = true;
                                      } else {
                                        isChange = false;
                                      }
                                    });
                                  }
                                });
                              },
                              child: TextFormField(
                                enabled: false,
                                controller: _addressController,
                                onTap: () {},
                                maxLines: 3,
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                  hintText:
                                      'Ví dụ: Phường Linh Trung, TP. Thủ Đức',
                                  fillColor: Colors.white,
                                  filled: true,
                                  contentPadding: EdgeInsets.only(
                                      top: 15, bottom: 15, left: 15),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                ),
                                style: const TextStyle(
                                  fontFamily: 'Loventine-Regular',
                                  color: Colors.black,
                                ),
                                onChanged: (value) {
                                  if (value != widget.user!.address) {
                                    setState(() {
                                      isChange = true;
                                    });
                                  } else {
                                    setState(() {
                                      isChange = false;
                                    });
                                  }
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (checkText(value!)) {
                                    return "Văn bản chứa từ không phù hợp!";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            )
                          : InfoProfile(
                              text: _addressController.text,
                              svgPath: 'assets/svgs/address_b.svg'),
                      const SizedBox(height: 20),
                      widget.isMe
                          ? Align(
                              child: ActionButton(
                                text: 'Lưu',
                                isChange: isChange,
                                isLoading: isLoading,
                                onTap: () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    updateUser();
                                  }
                                },
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        //

        //
      ),
      //

      //
    );
  }
}
