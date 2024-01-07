
import 'package:flutter/material.dart';
import 'package:test/base.dart';



void main() {
  runApp(MyApp());
}


class MyApp extends StatefulWidget{
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyappState();
}

class _MyappState extends State<MyApp> {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title:"AuscultoWave",
      debugShowCheckedModeBanner: false,//just to remove debug banner
      home: HomeScreen(),
      theme:ThemeData(  //change theme color here
        primaryColor: Colors.white,
      )
      );
  }
}
