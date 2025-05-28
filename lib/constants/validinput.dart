class ValidationUtils {
  // Method to check if the username is valid
  static bool isUsername(String val) {
    // A basic username validation (you can customize this regex)
    final RegExp usernameRegex = RegExp(r'^[a-zA-Z0-9_]{3,16}$');
    return usernameRegex.hasMatch(val);
  }

  static bool isEmail(String val) {
    // A basic username validation (you can customize this regex)
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(val);
  }

  static bool isPhoneNumber(String val) {
    // A basic username validation (you can customize this regex)
    final RegExp phoneNumberRegex = RegExp(
      r'^\+?[0-9]{1,4}?[-. \(\)]?([0-9]{1,3}[-. \(\)]?){1,4}[0-9]{1,4}$',
    );
    return phoneNumberRegex.hasMatch(val);
  }

  static bool isPassword(String val) {
    // A basic username validation (you can customize this regex)
    final RegExp passwordRegex = RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
    );
    return passwordRegex.hasMatch(val);
  }
}

validInput(String val, int min, int max, String type) {
  if (type == "username") {
    if (!ValidationUtils.isUsername(val)) {
      return "Not Valid Username";
    }
  }

  if (type == "email") {
    if (!ValidationUtils.isEmail(val)) {
      return "Not Valid Email";
    }
  }

  if (type == "phone") {
    if (!ValidationUtils.isPhoneNumber(val)) {
      return "Not Valid Phone Number";
    }
  }

  /*   if (type == "password") {
    if (!ValidationUtils.isPassword(val)) {
      return "poor password";
    }
  }
 */
  if (val.isEmpty) {
    return " Can't be Empty";
  }

  if (val.length < min) {
    return "Can't be Less Than $min";
  }

  if (val.length > max) {
    return "Can't  be Larger Than $max";
  }
}
