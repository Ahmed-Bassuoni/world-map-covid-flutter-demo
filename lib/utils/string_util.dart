abstract class StringUtil {
  static bool isEmptyOrNull(String? strValue) {
    return strValue == null || (strValue.trim().isEmpty);
  }

  static bool isNotEmptyOrNull(String? strValue) {
    return !isEmptyOrNull(strValue);
  }
}
