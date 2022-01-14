import 'package:flutter/material.dart';
import 'package:money_input_formatter/money_text_input_formatter.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final TextEditingController _moneyController = TextEditingController();
  final _moneyFormatter = MoneyTextInputFormatter();

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
    return _moneyWidget();
  }

  Widget _moneyWidget() {
    return TextField(
      controller: _moneyController,
      inputFormatters: [_moneyFormatter],
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: 'Name',
        hintText: 'Input your name',
      ),
    );
  }
}
