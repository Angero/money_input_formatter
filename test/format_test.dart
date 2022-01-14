import 'package:flutter_test/flutter_test.dart';
import 'package:money_input_formatter/money_text_input_formatter.dart';

void main() {
  test('format', () {
    expect(MoneyTextInputFormatter.format('', '0'), '0');
    expect(MoneyTextInputFormatter.format('', '01'), '');
    expect(MoneyTextInputFormatter.format('', '0,'), '0,');
    expect(MoneyTextInputFormatter.format('', '1'), '1');
    expect(MoneyTextInputFormatter.format('', '1,0'), '1,0');
    expect(MoneyTextInputFormatter.format('', '1,00'), '1,00');
    expect(MoneyTextInputFormatter.format('1,00', '1,000'), '1,00');
    expect(MoneyTextInputFormatter.format('1,', '1,,'), '1,');
    expect(MoneyTextInputFormatter.format('1,', '1,0,'), '1,');
    expect(MoneyTextInputFormatter.format('', ','), '');
    expect(MoneyTextInputFormatter.format('1', ',1'), '1');
    expect(MoneyTextInputFormatter.format('', '1234'), '1 234');
    expect(MoneyTextInputFormatter.format('', '1234,5'), '1 234,5');
    expect(MoneyTextInputFormatter.format('', '1234,56'), '1 234,56');
    expect(MoneyTextInputFormatter.format('777', '1234,567'), '777');
    expect(MoneyTextInputFormatter.format('777', '12345678,90'), '12 345 678,90');
  });

  test('thousand', () {
    expect(MoneyTextInputFormatter.thousand('123'), '123');
    expect(MoneyTextInputFormatter.thousand('1234'), '1 234');
    expect(MoneyTextInputFormatter.thousand('12345'), '12 345');
    expect(MoneyTextInputFormatter.thousand('123456'), '123 456');
    expect(MoneyTextInputFormatter.thousand('1234567'), '1 234 567');
    expect(MoneyTextInputFormatter.thousand('12345678'), '12 345 678');
    expect(MoneyTextInputFormatter.thousand('123456789'), '123 456 789');
    expect(MoneyTextInputFormatter.thousand('1234567890'), '1 234 567 890');
  });

  test('zero', () {
    expect(MoneyTextInputFormatter.zero(''), '0,00');
    expect(MoneyTextInputFormatter.zero('123'), '123,00');
    expect(MoneyTextInputFormatter.zero('123,'), '123,00');
    expect(MoneyTextInputFormatter.zero('123,4'), '123,40');
    expect(MoneyTextInputFormatter.zero('123,45'), '123,45');
  });

}
