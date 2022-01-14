import 'package:flutter/services.dart';

class MoneyTextInputFormatter extends TextInputFormatter {

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if(newValue.selection.baseOffset == 0){
      return newValue;
    }

    String newText = newValue.text + ' ₽';
    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newValue.text.length));

    // double value = double.parse(newValue.text);
    // final formatter = NumberFormat("#,##0.00", "ru_RU");
    // String newText = "R\$ " + formatter.format(value/100);
    //
    // return newValue.copyWith(
    //     text: newText,
    //     selection: new TextSelection.collapsed(offset: newText.length));
  }

  static String format(String oldValue) {
    return 'asd';
  }
}

