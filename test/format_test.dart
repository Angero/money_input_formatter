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
    expect(
        MoneyTextInputFormatter.format('777', '12345678,90'), '12 345 678,90');
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

  test('thousand separator', () {
    expect(MoneyTextInputFormatter.thousand('123', thousandSeparator: '_'), '123');
    expect(MoneyTextInputFormatter.thousand('1234', thousandSeparator: '_'), '1_234');
    expect(MoneyTextInputFormatter.thousand('12345', thousandSeparator: '_'), '12_345');
    expect(MoneyTextInputFormatter.thousand('123456', thousandSeparator: '_'), '123_456');
    expect(MoneyTextInputFormatter.thousand('1234567', thousandSeparator: '_'), '1_234_567');
    expect(MoneyTextInputFormatter.thousand('12345678', thousandSeparator: '_'), '12_345_678');
    expect(MoneyTextInputFormatter.thousand('123456789', thousandSeparator: '_'), '123_456_789');
    expect(MoneyTextInputFormatter.thousand('1234567890', thousandSeparator: '_'), '1_234_567_890');
  });


  test('zero', () {
    final _moneyFormatter = MoneyTextInputFormatter();
    expect(_moneyFormatter.zero(''), '0,00');
    expect(_moneyFormatter.zero('123'), '123,00');
    expect(_moneyFormatter.zero('123,'), '123,00');
    expect(_moneyFormatter.zero('123,4'), '123,40');
    expect(_moneyFormatter.zero('123,45'), '123,45');
  });

  test('max', () {
    expect(MoneyTextInputFormatter.format('', '12', maxLeft: 3), '12');
    expect(MoneyTextInputFormatter.format('', '123', maxLeft: 3), '123');
    expect(MoneyTextInputFormatter.format('', '1234', maxLeft: 3), '');
    expect(MoneyTextInputFormatter.format('', '12345', maxLeft: 4), '');
    expect(MoneyTextInputFormatter.format('', '12345', maxLeft: 6), '12 345');

    expect(MoneyTextInputFormatter.format('', '123,45', maxLeft: 3), '123,45');
    expect(MoneyTextInputFormatter.format('', '1234,56', maxLeft: 3), '');
    expect(MoneyTextInputFormatter.format('', '12345,67', maxLeft: 4), '');
    expect(MoneyTextInputFormatter.format('', '123456,78', maxLeft: 6),
        '123 456,78');
  });
}
