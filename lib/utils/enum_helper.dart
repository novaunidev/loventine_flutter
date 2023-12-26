part of 'enum.dart';

/// Workaround to achieve enum with value (like in `C#`)
class EnumHelper {
  static int getValue<T>(Map<T, MyEnum> enumMap, T myEnum) {
    if (myEnum == null) {
      return -2;
    }

    return enumMap[myEnum]!.value;
  }

  static String getDescription<T>(Map<T, MyEnum> enumMap, T myEnum) {
    if (myEnum == null) {
      return '';
    }

    return enumMap[myEnum]!.description;
  }

  static T getEnum<T>(Map<T, MyEnum> enumMap, int value) {
    return enumMap.keys.firstWhere(
      (key) => enumMap[key]!.value == value,
      // orElse: () => null,
    );
  }

  static T getEnumFromDescription<T>(
      Map<T, MyEnum> enumMap, String description) {
    return enumMap.keys.firstWhere(
      (key) => enumMap[key]!.description == description,
      // orElse: () => null,
    );
  }
}

class MyEnum {
  late int value;
  late String description;

  MyEnum({required this.value, required this.description});
}

class EnumMap {
  static Map<AdviseType, MyEnum> adviseTypeValue = {
    AdviseType.package: MyEnum(value: 0, description: 'Trọn gói'),
    AdviseType.daily: MyEnum(value: 1, description: 'Theo ngày'),
    AdviseType.hourly: MyEnum(value: 2, description: 'Theo giờ'),
    AdviseType.monthly: MyEnum(value: 3, description: 'Theo tháng'),
    AdviseType.yearly: MyEnum(value: 3, description: 'Theo năm'),
  };
}
