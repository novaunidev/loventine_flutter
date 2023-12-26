import 'src/bruteforce.dart';
import 'src/common.dart';

double estimatePasswordStrength(String password) {
  return estimateBruteforceStrength(password) *
      estimateCommonDictionaryStrength(password);
}
