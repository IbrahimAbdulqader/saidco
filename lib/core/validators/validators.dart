String? validateString(String? input, String? errorMessage) {
  if (input == null || input.trim().isEmpty) {
    return errorMessage;
  }

  return null;
}

String? validatePhoneNumber(String? input) {
  final regex = RegExp(r'^01[0125]\d{8}$');

  if (input == null || input.trim().isEmpty) {
    return 'برجى إدخال رقم الهاتف';
  } else if (!regex.hasMatch(input)) {
    return 'رقم الهاتف غير صالح';
  }

  return null;
}

String? validateDate(DateTime? value) {
  if (value == null) {
    return 'بجب اختيار تاريخ السفر';
  }

  return null;
}
