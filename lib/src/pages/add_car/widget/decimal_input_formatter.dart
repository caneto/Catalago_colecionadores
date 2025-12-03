import 'package:flutter/services.dart';

class DecimalInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String newText = newValue.text;

    if (newText.isEmpty) {
      return newValue;
    }

    // Allow only one comma
    if (',,'.allMatches(newText).length > 1) {
      return oldValue;
    }

    // Check decimal places
    if (newText.contains(',')) {
      final parts = newText.split(',');
      if (parts.length > 1 && parts[1].length > 2) {
        return oldValue;
      }
    }

    return newValue;
  }
}
