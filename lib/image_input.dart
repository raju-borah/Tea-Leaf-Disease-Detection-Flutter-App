// import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:LDDTest/screens/resultScreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'DioExceptions.dart';
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
  bool _isNet = true;
  TextEditingController thresholdValue = TextEditingController();
  TextEditingController noOfBoxes = TextEditingController();
  bool _validateThresholdValue = false;
  bool _validateNoOfBoxes = false;

  Future<void> checkInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          _isNet = true;
        });
      }
    } on SocketException catch (_) {
      setState(() {
        _isNet = false;
      });
    }
  }

  Future uploadImage(File file) async {
    print("Started..");
    setState(() {
      isApiCallProcess = true;
    });
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.path, filename: fileName),
    });
    try {
      var dio = Dio();
      Response response = await dio.post(
          "http://ec2-52-205-110-160.compute-1.amazonaws.com:8080/uploadfile/",
          data: formData);
      // print(response.data);
      _result = response.data;
      return response.data;
    } catch (e) {
      print(DioExceptions.fromDioError(e).toString());
      print(e);
    }
  }

  Future<void> _takePicture() async {
    // ignore: deprecated_member_use
    final imageFile = await ImagePicker.pickImage(
      source: ImageSource.camera,
      // maxWidth: 200,
    );
    // final appDir = await syspaths.getApplicationDocumentsDirectory();
    // final fileName = path.basename(imageFile.path);
    setState(() {
      _storedImage = imageFile;
    });
    // final savedImage = await imageFile.copy('${appDir.path}/$fileName');
  }

  Future<void> _selectPicture() async {
    // ignore: deprecated_member_use
    final imageFile = await ImagePicker.pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      _storedImage = imageFile;
    });
    // final savedImage = await imageFile.copy('${appDir.path}/$fileName');
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _selectPicture();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _takePicture();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    imageInputState = new _ImageInputState();
  }

  @override
  Widget build(BuildContext context) {
    if (_isNet) {
      return Stack(
        children: [
          ProgressHUD(
            child: _uiSetup(context),
            inAsyncCall: isApiCallProcess,
            opacity: 0.37,
            str: "Checking Leaf Sample",
          )
        ],
      );
    } else {
      return AlertDialog(
        title: new Text("Alert"),
        content: new Text("No Internet Connection!!"),
        actions: <Widget>[
          TextButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              })
        ],
      );
    }
  }

  Widget _uiSetup(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 200,
          height: 200,
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
                        color: Theme.of(context).primaryColor.withOpacity(0.23),
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
                        color: Theme.of(context).primaryColor.withOpacity(0.23),
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
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
              controller: thresholdValue,
              style: TextStyle(fontSize: 16.0),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                labelText: 'Threshold Value',
                hintText: 'The range must be between 0.1 to 0.9',
                errorText: _validateThresholdValue
                    ? 'Please give a value like 0.1 , 0.4'
                    : null,
              ),
              keyboardType: TextInputType.number),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
              controller: noOfBoxes,
              style: TextStyle(fontSize: 16.0),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                labelText: 'Maximum no. of Boxes',
                hintText: 'The range must be between 5 to 50 max',
                errorText: _validateNoOfBoxes
                    ? 'Values of boxes must be in range of 5 to 50'
                    : null,
              ),
              keyboardType: TextInputType.number),
        ),
        Container(
          child: Align(
            alignment: FractionalOffset.bottomCenter,
            child: Row(
              children: [
                if (_storedImage == null)
                  Expanded(
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
                      onPressed: () {
                        _showPicker(context);
                      },
                    ),
                  )
                else
                  Expanded(
                    child: FlatButton.icon(
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
                      onPressed: () {
                        _showPicker(context);
                      },
                    ),
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
                      setState(() {
                        thresholdValue.text.isEmpty
                            ? _validateThresholdValue = true
                            : _validateThresholdValue = false;
                        noOfBoxes.text.isEmpty
                            ? _validateNoOfBoxes = true
                            : _validateNoOfBoxes = false;
                        if (_validateThresholdValue == false &&
                            _validateNoOfBoxes == false) {
                          checkInternet().then((value) {
                            if (_isNet) {
                              uploadImage(_storedImage).then((value) {
                                setState(() {
                                  isApiCallProcess = false;
                                });
                                if (_result != null) {
                                  setState(() {
                                    isApiCallProcess = false;
                                  });

                                  // print(_result.values.toList());
                                  Navigator.of(context).pushNamed(
                                      ResultScreen.routeName,
                                      arguments: {
                                        // 'image': _storedImage,
                                        'detection_scores':
                                            _result.values.toList()[0],
                                        'filename': _result.values.toList()[1],
                                      });
                                  print('Done ...');
                                }
                              });
                            } else {
                              setState(() {
                                _isNet = false;
                              });
                              print('here');
                            }
                          });
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
      ],
    );
  }
}
