class UtilsFunctions {

  static String capitalizeFirstLetter(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1);
  }

  static  String removeAllWhitespace(String input) {
    return input.replaceAll(RegExp(r'\s+'), '');
  }
}