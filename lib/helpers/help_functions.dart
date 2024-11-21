class HelperFunctions {
  static firstLetterUppecase(String stringToConvert) {
    // i convert the first letter to Uppercase and then i combine that letter with the original string but substring the first letter
    return '${stringToConvert[0].toUpperCase()}${stringToConvert.substring(1)}';
  }
}
