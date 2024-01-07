import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restart_app/restart_app.dart';

class AddScreen extends StatefulWidget {
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  bool _loading = true;
  bool _Visibility= true;
  late File _image;
  late List _output;
  String path_to_your_image = '';
  final picker = ImagePicker(); //allows us to pick image from gallery or camera

  @override
  void initState() {
    //initS is the first function that is executed by default when this class is called
    super.initState();
    loadModel().then((value) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    //dis function disposes and clears our memory
    //Tflite.close();
    if (mounted) {
      Tflite.close();
    }
    super.dispose();
  }


  fclassifyImage(File image) async {
  try {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults:
          5, //the amout of categories our neural network can predict (here no. of animals)
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _output = output!;
      _loading = false;
    });
  } catch (e) {
    print('Error during image classification: $e');
  }
}

  loadModel() async {
    //this function loads our model
    await Tflite.loadModel(
      model: 'assets/models/four_class_STFT_80valacc.tflite',
      labels: 'assets/models/labels.txt', 
    );
  }


  pickGalleryImage() async {
    //this function to grab the image from gallery
    var image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;

    setState(() {
      _image = File(image.path);
      path_to_your_image = image.path;
    });
    fclassifyImage(_image);
  }

  Widget outputWidget() {
  if (_output[0]['label'] == 'Asthma') {
    print("Condition 1 met - Asthma");
    return FutureBuilder<List<String>>(
  future: () async {
    try {
      print("Closed previous model");
      bool isInterpreterOpen = false;
      await Tflite.loadModel(
        model: 'assets/models/NvsA.tflite',
        labels: 'assets/models/labelsA.txt',
      );
      isInterpreterOpen = true;
      print("ModelA loaded successfully");
      var output = await Tflite.runModelOnImage(
        path: path_to_your_image, 
        numResults: 2,
        threshold:0.2,
        imageMean: 127.5,
        imageStd: 127.5,
      );
      print("Model A run successfully");
      print(output);

      String result;
      if(output?[0]['confidence'] > 0.5){
        print("Normal");
        result = "Normal";
      }
      else{
        print("Asthma");
        result = "Asthma";
      }
      //await Tflite.close(); // Close ModelA after inference
     
      print("ModelA closed successfully");
      return [result];
    } catch (error) {
      print(error); // Log errors for debugging
      return ["Error"];
    }
  }(),
     builder: (context, snapshot) {
      if (snapshot.connectionState != ConnectionState.done) {
        return const CircularProgressIndicator(); // Show indicator only while loading
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else {
        return Text('Result: ${snapshot.data![0]}');
      }
    },

  );
    /*FutureBuilder<List<dynamic>>(
      future: () async {
        try {
          //await Tflite.close(); // Close any previously opened models//the close function is not working, and that's the factor behind the endless spinning
          print("Closed previous model");

          await Tflite.loadModel(
            model: 'assets/models/NvsA.tflite',
            labels: 'assets/models/labelsA.txt',
          );
          print("ModelA loaded successfully");
          var output = await Tflite.runModelOnImage(
            path: path_to_your_image, 
            numResults: 2,
            threshold:0.2,
            imageMean: 127.5,
            imageStd: 127.5,
          );
          print("Model A run successfully");
          print(output);
          if(output?[0]['confidence'] > 0.5){
            print("Normal");
            Text("Normal");
          }
          else{
            print("Asthma");
            Text("Asthma");
          }
          await Tflite.close(); // Close ModelA after inference
          print("ModelA closed successfully");
          return output ?? [];
        } catch (error) {
          print(error); // Log errors for debugging
          return [];
        }
      }(),
      builder: (context, snapshot) => snapshot.connectionState == ConnectionState.waiting
          ? const CircularProgressIndicator()
          : snapshot.hasError
              ? Text('Error: ${snapshot.error}')
              : Text('Result: ${snapshot.data![0]['label']}'),
    );*/
    
    //Old code, always spinning...
    /*
    FutureBuilder<List<dynamic>>(
      future: () async {
        await Tflite.close();
        await Tflite.loadModel(
          model: 'assets/models/NvsA.tflite',
          labels: 'assets/models/labelsA.txt',
        );
        var output = await Tflite.runModelOnImage(
          path: path_to_your_image, 
          numResults:4, //the amout of categories our neural network can predict 
          //threshold: 0.5,
          imageMean: 127.5,
          imageStd: 127.5,
        );
        await Tflite.close();
        return output ?? [];
      }(),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          String result;
                if (snapshot.data != null && snapshot.data!.isNotEmpty) {
                  double confidence = snapshot.data![0]['confidence'];
                  result = confidence > 0.5 ? 'Asthma' : 'Normal';
                } else {
                  result = 'No result';
                }
                return Text('Result: $result');
          }
        },
        );*/
}
  
   else if (_output[0]['label'] == 'Pnemonia') {
    print('Condition 2 met - Pnemonia');
    return FutureBuilder<List<String>>(
      future: () async {
        try {
          print("Closed previous model");
          await Tflite.loadModel(
            model: 'assets/models/NvsP.tflite',
            labels: 'assets/models/labelsP.txt',
          );
          print("ModelA loaded successfully");
          var output = await Tflite.runModelOnImage(
            path: path_to_your_image, 
            numResults: 2,
            threshold:0.2,
            imageMean: 127.5,
            imageStd: 127.5,
          );
          print("Model P run successfully");
          print(output);

          String result;
          if(output?[0]['confidence'] > 0.5){
            print("Normal");
            result = "Normal";
          }
          else{
            print("Pnemonia");
            result = "Asthma";
          }
          //await Tflite.close(); // Close ModelA after inference
          print("Model P closed successfully");
          return [result];
        } catch (error) {
          print(error); // Log errors for debugging
          return ["Error"];
        }
      }(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Text('Result: ${snapshot.data![0]}');
        }
      });
  } 
  
  else if (_output[0]['label'] == 'COPD') {
    print('Condition 3 met - COPD');
    return FutureBuilder<List<String>>(
  future: () async {
    try {
      print("Closed previous model");
      await Tflite.loadModel(
        model: 'assets/models/NvsC_best.tflite',
        labels: 'assets/models/labelsC.txt',
      );
      print("ModelA loaded successfully");
      var output = await Tflite.runModelOnImage(
        path: path_to_your_image, 
        numResults: 2,
        threshold:0.2,
        imageMean: 127.5,
        imageStd: 127.5,
      );
      print("Model C run successfully");
      print(output);

      String result;
      if(output?[0]['confidence'] > 0.5){
        print("Normal");
        result = "Normal";
      }
      else{
        print("Asthma");
        result = "Asthma";
      }
      //await Tflite.close(); // Close ModelA after inference
      print("Model Cs closed successfully");
      return [result];
    } catch (error) {
      print(error); // Log errors for debugging
      return ["Error"];
    }
  }(),
     builder: (context, snapshot) {
      if (snapshot.connectionState != ConnectionState.done) {
        return const CircularProgressIndicator(); // Show indicator only while loading
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else {
        return Text('Result: ${snapshot.data![0]}');
      }
    },

  );
  } 
  
  
  else {
    return const Text('No conditions met');
    //similar conditons like above
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      

      body: Container(
        color: const Color.fromARGB(255, 248, 213, 16),
        padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 50),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Center(
                  child: _loading == true
                      ? null //show nothing if no picture selected
                      : Container(
                          child: Column(
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.width * 0.5,
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Image.file(
                                    _image,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              const Divider(
                                height: 25,
                                thickness: 1,
                              ),


                              // ignore: unnecessary_null_comparison
                              _output != null && _output.isNotEmpty
                                  ? (_output[0]['label'] == 'Normal'
                                      ? const Text('Normal')
                                      : outputWidget())
                                  : Container(),


                             const Divider(
                                height: 25,
                                thickness: 1,
                              ),
                            ],
                          ),
                        ),
                ),
              ),
              Container(
                child: Column(
                  children: [
                    
                    const SizedBox(height: 30),
                    Visibility( visible: _Visibility,
                      child: 
                        GestureDetector(
                          onTap:(){
                            pickGalleryImage();
                            setState(() {
                              _Visibility = false;
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width - 200,
                            alignment: Alignment.center,
                            padding:
                              const EdgeInsets.symmetric(horizontal: 24, vertical: 17),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child:const Text(
                              'Pick From Gallery',
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),),
                    //const SizedBox(height: 30),
                    Visibility( visible: !_Visibility,
                      child: GestureDetector(
                      onTap: Restart.restartApp,
                      child: Container(
                        width: MediaQuery.of(context).size.width - 200,
                        alignment: Alignment.center,
                        padding:
                           const EdgeInsets.symmetric(horizontal: 24, vertical: 17),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child:const Text(
                          'Pick From Gallery',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    )),
                     
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}