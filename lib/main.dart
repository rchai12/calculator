import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _display = '';

  void _onButtonPressed(String value) {
    setState(() {
      if (value == 'C') {
        _display = '';
      } else if (value == '=') {
        try {
          _display = _evaluateExpression(_display);
        } catch (e) {
          _display = 'Error';
        }
      } else {
        _display += value;
      }
    });
  }

  String _evaluateExpression(String expression) {
    String num = '';
    final intList = <int>[];
    final operList = <String>[];
    for (int i = 0; i < expression.length; i++) {
      if (expression[i] == '+' || expression[i] == '-' || expression[i] == '*' || expression[i] == '/') {
        intList.add(int.parse(num));
        if (operList.isNotEmpty && (operList.last == '*' || operList.last == '/')) {
          if (intList.length < 2) {
            return 'Error: invalid number of arguments';
          }
          String hold = doOperations(intList.removeLast(), intList.removeLast(), operList.removeLast());
          if (hold == 'Error: Dividing by 0') {
            return hold;
          }
          intList.add(int.parse(hold));
        }
        operList.add(expression[i]);
        num = '';
      } else {
        num += expression[i];
      }
    }
    intList.add(int.parse(num));
    for (int i = operList.length; i > 0; i--) {
      if (intList.length <= 1) {
        return 'Error: invalid number of arguments';
      }
      String hold = doOperations(intList.removeLast(), intList.removeLast(), operList.removeLast());
      if (hold == 'Error: Dividing by 0') {
        return hold;
      }
      intList.add(int.parse(hold));
    }
    if (intList.length != 1) {
      return 'Error: Invalid Expression';
    }
    return intList.removeLast().toString();
  }

  String doOperations(int num1, int num2, String oper) {
    if (oper == '+') {
      num2 += num1;
    } else if (oper == '-') {
      num2 -= num1;
    } else if (oper == '*') {
      num2 *= num1;
    } else {
      if (num1 == 0) {
        return 'Error: Dividing by 0';
      }
      num2 ~/= num1;
    }
    return num2.toString();
  }

  Widget _buildButton(String text) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Expanded(
        child: ElevatedButton(
          onPressed: () => _onButtonPressed(text),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(36),
          ),
          child: Text(
            text,
            style: TextStyle(fontSize: 32),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calculator')),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(24),
              child: Text(
                _display,
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Column(
            children: [
              ['7', '8', '9', '/'],
              ['4', '5', '6', '*'],
              ['1', '2', '3', '-'],
              ['C', '0', '=', '+'],
            ].map((row) => Row(
              children: row.map((text) => _buildButton(text)).toList(),
            )).toList(),
          )
        ],
      ),
    );
  }
}
