import 'dart:math';

import 'package:flutter/material.dart';
import 'package:untitled4/modules/bmi_app/bmi_result/Bmi_result.dart';


class BmiScreen extends StatefulWidget {

  @override
  State<BmiScreen> createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  bool isMale =true;
  double height = 120.0;
  int age = 20;
  int weight =40;
  @override

  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text(
          "BMI Calculator",
        style: TextStyle(

        color: Colors.white,
        ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child:Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: ()
                      {
                        setState(() {
                          isMale =true;
                        });
                      },
                      child: Container(

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                           Image(
                               image:AssetImage('assets/Images/male.png'),
                             height: 90.0,
                             width: 90.0,
                           ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              "MALE",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0,),
                          color: isMale ? Colors.blue :Colors.grey[400],
                        ),

                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: ()
                      {
                        setState(() {
                          isMale =false;
                        });

                      }
                      ,
                      child: Container(

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                                image: AssetImage('assets/Images/female.png'),
                              height: 90.0,
                              width: 90.0,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              "FEMALE",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0,),
                          color: isMale ? Colors.grey[400] : Colors.blue,
                        ),

                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
         Expanded(
           child: Padding(
             padding: const EdgeInsets.symmetric(
                 horizontal: 20.0,),
             child: Container(
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
               children: [
               Text(
               "Height",
               style: TextStyle(
                 fontSize: 20.0,
                 fontWeight: FontWeight.bold,
               ),
                        ),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   crossAxisAlignment: CrossAxisAlignment.baseline,
                   textBaseline: TextBaseline.alphabetic,
                   children: [
                     Text(
                       "${height.round()}",
                       style: TextStyle(
                         fontSize: 40.0,
                         fontWeight: FontWeight.bold,
                       ),
                     ),
                     SizedBox(
                       width: 5.0,
                     ),
                     Text(
                       "CM",
                       style: TextStyle(
                         fontSize: 15.0,
                         fontWeight: FontWeight.bold,
                       ),
                     ),

                   ],
                 ),
                 Slider(
                     value: height,
                     max: 220.0,
                     min: 80.0,
                     onChanged: (value)
                     {
                       setState(() {
                         height=value;
                       });

                       print(value.round());
                     }),


               ],
                        ),
             decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(10.0,),
              color: Colors.grey[400],
             ),

                      ),
           ),
         ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Age",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${age}",
                            style: TextStyle(
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FloatingActionButton(
                              onPressed:(){
                                setState(() {
                                  age--;
                                });
                              },
                              mini: true,
                              child: Icon(
                                Icons.remove,
                              ),
                            ),
                            FloatingActionButton(
                              onPressed:(){
                                setState(() {
                                  age++;
                                });
                              },
                              mini: true,
                              child: Icon(
                                Icons.add,
                              ),
                            ),

                          ],
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0,),
                        color: Colors.grey[400],
                      ),

                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Weight",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${weight}",
                            style: TextStyle(
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FloatingActionButton(
                              onPressed:(){
                                setState(() {
                                  weight--;
                                });
                              },
                              mini: true,
                              child: Icon(
                                Icons.remove,
                              ),
                            ),
                            FloatingActionButton(
                              onPressed:(){
                                setState(() {
                                  weight++;
                                });
                              },
                              mini: true,
                              child: Icon(
                                Icons.add,
                              ),
                            ),

                          ],
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0,),
                        color: Colors.grey[400],
                      ),

                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            color: Colors.cyan,
            child: MaterialButton(
                onPressed: (){

                  var result = weight / pow(height/100, 2);
                  Navigator.push(context,
                  MaterialPageRoute(
                      builder: (context)=>BmiResultScreen(
                        age: age,
                        result: result.round(),
                        isMale: isMale,
                      ),
                  ),
                  );
                },
              child: Text(
                "Calculate"
              ),

            ),
          )
        ],
      ),
    );
  }
}
