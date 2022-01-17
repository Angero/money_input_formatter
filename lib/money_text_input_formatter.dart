import 'package:flutter/services.dart';

/// It you do not want to use kopecks set decimalSeparator empty like this.
/// decimalSeparator = ''

class MoneyTextInputFormatter extends TextInputFormatter {
  final String decimalSeparator;
  final String thousandSeparator;
  final int? maxLeft;
  final String emptyText;

  MoneyTextInputFormatter(
      {this.decimalSeparator = ',',
      this.thousandSeparator = ' ',
      this.maxLeft,
      this.emptyText = '0,00'});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    String newText = '';
    newText = format(oldValue.text, newValue.text,
        decimalSeparator: decimalSeparator,
        thousandSeparator: thousandSeparator,
        maxLeft: maxLeft);

    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length));
  }

  static String format(String oldText, String newText,
      {String decimalSeparator = ',',
      String thousandSeparator = ' ',
      int? maxLeft}) {
    assert(decimalSeparator != thousandSeparator);
    if (newText.substring(0, 1) == '0' &&
        newText.length > 1 &&
        newText.substring(1, 2) != decimalSeparator) {
      return oldText;
    }
    if (newText.substring(0, 1) == decimalSeparator) {
      return oldText;
    }
    newText = newText.replaceAll(thousandSeparator, '');
    String result = '';
    String left = '';
    if (newText.contains(decimalSeparator) && decimalSeparator != '') {
      int i = newText.indexOf(decimalSeparator);
      if (i == 0) return oldText;
      if (newText.contains(decimalSeparator, i + 1)) return oldText;
      left = newText.substring(0, i);
      if (maxLeft != null) {
        if (left.length > maxLeft) {
          return oldText;
        }
      }
      String right = newText.substring(i + 1);
      if (right.length > 2) return oldText;
      left = MoneyTextInputFormatter.thousand(left,
          thousandSeparator: thousandSeparator);
      result = left + decimalSeparator + right;
    } else {
      left = newText;
      if (maxLeft != null) {
        if (left.length > maxLeft) {
          return oldText;
        }
      }
      result = MoneyTextInputFormatter.thousand(left,
          thousandSeparator: thousandSeparator);
    }

    return result;
  }

  static String thousand(String s, {String thousandSeparator = ' '}) {
    String result = '';
    int count = (s.length / 3).floor();
    if (count == 0) return s;
    int shift = s.length % 3;
    if (shift > 0) {
      result = s.substring(0, shift) + thousandSeparator;
    }
    for (int i = 0; i < count; i++) {
      int start = shift + (3 * i);
      int finish = start + 3;
      result += s.substring(start, finish) + thousandSeparator;
    }
    if (result.substring(result.length - 1) == thousandSeparator) {
      return result.substring(0, result.length - 1);
    } else {
      return result;
    }
  }

  String zero(String s) {
    if (decimalSeparator.isEmpty) return s;
    if (s.isEmpty) return '0' + decimalSeparator + '00';
    if (s.contains(decimalSeparator)) {
      int i = s.indexOf(decimalSeparator);
      String right = s.substring(i + 1);
      if (right.isEmpty) {
        return s + '00';
      } else if (right.length == 1) {
        return s + '0';
      } else {
        return s;
      }
    } else {
      return s + decimalSeparator + '00';
    }
  }

  TextInputType get keyboardType =>
      TextInputType.numberWithOptions(decimal: decimalSeparator.isNotEmpty);

  String get hintText => emptyText;

  static String fromInt(int? value) {
    if (value == null) return '';
    if (value == 0) return '';
    return thousand(value.toString());
  }

  static String fromDouble(double? value) {
    if (value == null) return '';
    if (value == 0) return '';
    return thousand(value.floor().toString());
  }

  static double toDouble(String value) {
    value = value.replaceAll(' ', '').trim();
    return double.parse(value);
  }

}
