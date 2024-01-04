
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

//required code:
/*
import 'package:tflite/tflite.dart';
import 'package:image/image.dart' as img;

void loadModel(String modelPath) async {
  var res = await Tflite.loadModel(
    model: modelPath,
  );
}

Future<List> runModel(String imagePath) async {
  var image = img.decodeImage(await img.read(imagePath));
  var resized = img.copyResize(image, width: 256, height: 256);
  
  // Convert the image to a list of floats
  var input = resized.getBytes().buffer.asFloat32List();
  
  var output = await Tflite.runModelOnBinary(
    binary: input,
    numResults: 4,
    threshold: 0.05,
    asynch: true,
  );
  return output;
}

void makePredictions(String imagePath) async {
  // Load and run the 4-class model
  await loadModel('assets/models/four_class_STFT_80valacc.tflite');
  var prediction_4class = await runModel(imagePath);

  // Based on the result, load and run the appropriate binary model
  if (prediction_4class[0]['index'] == 0) {
    // Normal
  } else if (prediction_4class[0]['index'] == 1) {
    // Asthma
    await loadModel('assets/models/NvsA.tflite');
    var prediction_binary = await runModel(imagePath);
  } else if (prediction_4class[0]['index'] == 2) {
    // Pneumonia
    await loadModel('assets/models/NvsP.tflite');
    var prediction_binary = await runModel(imagePath);
  } else if (prediction_4class[0]['index'] == 3) {
    // COPD
    await loadModel('assets/models/NvsC_best.tflite');
    var prediction_binary = await runModel(imagePath);
  }

  // Handle the results
}




*/