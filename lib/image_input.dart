import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  @override
  _ImageInputState createState() => _ImageInputState();
}

void myfun(photo) async {
  // // This example uses the Google Books API to search for books about http.
  // // https://developers.google.com/books/docs/overview
  // var url = 'http://ec2-3-234-209-184.compute-1.amazonaws.com:8000/docs#/default/create_upload_file_uploadfile__post';
  // // Await the http get response, then decode the json-formatted response.
  // var response = await http.get(url);
}

// class to upload image
class Service {
  Future<String> uploadImage(File file) async {
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.path, filename: fileName),
    });
    var dio = Dio();
    Response response = await dio.post(
        "http://ec2-3-236-82-128.compute-1.amazonaws.com:8000/uploadfile/",
        data: formData);
    print(response.data);
    return response.data;
  }
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;

  Future<void> _takePicture() async {
    final imageFile = await ImagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 200,
    );
    setState(() {
      _storedImage = imageFile;
    });
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await imageFile.copy('${appDir.path}/$fileName');
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(padding: const EdgeInsets.all(25.0)),
        Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _storedImage != null
              ? Image.file(
                  _storedImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text(
                  'No Image Taken',
                  textAlign: TextAlign.center,
                ),
          alignment: Alignment.center,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: FlatButton.icon(
            icon: Icon(Icons.camera),
            label: Text('Take Picture'),
            textColor: Theme.of(context).primaryColor,
            onPressed: _takePicture,
          ),
        ),
        if (_storedImage != null)
          Container(
            child: FloatingActionButton(
              child: Icon(Icons.text_fields),
              // Provide an onPressed callback.
              onPressed: () {
                // myfun(_storedImage);
                Service service = Service();
                service.uploadImage(_storedImage);
              },
            ),
            margin: new EdgeInsets.symmetric(vertical: 20.0),
          ),
      ],
    );
  }
}
