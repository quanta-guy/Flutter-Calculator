import './button.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(Myapp());

class Myapp extends StatelessWidget {
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Calculator(),
      title: "Calculator",
      debugShowCheckedModeBanner: false,
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  var qn = '';
  var answer = '';
  List<String> values = [
    "AC",
    "DEL",
    "%",
    "/",
    "9",
    "8",
    "7",
    "+",
    "4",
    "5",
    "6",
    "-",
    "1",
    "2",
    "3",
    "x",
    "0",
    ".",
    "ANS",
    "=",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Calculator"),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(20),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        qn,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 40),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      alignment: Alignment.centerRight,
                      child: Text(
                        answer,
                        style: const TextStyle(
                            color: Color.fromARGB(217, 255, 255, 255),
                            fontSize: 24),
                      ),
                    ),
                  ]),
            ),
          ),
          Expanded(
            flex: 2,
            child: GridView.builder(
                itemCount: values.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height / 2.2),
                ),
                itemBuilder: (BuildContext context, index) {
                  if (index == 0) {
                    return Button(
                      tap: () {
                        setState(() {
                          qn = '';
                          answer = '';
                        });
                      },
                      buttoncolor: const Color.fromARGB(240, 212, 210, 210),
                      textcolor: Colors.black,
                      value: values[index],
                    );
                  } else if (index == 1) {
                    return Button(
                      tap: () {
                        setState(() {
                          if (qn != '') {
                            qn = qn.substring(0, qn.length - 1);
                          }
                        });
                      },
                      buttoncolor: const Color.fromARGB(240, 212, 210, 210),
                      textcolor: Colors.black,
                      value: values[index],
                    );
                  } else if (index == values.length - 1) {
                    return Button(
                      tap: () {
                        setState(() {
                          eval();
                          var k = qn;
                          qn = answer;
                          answer = k;
                        });
                      },
                      buttoncolor: Color.fromARGB(247, 239, 151, 36),
                      textcolor: Colors.black,
                      value: values[index],
                    );
                  } else {
                    return Button(
                      tap: () {
                        setState(() {
                          qn += values[index];
                        });
                      },
                      buttoncolor: Operator(values[index])
                          ? Color.fromARGB(247, 239, 151, 36)
                          : Colors.white,
                      textcolor: Colors.black,
                      value: values[index],
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }

  bool Operator(String x) {
    if (x == '+' || x == '%' || x == '/' || x == '-' || x == 'x' || x == '=') {
      return true;
    }
    return false;
  }

  void eval() {
    String question = qn;
    question = question.replaceAll('x', '*');
    Parser p = Parser();
    Expression exp = p.parse(question);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer = eval.toString();
  }
}
