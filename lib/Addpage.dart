import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';

class AddScreen extends StatefulWidget {
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  bool _loading = true;
  late File _image;
  late List _output;
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
    super.dispose();
    Tflite.close();
  }

  Future<List?> runSecondModel(File image) async {
    // Load the model
    await Tflite.loadModel(
      model: 'assets/second_model.tflite',
      labels: 'assets/second_labels.txt',
    );

    // Run the model on the image
    var output = await Tflite.runModelOnImage(
      path: image.path,
      imageMean: 0.0,  // these values depend on your model
      imageStd: 255.0,  // these values depend on your model
      numResults: 2,    // the number of output categories of your model
      threshold: 0.2,   // the minimum confidence to be considered a match
      asynch: true,
    );

    // Unload the model to free resources
    await Tflite.close();

    return output;
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
    });
    fclassifyImage(_image);
  }

  Decide(String label){
    if (label == 'COPD'){
      //run the NvsC model
      // Load the model
      print("COPD");
      Text("COPD");
      /*
      Tflite.loadModel(
        model: 'assets/models/NvsC_best.tflite',
        labels: 'assets/models/labels.txt',
      );
      //run the model on the image
      Tflite.runModelOnImage(
        path: _image.path,
        imageMean: 0.0,  // these values depend on your model
        imageStd: 255.0,  // these values depend on your model
        numResults: 2,    // the number of output categories of your model
        threshold: 0.2,   // the minimum confidence to be considered a match
        asynch: true,
      );*/
    } else if(label == 'Asthma'){
      print('Asthma');
      Text("ASTHMA");
    } else if (label == 'PNE') {
      print('PNE');
      Text("PNEUMONIA");
    } else {
      // Display the result from the first model
      Text(
        'Result: $label',
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
      );
    }

/*
      // Run the second model
      var secondOutput = runSecondModel(_image);
      // Display the result from the second model
      Text(
        'Second Result: ${secondOutput[0]['label']}',
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
      );*/
     
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      /*
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        centerTitle: true,
        title: Text(
          'Classification',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 23,
          ),
        ),
      ),*/


      body: Container(
        color: Color.fromARGB(255, 248, 213, 16),
        padding: EdgeInsets.symmetric(horizontal: 35, vertical: 50),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(30),
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
                              Container(
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



                              //IF else statement to to run different models based on the output of the first model
                              /*if (_output != null) {
                                String label = _output[0]['label'];
                                if (label == 'COPD' || label == 'Asthma' || label == 'PNE') {
                                  // Run the second model
                                  var secondOutput = await runSecondModel(image);
                                  // Display the result from the second model
                                  Text(
                                    'Second Result: ${secondOutput[0]['label']}',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  );
                                } else {
                                  // Display the result from the first model
                                  Text(
                                    'Result: $label',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  );
                                }
                              },*/
                              // ignore: unnecessary_null_comparison
                              //_output != null
                              if(_output` != null){
                                  Decide(_output)},
                                  //: Container(),




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
                    GestureDetector(
                      onTap: pickGalleryImage,
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
                    ),
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