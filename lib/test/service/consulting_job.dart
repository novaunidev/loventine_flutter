import 'package:loventine_flutter/constant.dart';
import 'package:loventine_flutter/services/apply/consultingJob_service.dart';

/*
dart run ./lib/test/service/consulting_job.dart
*/
void main() async {
  var result;

  result = await ConsultingJobService.update(
      '64b7f75424f5417df4fecd69',
      '635180574c3d037328084ac2',
      CONSULTING_JOB_ACTION_STATE_TYPE_NAME.START,
      CONSULTING_JOB_ACTION_STATE.WANT,
      null);

  print(result);
}
