import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:test/Pages/AddImagePage.dart';

class AddAudioFile extends StatefulWidget {
  const AddAudioFile({Key? key}) : super(key: key);

  @override
  _AddAudioFileState createState() => _AddAudioFileState();
}
class _AddAudioFileState extends State<AddAudioFile> {
  // You might want to replace this with the actual audio file data type
  // depending on the package you're using for audio handling.
  var audioFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body:Center(
            child:SizedBox(
              width: 200,
              height: 250,
              child:ListView(
                children: [
                  const Text(
                        "  Add Audio File",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.black),
                  ),
                  const SizedBox(height: 20,),
                  Container(
                    width:200,
                    child:ElevatedButton(
                    onPressed: () {
                      loadAudioFile();
                    },
                    //change color of elevated button here
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                    child: const Text('+',style: TextStyle(fontSize: 43),),
                  ),
                  ),
                  const SizedBox(height: 20,),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AddScreen(),)
                      );
                      
                    },
                    //change color of elevated button here
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    child: const Text('Check Results here',style: TextStyle(fontSize: 17),),
                  ),
                ],
              ),
              )
             )
    
    );
  }

  void loadAudioFile() async{
    PermissionStatus status = await Permission.storage.request();

  if (status.isGranted) {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.audio);

    if(result != null) {
      audioFile = result.files.single;
      print("Audio file path: " + audioFile.path);
      // Now you can use audioFile to upload it to your server
    } else {
      // User canceled the picker
    }
  } else {
    // Handle when storage permission is not granted
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Storage Permission Denied'),
          content: Text('You have denied the storage permission. This feature requires the storage permission to work. You can grant the permission in the app settings.'),
          actions: <Widget>[
            TextButton(
              child: Text('Open Settings'),
              onPressed: () {
                openAppSettings();
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  }
}
