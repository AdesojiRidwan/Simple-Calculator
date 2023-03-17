import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(SimpleCalculator());
}

class SimpleCalculator extends StatefulWidget {
  SimpleCalculator({Key? key}) : super(key: key);

  @override
  State<SimpleCalculator> createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String userInput = "";

  String result = "0";

  List<String> buttonList = [
    "AC",
    "(",
    ")",
    "/",
    "7",
    "8",
    "9",
    "*",
    "4",
    "5",
    "6",
    "+",
    "1",
    "2",
    "3",
    "-",
    "C",
    ".",
    "0",
    "="
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Color(0xFF1d2630),
          appBar: AppBar(
            backgroundColor: Color(0xFF1d2630),
            title: Center(child: Text('Simple Calculator')),
            elevation: 2.0,
          ),
          body: Column(
            children: [
              SizedBox(
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      child: Text(
                        userInput,
                        style: TextStyle(
                            fontSize: 35,
                            color: Colors.white
                        ),
                      ),
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.centerRight,
                    ),
                    Container(
                      child: Text(
                        result,
                        style: TextStyle(
                            fontSize: 48,
                            color: Colors.white
                        ),
                      ),
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.centerRight,
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.white,
                height: 10,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: GridView.builder(
                      itemCount: buttonList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12
                      ),
                      itemBuilder: (BuildContext, int index){
                        return customButton(buttonList[index]);
                      }),
                ),
              ),
            ],
          ),
        )
    );
  }
  Widget customButton (String text){
    return GestureDetector(
      onTap: (){
        setState(() {
          handleButton(text);
        });
      },
      child: Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
            color: getBgColor(text),
            borderRadius: BorderRadius.circular(10)
        ),
        child: Center(
            child: Text(
              text,
              style: TextStyle(
                  color: getColor(text),
                  fontSize: 32,
                  fontWeight: FontWeight.bold
              ),
            )),
      ),
    );
  }
  getBgColor(text){
    if(text == "AC"){
      return Color.fromARGB(255, 252, 100, 100);
    }
    if(text == "="){
      return Color.fromARGB(255, 104, 204, 159);
    }
    return Color(0xff323842);
  }
  getColor(text){
    if(text == "(" || text == ")" || text == "/" || text == "*" || text == "+" || text == "-" || text == "C"){
      return Color.fromARGB(255, 252, 100, 100);
    }
    return Colors.white;
  }
  handleButton(String text){
    if(text == "AC"){
      userInput = "";
      result = "0";
      return;
    }
    if(text == "C"){
      if(userInput.isNotEmpty){
        userInput = userInput.substring(0, userInput.length - 1);
        return;
      }else{
        return null;
      }
    }
    if(text == "="){
      result = calculate();
      userInput = result;
      if(userInput.endsWith(".0")){
        userInput = userInput.replaceAll(".0", "");
        result = result .replaceAll(".0", "");
        return;
      }
    }
    userInput = userInput + text;
  }
  calculate(){
    try{
      var exp = Parser().parse(userInput);
      var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      return evaluation.toString();
    }catch(e){
      return Error;
    }
  }
}

