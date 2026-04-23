String? validateString(String? input, String? errorMessage) {
  if (input == null || input.trim().isEmpty) {
    return errorMessage;
  }

  return null;
}

String? validateDate(DateTime? value) {
  if (value == null) {
    return 'بجب اختيار تاريخ السفر';
  }

  return null;
}
