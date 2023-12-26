import 'package:loventine_flutter/services/apply/apply_service.dart';

/*
dart run ./lib/test/service/apply.dart
*/
void main() async {
  var result;
  // result = await ApplyService.create('646c5b063f191e31bccc2b34', null, null, null,
  //     '63534b4cd31f80d15177665b', "635180574c3d037328084ac2");

  result = await ApplyService.getOne("64b6a327a7b981938ac69fd5");

  // result = await ApplyService.gets(
  //     null,
  //     null,
  //     null,
  //     null,
  //     null,
  //     null,
  //     null,
  //     DELETE_STATE.NONE,
  //     0,
  //     100,
  //     null,
  //     null,
  //     null,
  //     null,
  //     "63534b4cd31f80d15177665b");

  // result = await ApplyService.update("64b6a327a7b981938ac69fd5",
  //     "6432316b0eaa53a7354ca8b7", null, 'my leetter ok', null);

  // result = await ApplyService.updateState(
  //     "64b6a327a7b981938ac69fd5", APPLY_STATE.DECLINED, DEFAULT.EMPTY_STRING);

  // if(_val is String)
  print(result.runtimeType);
  print(result);
}
