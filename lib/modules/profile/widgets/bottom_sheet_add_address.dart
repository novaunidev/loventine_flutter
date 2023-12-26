import 'package:flutter/material.dart';
import 'package:loventine_flutter/data/district.dart';
import 'package:loventine_flutter/data/province.dart';
import 'package:loventine_flutter/modules/profile/widgets/check_text.dart';
import 'package:loventine_flutter/widgets/button/action_button.dart';
import 'package:loventine_flutter/widgets/custom_dropdown/custom_dropdown.dart';

import '../../../models/province/vn_provinces.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({super.key});

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  final provinceController = TextEditingController();
  final districtController = TextEditingController();
  final wardController = TextEditingController();
  final descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<String> provinces = VNProvinces().allProvince(keyword: "");
  List<String> districts = VNProvinces().allDistrict(1, keyword: "");
  List<String> wards = VNProvinces().allWard(1, keyword: "");
  bool isShowDistrict = false;
  bool isShowWard = false;
  int codeProvince = 1;
  int codeDistrict = 1;
  bool isChange = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFC),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            const Text(
              'Thêm Địa Chỉ',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            CustomDropdown.search(
              hintText: 'Tỉnh/Thành Phố',
              controller: provinceController,
              items: provinces,
              onChanged: (p0) {
                vnProvinces.forEach((key, value) {
                  if (value.name == provinceController.text) {
                    districtController.clear();
                    wardController.clear();
                    setState(() {
                      codeProvince = value.code;
                      districts =
                          VNProvinces().allDistrict(value.code, keyword: "");
                      isShowDistrict = true;
                      isShowWard = false;
                      isChange = true;
                    });
                  }
                });
              },
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              height: isShowDistrict ? 40 : 0,
              child: CustomDropdown.search(
                hintText: 'Quận/Huyện',
                controller: districtController,
                items: districts,
                fieldSuffixIcon: isShowDistrict
                    ? Icon(
                        Icons.expand_more,
                        color: Colors.black,
                      )
                    : SizedBox(),
                onChanged: (p0) {
                  vnDistricts.forEach((key, value) {
                    if (value.name == districtController.text) {
                      wardController.clear();
                      setState(() {
                        codeDistrict = value.code;
                        wards = VNProvinces().allWard(value.code, keyword: "");
                        isShowWard = true;
                        isChange = true;
                      });
                    }
                  });
                },
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              height: isShowWard ? 40 : 0,
              child: CustomDropdown.search(
                hintText: 'Phường/Xã',
                controller: wardController,
                items: wards,
                fieldSuffixIcon: isShowWard
                    ? Icon(
                        Icons.expand_more,
                        color: Colors.black,
                      )
                    : SizedBox(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Form(
              key: _formKey,
              child: TextFormField(
                controller: descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'Tên đường, Tòa nhà, Số nhà.',
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding:
                      EdgeInsets.only(top: 15, bottom: 15, left: 15),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
                style: TextStyle(
                  fontFamily: 'Loventine-Regular',
                ),
                onChanged: (value) {
                  setState(() {
                    isChange = true;
                  });
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (checkText(value!)) {
                    return "Văn bản chứa từ không phù hợp!";
                  } else {
                    return null;
                  }
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ActionButton(
                isChange: isChange,
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    String text = "";
                    if (descriptionController.text.isNotEmpty) {
                      text += descriptionController.text;
                    }
                    if (wardController.text.isNotEmpty) {
                      if (descriptionController.text.isEmpty) {
                        text += wardController.text;
                      } else {
                        text += ", ${wardController.text}";
                      }
                    }
                    if (districtController.text.isNotEmpty) {
                      if (descriptionController.text.isEmpty &&
                          wardController.text.isEmpty) {
                        text += districtController.text;
                      } else {
                        text += ", ${districtController.text}";
                      }
                    }
                    if (provinceController.text.isNotEmpty) {
                      if (descriptionController.text.isEmpty &&
                          wardController.text.isEmpty &&
                          districtController.text.isEmpty) {
                        text += provinceController.text;
                      } else {
                        text += ", ${provinceController.text}";
                      }
                    }
                    isChange ? Navigator.pop(context, text) : {};
                  }
                },
                text: "Lưu",
                isLoading: false)
          ],
        ),
      ),
    );
  }
}
