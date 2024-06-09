class Validations {
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) return 'الرجاء ادخال الاسم';
    final RegExp nameExp = RegExp(r'^[\u0621-\u064A ]+$');
    if (!nameExp.hasMatch(value)) {
      return 'احرف ابجدية عربية فقط';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'الرجاء ادخال البريد الالكنروني';
    final RegExp nameExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,2"
        r"53}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-z"
        r"A-Z0-9])?)*$");
    if (!nameExp.hasMatch(value)) return 'بريد الكتروني غير صالح';
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'الرجاء إدخال كلمة المرور';
    }
    return null;
  }

  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'الرجاء إدخال اسم المستخدم';
    }
    final RegExp nameExp = RegExp(r'^[a-zA-Z][a-zA-Z0-9._]{0,29}$');
    if (!nameExp.hasMatch(value)) {
      return 'احرف انجليزية وارقام ونقط و _ ويبدأ بحرف';
    }
    return null;
  }
}
