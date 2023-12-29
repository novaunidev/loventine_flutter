import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loventine_flutter/models/chat/get.dart';

import 'package:group_button/group_button.dart';

import 'package:loventine_flutter/pages/home/chat/pages/search/search_result_page.dart';
import 'package:loventine_flutter/pages/home/chat/widgets/all_type_page.dart';
import 'package:loventine_flutter/pages/home/chat/widgets/same_type_page.dart';
import 'package:loventine_flutter/providers/chat/chat_room_provider.dart';
import 'package:loventine_flutter/values/app_color.dart';
import 'package:loventine_flutter/widgets/app_text.dart';
import 'package:loventine_flutter/widgets/shimmer_simple.dart';

import 'package:provider/provider.dart';

import '../../../constant.dart';

class MessagePage extends StatefulWidget {
  MessagePage({Key? key}) : super(key: key);

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  late GroupButtonController controller = GroupButtonController(
    selectedIndex: 0,
    selectedIndexes: [0],
  );

  final List<String> choices = chat_room_type;

  late String itemSelectedString = all;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ChatRoomProvider>(context, listen: false).getChatRooms({});
    });
  }

  void changeitemSelectedString(String choice) {
    setState(() {
      itemSelectedString = choice;
      if (choice == my_jobs) {
        controller.selectIndex(1);
        controller.selectIndexes([1]);
      }
      if (choice == my_hirings) {
        controller.selectIndex(2);
        controller.selectIndexes([2]);
      }
      if (choice == matching) {
        controller.selectIndex(3);
        controller.selectIndexes([3]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    List<ChatRoom> chatRooms =
        Provider.of<ChatRoomProvider>(context, listen: true).chatRooms;
    List<ChatRoom> list = chatRooms.where((chatRoom) {
      if (itemSelectedString == all) {
        return true;
      }
      if (itemSelectedString == matching) {
        if (chatRoom.type == 'matching') return true;
      } else {
        if (chatRoom.type == 'job') {
          if (itemSelectedString == my_jobs) {
            if (chatRoom.isConsultant) return true;
          }
          if (itemSelectedString == my_hirings) {
            if (chatRoom.isConsultant == false) return true;
          }
        }
      }

      return false;
    }).toList();

    final isLoading =
        Provider.of<ChatRoomProvider>(context, listen: true).isLoading;

    final search_bar = GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SearchResultPage(chatRooms),
          ),
        );
      },
      child: Container(
        height: 40,
        width: width - 10,
        decoration: BoxDecoration(
          color: const Color(0xffeef2f3),
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              SvgPicture.asset(
                "assets/svgs/search-favorite-1_l.svg",
                color: AppColor.deleteBubble,
                height: 20,
              ),
              const SizedBox(width: 15),
              Text("Tìm kiếm", style: AppText.describeText())
            ],
          ),
        ),
      ),
    );

    // final filter_bar = SingleChildScrollView(
    //   physics: const BouncingScrollPhysics(),
    //   scrollDirection: Axis.horizontal,
    //   child: GroupButton(
    //     controller: controller,
    //     options: GroupButtonOptions(
    //       selectedTextStyle: AppText.contentBold(color: Colors.white),
    //       unselectedTextStyle: const TextStyle(
    //         color: Colors.white,
    //         fontFamily: 'Loventine-Regular',
    //         fontSize: 15,
    //       ),

    //       selectedColor: AppColor.mainColor,
    //       unselectedColor: AppColor.mainColor.withOpacity(0.2),
    //       borderRadius: BorderRadius.circular(97),
    //       // unselectedBorderColor: const Color(0xFF95969D),

    //       selectedBorderColor: AppColor.mainColor,
    //       selectedShadow: const [
    //         BoxShadow(
    //           color: ColorInPage.backgroudColor,
    //           blurRadius: 25.0,
    //           spreadRadius: 1.0,
    //           offset: Offset(
    //             0.0,
    //             2.0,
    //           ),
    //         ),
    //       ],
    //       unselectedShadow: const [
    //         BoxShadow(
    //           color: ColorInPage.backgroudColor,
    //           blurRadius: 25.0,
    //           spreadRadius: 1.0,
    //           offset: Offset(
    //             0.0,
    //             2.0,
    //           ),
    //         ),
    //       ],
    //       //direction: Axis.vertical,
    //       groupingType: GroupingType.row,
    //     ),
    //     isRadio: true,
    //     onSelected: (index, isSelected, value) {
    //       print(index);
    //       itemSelectedString = index.toString();
    //       // resetApplySelected();
    //       setState(() {});
    //     },
    //     buttons: choices,
    //   ),
    // );

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            title: Text(
              ' Tin nhắn',
              style: AppText.contentBold(fontSize: 25),
            ),
            floating: true,
            snap: true,
            elevation: 0,
            backgroundColor: const Color(0xfffafafa),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 65),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 15),
                  if (isLoading) ShimmerSimple(),
                  // if (!isLoading) ...chatrooms_list,
                  if (!isLoading && itemSelectedString == all)
                    AllTypePage(chatRooms, changeitemSelectedString),
                  if (!isLoading && itemSelectedString != all)
                    SameTypePage(list),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ColorInPage {
  static const blackColor = Color(0xFF0D0D26);
  static const backgroudColor = Color(0xFFFAFAFD);
  static const textColor = Color(0xFF000000);
  static const backgroundAppBar = Color(0xFF356899);
  static const buttonColor = Color(0xFF537fa8);
}
