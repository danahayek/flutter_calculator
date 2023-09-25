import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'calculator',
      theme: ThemeData(primaryColor: Colors.blue),
      home: calculator(),
    );
  }
}
class calculator extends StatefulWidget {
  const calculator({Key? key}) : super(key: key);

  @override
  State<calculator> createState() => _calculatorState();
}

class _calculatorState extends State<calculator> {

  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

   button_presses(btn_text){
     setState(() {
       if(btn_text == "c"){
         equationFontSize = 38.0;
         resultFontSize = 48.0;
         equation = "0";
         result = "0";

       }else if(btn_text == "⌫"){
         equationFontSize = 48.0;
         resultFontSize = 38.0;
         equation = equation.substring(0, equation.length - 1);
         if(equation == ""){
           equation = "0";


         }

       }else if(btn_text == "="){
         equationFontSize = 38.0;
         resultFontSize = 48.0;
         expression = equation;
         expression = expression.replaceAll('×', '*');
         expression = expression.replaceAll('÷', '/');

         try{
           Parser p =new Parser();

           Expression exp = p.parse(expression);


           ContextModel cm = ContextModel();
           result = '${exp.evaluate(EvaluationType.REAL, cm)}';
         }catch(e){
           result="error";
         }

       }else{
         equationFontSize = 48.0;
         resultFontSize = 38.0;
         if(equation == "0"){
           equation = btn_text;
         }else {
           equation = equation + btn_text;
         }
       }
     });

   }
  Widget buildButton (String btn_text , double btn_height , Color btn_color){
    return Container(height: MediaQuery.of(context).size.height*0.1 * btn_height,
        color:  btn_color,
        child: FloatingActionButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              side: BorderSide(
                  color: Colors.white,
                  width: 1,
                  style: BorderStyle.solid
              )
          ),
          // padding: EdgeInsets.all(16.0),
          onPressed: () => button_presses(btn_text),
          child: Text(btn_text , style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.normal,
              color: Colors.white
          ),),

        )

    );

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("calculator app"),),
      body: Column(
        children: <Widget>[
          Container(
        alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(equation,style: TextStyle(fontSize: equationFontSize),),
    ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(result,style: TextStyle(fontSize: resultFontSize),),
          ),
          Expanded(child: Divider()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children:
                  [TableRow(
                    children: [
                      buildButton("c", 1, Colors.red),
                      buildButton("⌫", 1, Colors.blue),
                      buildButton("÷", 1, Colors.blue),

                    ],
                  ),
                    TableRow(
                      children: [
                        buildButton("7", 1, Colors.black54),
                        buildButton("8", 1, Colors.black54),
                        buildButton("9", 1, Colors.black54),

                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("4", 1, Colors.black54),
                        buildButton("5", 1, Colors.black54),
                        buildButton("6", 1, Colors.black54),

                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("1", 1, Colors.black54),
                        buildButton("2", 1, Colors.black54),
                        buildButton("3", 1, Colors.black54),

                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton(".", 1, Colors.black54),
                        buildButton("0", 1, Colors.black54),
                        buildButton("00", 1, Colors.black54),

                      ],
                    )],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width*0.25,
                child: Table(
                  children: [TableRow(
                    children:[buildButton("×", 1, Colors.blue),]
                  ),
                    TableRow(
                        children:[buildButton("+", 1, Colors.blue),]

                    ),
                    TableRow(
                        children:[buildButton("-", 1, Colors.blue),]

                    ),
                    TableRow(
                        children:[buildButton("=", 2, Colors.red ),]

                    )
                  ],
                ),
              )
            ],
          )
    ],
        ),
    );
  }
}

