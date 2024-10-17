class Utils {
  static String extraErrorMessage(dynamic ex) {
    try {
      return ex.toString();
    } catch (e) {
      return e.toString();
    }
  }
}
