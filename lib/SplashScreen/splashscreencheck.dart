
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:test/Pages/AddAudioPage.dart';
import 'package:test/base.dart';



void main() {
  //WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  //FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
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
      home: const AddAudioFile(),
      theme:ThemeData(  //change theme color here
        primaryColor: Colors.white,
      )
      );
  }
}
