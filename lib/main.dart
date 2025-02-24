import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
    try {
      
      return expression;
    } catch (e) {
      return 'Error';
    }
  }

  Widget _buildButton(String text) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => _onButtonPressed(text),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(24),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 24),
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
