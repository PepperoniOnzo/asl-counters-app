import 'validation_util.dart';

class ErrorTextUtil {
  static String? isNotEmpty(
          {required String val, required String leadingText}) =>
      val.isEmpty ? 'S.current.nameMustBeNotEmpty(leadingText)' : null;

  static String? isMoreThanEightSymbolsError(
          {required String val, required String leadingText}) =>
      ValidationUtil.isMoreThan8(val)
          ? null
          : 'S.current.leadingtextMustBeAtLeast8Characters(leadingText)';

  static String? isEmailError(String email) {
    if (!ValidationUtil.isEmail(email)) {
      return 'S.current.incorrectEmail';
    }

    return null;
  }

  static String? isPasswordError(String password) {
    if (!ValidationUtil.isMoreThan8(password)) {
      return 'S.current.passwordMustBeAtLeast8Characters';
    }
    if (!ValidationUtil.isPassword(password)) {
      return 'S.current.passwordMustIncludeAtLeastOneSpecialSymbolOrElse';
    }

    return null;
  }
}
