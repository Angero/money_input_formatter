import 'package:flutter/material.dart';
import 'package:money_input_formatter/money_text_input_formatter.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final TextEditingController _moneyController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final _moneyFormatter = MoneyTextInputFormatter(
      decimalSeparator: '.', thousandSeparator: '\'', maxLeft: 6, emptyText: '0');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _scaffoldWidget();
  }

  Widget _scaffoldWidget() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Money Input Formatter'),
      ),
      body: _bodyWidget(),
    );
  }

  Widget _bodyWidget() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _moneyWidget(),
          const SizedBox(height: 40.0),
          _otherWidget(),
        ],
      ),
    );
  }

  Widget _moneyWidget() {
    return Focus(
      child: TextField(
        autofocus: true,
        controller: _moneyController,
        inputFormatters: [_moneyFormatter],
        keyboardType: _moneyFormatter.keyboardType,
        decoration: InputDecoration(
          hintText: _moneyFormatter.hintText,
        ),
      ),
      onFocusChange: (hasFocus) {
        if (!hasFocus) {
          _moneyController.text = _moneyFormatter.zero(_moneyController.text);
        }
      },
    );
  }

  Widget _otherWidget() {
    return TextField(
      controller: _nameController,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: 'Name',
        hintText: 'Input your name',
      ),
    );
  }
}
