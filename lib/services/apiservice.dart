import 'dart:io';
import 'package:http/http.dart' as http;

// ...

Future<void> uploadFile(File file) async {
  var uri = Uri.parse('https://example.com/upload');
  var request = http.MultipartRequest('POST', uri)
    ..files.add(await http.MultipartFile.fromPath('audio', file.path));

  var response = await request.send();

  if (response.statusCode == 200) {
    print('Upload successful');
  } else {
    print('Upload failed');
  }
}