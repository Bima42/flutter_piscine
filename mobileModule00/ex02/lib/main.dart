import 'package:flutter/material.dart';

void main() {
  runApp(
    OrientationBuilder(
      builder: (context, orientation) {
        return const MyApp();
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Calculator',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text('Calculator'),
        centerTitle: true,
      ),
      body: const MyCalculator(),
    );
  }
}

class MyCalculator extends StatefulWidget {
  const MyCalculator({super.key});

  @override
  MyCalculatorState createState() => MyCalculatorState();
}

class MyCalculatorState extends State<MyCalculator> {
  final List<String> buttons = [
    '%',
    '/',
    'DEL',
    'C',
    '7',
    '8',
    '9',
    'x',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '0',
    '.',
    '=',
  ];

  String userInput = '';
  String answer = '';

  void onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'DEL') {
        userInput = '';
      } else {
        userInput += buttonText;
      }
      debugPrint('Button pressed: $buttonText');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CalculatorScreen(userInput: userInput, answer: answer),
        CalculatorButtons(buttons: buttons, onButtonPressed: onButtonPressed),
      ],
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  final String userInput;
  final String answer;

  CalculatorScreen({super.key, required this.userInput, required this.answer});

  @override
  CalculatorScreenState createState() => CalculatorScreenState();
}

class CalculatorScreenState extends State<CalculatorScreen> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isPortrait = screenSize.height > screenSize.width;

    final screenPercentage = isPortrait ? 0.3 : 0.5;

    return Container(
      height: screenSize.height * screenPercentage,
      color: Colors.blueGrey.shade900,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerRight,
            child: Text(
              widget.userInput,
              style: const TextStyle(color: Colors.white, fontSize: 40),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerRight,
            child: Text(
              widget.answer,
              style: const TextStyle(color: Colors.white, fontSize: 40),
            ),
          ),
        ],
      ),
    );
  }
}

class CalculatorButtons extends StatefulWidget {
  final List<String> buttons;
  final Function(String) onButtonPressed;

  const CalculatorButtons(
      {super.key, required this.buttons, required this.onButtonPressed});

  @override
  CalculatorButtonsState createState() => CalculatorButtonsState();
}

class CalculatorButtonsState extends State<CalculatorButtons> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: widget.buttons.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        itemBuilder: (BuildContext context, int index) => CalculatorButton(
            label: widget.buttons[index], onPressed: widget.onButtonPressed),
      ),
    );
  }
}

class CalculatorButton extends StatefulWidget {
  final String label;
  final Function(String) onPressed;

  const CalculatorButton(
      {super.key, required this.label, required this.onPressed});

  @override
  CalculatorButtonState createState() => CalculatorButtonState();
}

class CalculatorButtonState extends State<CalculatorButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => widget.onPressed(widget.label),
      style: TextButton.styleFrom(
        backgroundColor: Colors.blueGrey,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0)),
        ),
      ),
      child: Text(
        widget.label,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
      ),
    );
  }
}
