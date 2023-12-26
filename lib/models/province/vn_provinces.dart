import 'package:loventine_flutter/data/district.dart';
import 'package:loventine_flutter/data/province.dart';
import 'package:loventine_flutter/data/ward.dart';
import 'package:slug_it/slug_it.dart';

import 'province.dart';

/// VNProvinces.
class VNProvinces {
  /// Returns [VNProvince] fetch all province in vietnam.
  List<String> allProvince({keyword: String}) {
    List<VNProvince> provinces = [];
    provinces = vnProvinces.values.toList();
    if (keyword != null) {
      keyword = SlugIT().makeSlug(keyword, separator: '_');
      provinces = provinces
          .where((element) => element.codename.contains(keyword))
          .toList();
    }

    return provinces.map((province) => province.name).toList();
  }

  /// Returns [VNDistrict] fetch all district by [provinceCode] in vietnam.
  List<String> allDistrict(int provinceCode, {keyword: String}) {
    List<VNDistrict> districts = [];
    var districtsRaw = vnDistricts.values.toList();
    if (keyword != null) {
      keyword = SlugIT().makeSlug(keyword, separator: '_');
      districts = districtsRaw
          .where((element) =>
              element.provinceCode == provinceCode &&
              element.codename.contains(keyword))
          .toList();
    } else {
      districts = districtsRaw
          .where((element) => element.provinceCode == provinceCode)
          .toList();
    }
    return districts.map((district) => district.name).toList();
  }

  /// Returns [VNWard] fetch all ward by [districtCode] in vietnam.
  List<String> allWard(int districtCode, {keyword: String}) {
    List<VNWard> wards = [];
    var wardRaw = vnWards.values.toList();
    if (keyword != null) {
      keyword = SlugIT().makeSlug(keyword, separator: '_');
      wards = wardRaw
          .where((element) =>
              element.districtCode == districtCode &&
              element.codename.contains(keyword))
          .toList();
    } else {
      wards = wardRaw
          .where((element) => element.districtCode == districtCode)
          .toList();
    }
    return wards.map((ward) => ward.name).toList();
  }
}
