import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'colors.dart';

void main() {
  runApp(const MaterialApp(
    home: CalculatorApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  var input = '';
  var output = '';
  var firstNum = '';
  var secondNum = '';
  var hideInput = false;
  double outputSize = 30;
  var outputColor = Color(0xFFD9D9D9);

  onButtonCLick(value) {
    if (value == 'AC') {
      input = ' ';
      output = ' ';
    } else if (value == 'DEL') {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == '=') {
      if (input.isNotEmpty) {
        var userInput = input;
        if (input.contains('÷')) {
          userInput = input.replaceAll('÷', '/');
        } else if (input.contains('x')) {
          userInput = input.replaceAll('x', '*');
        }

        //userInput = input.replaceAll('÷', '/');

        Parser p = Parser();

        Expression expression = p.parse(userInput);
        ContextModel cm = ContextModel();
        var finalAns = expression.evaluate(EvaluationType.REAL, cm);
        output = finalAns.toString();
        if (output.endsWith('.0')) {
          output = output.substring(0, output.length - 2);
        }
        input = output;
        hideInput = true;
        outputSize = 50;
        outputColor = const Color.fromARGB(255, 255, 255, 255);
      }
    } else {
      input = input + value;
      hideInput = false;
      outputSize = 40;
      outputColor = const Color.fromARGB(255, 156, 152, 152);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Calculator",
          style: TextStyle(),
        ),
        backgroundColor: operatorColor,
        centerTitle: true,
      ),
      backgroundColor: Colors.black87,
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              color: const Color(0xFF191919),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    hideInput ? '' : input,
                    style: const TextStyle(fontSize: 40, color: Colors.white),
                  ),
                  Text(
                    output,
                    style: TextStyle(fontSize: outputSize, color: outputColor),
                  )
                ],
              ),
            ),
          ),
          Row(
            children: [
              const Padding(padding: EdgeInsets.only(top: 20)),
              button(text: 'AC', buttonBgColor: otherBtColor),
              button(text: 'DEL', buttonBgColor: otherBtColor),
              button(text: '%', buttonBgColor: otherBtColor),
              button(text: '÷', buttonBgColor: operatorColor)
            ],
          ),
          Row(
            children: [
              button(text: '7'),
              button(text: '8'),
              button(text: '9'),
              button(text: 'x', buttonBgColor: operatorColor)
            ],
          ),
          Row(
            children: [
              button(text: '4'),
              button(text: '5'),
              button(text: '6'),
              button(text: '-', buttonBgColor: operatorColor)
            ],
          ),
          Row(
            children: [
              button(text: '1'),
              button(text: '2'),
              button(text: '3'),
              button(text: '+', buttonBgColor: operatorColor)
            ],
          ),
          Row(
            children: [
              button(text: '00'),
              button(text: '0'),
              button(text: '.'),
              button(text: '=', buttonBgColor: operatorColor)
            ],
          )
        ],
      ),
    );
  }

  Widget button(
      {text, buttonBgColor = buttonColor, textColor = butnTextColor}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(6),
        padding: const EdgeInsets.all(6),
        child: ElevatedButton(
          onPressed: () => onButtonCLick(text),
          style: ElevatedButton.styleFrom(
              elevation: 40,
              backgroundColor: buttonBgColor,
              padding: const EdgeInsets.all(16)),
          child: Text(
            text,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
