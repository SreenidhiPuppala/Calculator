import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _input = '';
  String _result = '';
  String _operation = '';
  double _num1 = 0;
  double _num2 = 0;

  void _buttonPressed(String value) {
    setState(() {
      if (value == 'C') {
        _input = '';
        _result = '';
        _operation = '';
        _num1 = 0;
        _num2 = 0;
      } else if (value == '+' || value == '-' || value == '*' || value == '/') {
        _operation = value;
        _num1 = double.tryParse(_input) ?? 0;
        _input = '';
      } else if (value == '=') {
        _num2 = double.tryParse(_input) ?? 0;
        _performOperation();
        _input = _result;
      } else {
        _input += value;
      }
    });
  }

  void _performOperation() {
    double result = 0;
    switch (_operation) {
      case '+':
        result = _num1 + _num2;
        break;
      case '-':
        result = _num1 - _num2;
        break;
      case '*':
        result = _num1 * _num2;
        break;
      case '/':
        if (_num2 != 0) {
          result = _num1 / _num2;
        } else {
          _result = 'Error';
          return;
        }
        break;
    }
    _result = result.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Calculator'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Display for the input and result
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              _input,
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              textAlign: TextAlign.right,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              _result,
              style: TextStyle(fontSize: 36, color: Colors.grey),
              textAlign: TextAlign.right,
            ),
          ),
          Divider(),
          // Buttons for numbers and operations
          Expanded(
            flex: 2,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: _buttons.length,
              itemBuilder: (context, index) {
                return ElevatedButton(
                  onPressed: () => _buttonPressed(_buttons[index]),
                  child: Text(
                    _buttons[index],
                    style: TextStyle(fontSize: 24),
                  ),
                );
              },
              padding: EdgeInsets.all(10.0),
            ),
          ),
        ],
      ),
    );
  }

  final List<String> _buttons = [
    '7', '8', '9', '/',
    '4', '5', '6', '*',
    '1', '2', '3', '-',
    'C', '0', '=', '+'
  ];
}
