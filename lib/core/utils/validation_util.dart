abstract class ValidationUtil {
  static bool isEmail(String val) => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(val);

  static bool isContainsUppercase(String val) =>
      RegExp(r'^[A-Z]+$').hasMatch(val);

  static bool isPassword(String val) =>
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[#?!@$%^&*-,.]).+$')
          .hasMatch(val);

  static bool isMoreThan8(String val) => val.length >= 8;
}
