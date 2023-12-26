import 'package:flutter/material.dart';

class ColorInPage {
  static const blackColor = Color(0xFF0D0D26);
  static const backgroudColor = Color(0xFFFAFAFD);
  static const textColor = Color(0xFF000000);
}

class TermsOfService extends StatefulWidget {
  const TermsOfService({Key? key}) : super(key: key);

  @override
  State<TermsOfService> createState() => _TermsOfServiceState();
}

class _TermsOfServiceState extends State<TermsOfService> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = AppBar(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0))),
      elevation: 0.0,
      leading: const SizedBox(height: 0),
      backgroundColor: const Color(0xFFF2F2F7),
      centerTitle: true,
      title: const Text(
        'Điều khoản dịch vụ',
        style: TextStyle(
            fontFamily: 'Rotobo',
            color: ColorInPage.textColor,
            fontSize: 23,
            wordSpacing: 2,
            fontWeight: FontWeight.w400),
      ),
      actions: [
        Container(
            margin: const EdgeInsets.fromLTRB(24, 0, 0, 0),
            child: TextButton(
              child: const Text(
                'OK',
                style: TextStyle(
                    fontFamily: 'SMProText',
                    color: Color(0xFF007AFF),
                    fontSize: 17,
                    fontWeight: FontWeight.w400),
              ),
              onPressed: () {
                print('Exit terms of service page');
                Navigator.pop(context);
              },
            )),
      ],
    );
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: appBar,
      body: SingleChildScrollView(
        child: Container(
          height: (!isLandscape)
              ? (mediaQuery.size.height -
                  appBar.preferredSize.height -
                  mediaQuery.padding.top)
              : 500,
          color: Colors.white,
          child: Container(
            height: (!isLandscape)
                ? (mediaQuery.size.height -
                    appBar.preferredSize.height -
                    mediaQuery.padding.top)
                : 500,
            margin: const EdgeInsets.fromLTRB(24, 0, 24, 0),
            child: RichText(
              text: const TextSpan(
                text:
                    '\n1. Người dùng cam kết và đảm bảo rằng là một cá nhân về mặt pháp lý có toàn quyền tham gia giao kết thoả thuận theo pháp luật nước Cộng hoà Xã hội chủ nghĩa Việt Nam\n\n2. Chúng tôi thu thập và xử lý thông tin của bạn như là tên, số điện thoại, địa chỉ email khi bạn đăng ký. Bạn phải cung cấp chính xác và đầy đủ thông tin, cập nhật thông tin và đồng ý cung cấp cho chúng tôi bất kì thông tin nào để xác thực danh tính. Nếu thông tin bạn cung cấp cho chúng tôi thay đổi ví dụ, nếu bạn thay đổi địa chỉ email, hoặc nếu bạn muốn hủy tài khoản, xin vui lòng cập nhật chi tiết bằng cách gửi yêu cầu đến chúng tôi.\n\n 3. Bạn có thể thanh toán một phần hoặc toàn bộ nội dụng của ứng dụng bằng cách thanh toán cho chúng tôi. Giá của sản phẩm sẽ tùy thuộc vào gói sản phẩm bạn lựa chọn.\n\n4. Chỉ bạn sử dụng tài khoản của mình và đảm bảo không cho người khác sử dụng danh tính hay tài khoản của bạn.\n\n5. Bạn cam kết rằng chỉ sử dụng ứng dụng cho mục đích cá nhân. Không được phép lạm dụng ứng dụng cho việc đánh cắp thông tin hoặc cho các mục đích gian lận khác.',
                style: TextStyle(
                    fontFamily: 'Rotobo',
                    color: ColorInPage.textColor,
                    fontSize: 17,
                    wordSpacing: 0,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
