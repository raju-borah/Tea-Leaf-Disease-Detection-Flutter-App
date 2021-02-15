import 'dart:convert';
import 'dart:io';

import 'package:LDDTest/screens/resultScreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'ProgressHUD.dart';
// import 'package:path/path.dart' as path;
// import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  @override
  _ImageInputState createState() => _ImageInputState();
}

// for image  picker
class _ImageInputState extends State<ImageInput> {
  File _storedImage;
  Map _result;
  bool isApiCallProcess = false;
  _ImageInputState imageInputState;

  Future uploadImage(File file) async {
    print("Started..");
      setState(() {
      isApiCallProcess = true;
    });
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.path, filename: fileName),
    });
    var dio = Dio();
    Response response = await dio.post(
        "http://ec2-18-234-246-77.compute-1.amazonaws.com:8080/uploadfile/",
        data: formData);
    // print(response.data);
    _result = response.data;
    return response.data;
  }

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
  void initState() {
    super.initState();
    imageInputState = new _ImageInputState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ProgressHUD(
          child: _uiSetup(context),
          inAsyncCall: isApiCallProcess,
          opacity: 0.3,
        )
      ],
    );
  }

  Widget _uiSetup(BuildContext context) {
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical:10.0),
                  child: FlatButton.icon(
                    minWidth: size.width,
                    icon: Icon(Icons.camera_alt_rounded),
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
                    uploadImage(_storedImage).then((value) {
                      setState(() {
                        isApiCallProcess = false;
                      });
                      if (_result != null) {
                        setState(() {
                          isApiCallProcess = false;
                        });

                        // print(_result.values.toList());
                        Navigator.of(context)
                            .pushNamed(ResultScreen.routeName, arguments: {
                          'image': _storedImage,
                          'detection_scores': _result.values.toList()[0],
                          'detection_boxes': _result.values.toList()[1],
                        });
                        print('Done ...');
                      }
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
