import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String displayText = '0';
  double numOne = 0;
  double numTwo = 0;
  String result = '';
  String finalResult = '0';
  String operation = '';
  String previousOperation = '';

  Widget calcButton(String btnText, Color btnColor, Color textColor, {bool isLarge = false}) {
    return Expanded(
      flex: isLarge ? 2 : 1,
      child: Container(
        margin: const EdgeInsets.all(8),
        child: ElevatedButton(
          onPressed: () {
            calculation(btnText);
          },
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(), backgroundColor: btnColor,
            padding: EdgeInsets.all(isLarge ? 16 : 20),
          ),
          child: Text(
            btnText,
            style: TextStyle(
              fontSize: isLarge ? 15 : 20,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Calculator', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    displayText,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 64,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    calcButton('AC', Colors.grey, Colors.black,),
                    calcButton('+/-', Colors.grey, Colors.black,),
                    calcButton('%', Colors.grey, Colors.black,),
                    calcButton('/', Colors.amber[700]!, Colors.white),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    calcButton('7', Colors.grey[850]!, Colors.white),
                    calcButton('8', Colors.grey[850]!, Colors.white),
                    calcButton('9', Colors.grey[850]!, Colors.white),
                    calcButton('x', Colors.amber[700]!, Colors.white),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    calcButton('4', Colors.grey[850]!, Colors.white),
                    calcButton('5', Colors.grey[850]!, Colors.white),
                    calcButton('6', Colors.grey[850]!, Colors.white),
                    calcButton('-', Colors.amber[700]!, Colors.white),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    calcButton('1', Colors.grey[850]!, Colors.white),
                    calcButton('2', Colors.grey[850]!, Colors.white),
                    calcButton('3', Colors.grey[850]!, Colors.white),
                    calcButton('+', Colors.amber[700]!, Colors.white),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(), backgroundColor: Colors.grey[850],
                          padding: const EdgeInsets.fromLTRB(24, 16, 96, 16),
                        ),
                        onPressed: () {
                          calculation('0');
                        },
                        child: const Text(
                          '0',
                          style: TextStyle(
                            fontSize: 28,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    calcButton('.', Colors.grey[850]!, Colors.white),
                    calcButton('=', Colors.amber[700]!, Colors.white, isLarge: true),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void calculation(String btnText) {
    if (btnText == 'AC') {
      displayText = '0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      operation = '';
      previousOperation = '';
    } else if (operation == '=' && btnText == '=') {
      if (previousOperation == '+') {
        finalResult = add();
      } else if (previousOperation == '-') {
        finalResult = sub();
      } else if (previousOperation == 'x') {
        finalResult = mul();
      } else if (previousOperation == '/') {
        finalResult = div();
      }
    } else if (btnText == '+' || btnText == '-' || btnText == 'x' || btnText == '/' || btnText == '=') {
      if (numOne == 0) {
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(result);
      }

      if (operation == '+') {
        finalResult = add();
      } else if (operation == '-') {
        finalResult = sub();
      } else if (operation == 'x') {
        finalResult = mul();
      } else if (operation == '/') {
        finalResult = div();
      }
      previousOperation = operation;
      operation = btnText;
      result = '';
    } else if (btnText == '%') {
      result = (numOne / 100).toString();
      finalResult = doesContainDecimal(result);
    } else if (btnText == '.') {
      if (!result.contains('.')) {
        result += '.';
      }
      finalResult = result;
    } else if (btnText == '+/-') {
      result = result.startsWith('-') ? result.substring(1) : '-' + result;
      finalResult = result;
    } else {
      result += btnText;
      finalResult = result;
    }

    setState(() {
      displayText = finalResult;
    });
  }

  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String div() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String doesContainDecimal(String result) {
    if (result.contains('.')) {
      final splitDecimal = result.split('.');
      if (int.parse(splitDecimal[1]) == 0) {
        return splitDecimal[0];
      }
    }
    return result;
  }
}

