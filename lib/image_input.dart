import 'dart:io';

import 'package:LDDTest/screens/resultScreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart' as path;
// import 'package:path_provider/path_provider.dart' as syspaths;

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
  void uploadImage(File file) async {
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

// for image  picker
class _ImageInputState extends State<ImageInput> {
  File _storedImage;

  Future<void> _takePicture() async {
    // ignore: deprecated_member_use
    final imageFile = await ImagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 200,
    );
    setState(() {
      _storedImage = imageFile;
    });
    // final appDir = await syspaths.getApplicationDocumentsDirectory();
    // final fileName = path.basename(imageFile.path);
    // final savedImage = await imageFile.copy('${appDir.path}/$fileName');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: _storedImage != null
                  ? Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 50,
                            color: Theme.of(context)
                                .primaryColor
                                .withOpacity(0.23),
                            spreadRadius: 10.0,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(150),
                        child: Image.file(
                          _storedImage,
                          fit: BoxFit.cover,
                          height: 350,
                          width: 350,
                        ),
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 50,
                            color: Theme.of(context)
                                .primaryColor
                                .withOpacity(0.23),
                            spreadRadius: 10.0,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(150),
                        child: Image.asset(
                          './assets/images/tea.png',
                          fit: BoxFit.cover,
                          height: 350,
                          width: 350,
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
      Container(
        child: Align(
          alignment: FractionalOffset.bottomCenter,
          child: Row(
            children: [
              if (_storedImage == null)
                FlatButton.icon(
                  minWidth: size.width,
                  icon: Icon(Icons.camera),
                  label: Text(
                    'Open Camera',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  textColor: Theme.of(context).primaryColor,
                  onPressed: _takePicture,
                )
              else
                FlatButton.icon(
                  minWidth: size.width / 2,
                  icon: Icon(Icons.camera),
                  label: Text(
                    'Open Camera',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  textColor: Theme.of(context).primaryColor,
                  onPressed: _takePicture,
                ),
              if (_storedImage != null)
                MaterialButton(
                  padding: EdgeInsets.all(10),
                  minWidth: size.width / 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    ),
                  ),
                  textColor: Colors.white,
                  color: Colors.green,
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(ResultScreen.routeName, arguments: {
                      'image': _storedImage,
                    });
                  },
                  child: Text(
                    "Check Now",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    ]);
  }
}
