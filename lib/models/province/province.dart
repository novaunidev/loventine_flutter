/// [VietnamDivisionType] this is enum type of division in Vietnam
enum VietnamDivisionType {
  // Level 1
  TINH,
  THANH_PHO_TRUNG_UONG,
  // Level 2
  HUYEN,
  QUAN,
  THANH_PHO,
  THI_XA,
  // Level 3
  XA,
  THI_TRAN,
  PHUONG,
}
/// [VnBase] define base information of a division
class VnBase {
  String name;
  int code;
  VietnamDivisionType divisionType;
  String codename;

  VnBase(this.name, this.code, this.divisionType, this.codename);

  @override
  String toString() {
    return this.codename;
  }
}
/// [VNProvince] define base information of a Province
class VNProvince extends VnBase {
  int phoneCode;

  VNProvince(String name, int code, VietnamDivisionType divisionType,
      String codename, this.phoneCode)
      : super(name, code, divisionType, codename);
}
/// [VNDistrict] define base information of a District
class VNDistrict extends VnBase {
  int provinceCode;

  VNDistrict(String name, int code, VietnamDivisionType divisionType,
      String codename, this.provinceCode)
      : super(name, code, divisionType, codename);
}
/// [VNWard] define base information of a ward
class VNWard extends VnBase {
  int districtCode;

  VNWard(String name, int code, VietnamDivisionType divisionType,
      String codename, this.districtCode)
      : super(name, code, divisionType, codename);
}
