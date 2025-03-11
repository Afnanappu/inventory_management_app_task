class CustomRegExp {
  static bool email(String? value) {
    if (value == null) return false;
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value);
  }

  static bool checkEmptySpaces(String value) {
    return RegExp(r'^\s*$').hasMatch(value);
  }

  static bool checkPhoneNumber(String? value) {
    if (value == null || value.length < 10) {
      return false;
    }
    return RegExp(r'^[0-9]{10}$').hasMatch(value);
  }

  static bool checkNumberOnly(String value) {
    return RegExp(r'^[1-9]\d*$').hasMatch(value);
  }

  static bool checkName(String? value) {
    if (value == null) {
      return false;
    }
    return RegExp(r'^[a-zA-Z\s]+$').hasMatch(value);
  }
}
