// import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:ldd/screens/resultScreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'ProgressHUD.dart';
import 'constants.dart';
// import 'package:path/path.dart' as path;
// import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  @override
  _ImageInputState createState() => _ImageInputState();
}

// for image  picker
class _ImageInputState extends State<ImageInput> {
  final picker = ImagePicker();
  PickedFile _storedImage;
  var _result;
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

  Future<dynamic> uploadImage(File file) async {
    setState(() {
      isApiCallProcess = true;
    });
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.path, filename: fileName),
      "thresh": thresholdValue.text,
      "boxes": noOfBoxes.text,
    });
    try {
      var dio = Dio();
      Response response = await dio.post(
        kUrl,
        data: formData,
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          },
        ),
      );
      print("response");
      _result = response.data;
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.message);
      }
    }
    return _result;
  }

  Future<void> _takePicture() async {
    // ignore: deprecated_member_use
    final imageFile = await picker.getImage(
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
    final imageFile = await picker.getImage(
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
    SystemChrome.setEnabledSystemUIOverlays([]);

    if (_isNet) {
      return Row(children: [
        Expanded(
          child: ProgressHUD(
            child: _uiSetup(context),
            inAsyncCall: isApiCallProcess,
            opacity: 0.31,
            str: "Checking Leaf Sample",
            color: Colors.black,
          ),
        ),
      ]);
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
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
            child: IconButton(
              color: Colors.black,
              icon: Icon(Icons.arrow_back_rounded),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ]),
        Container(
          child: Center(
            child: Text(
              'Tea Leaf Disease Detection',
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Column(children: [
          Container(
            margin: EdgeInsets.all(20),
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0),
            ),
            child: _storedImage != null
                ? Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(150),
                      child: Image.file(
                        File(_storedImage.path),
                        fit: BoxFit.cover,
                        height: 350,
                        width: 350,
                      ),
                    ),
                  )
                : Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(150),
                      child: Image.asset(
                        './assets/images/tea.png',
                        fit: BoxFit.cover,
                        height: 200,
                        width: 200,
                      ),
                    ),
                  ),
          ),
        ]),
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
        Align(
          alignment: FractionalOffset.bottomCenter,
          child: Column(
            children: [
              if (_storedImage == null)
                TextButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.camera_alt_rounded),
                      Text('Open Camera', style: kButtonStyle)
                    ],
                  ),
                  onPressed: () {
                    _showPicker(context);
                  },
                )
              else
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.camera),
                        Text('Open Camera', style: kButtonStyle),
                      ],
                    ),
                    onPressed: () {
                      _showPicker(context);
                    },
                  ),
                ),
              if (_storedImage != null)
                MaterialButton(
                  padding: EdgeInsets.all(20),
                  minWidth: size.width / 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
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
                            uploadImage(File(_storedImage.path)).then((value) {
                              setState(() {
                                isApiCallProcess = false;
                              });
                              if (_result != null) {
                                setState(() {
                                  isApiCallProcess = false;
                                });
                                Navigator.of(context).pushNamed(
                                    ResultScreen.routeName,
                                    arguments: {
                                      'image': _storedImage,
                                      "ssd_scores": _result.values.toList()[0],
                                      "faster_rcnn_scores":
                                          _result.values.toList()[1],
                                      "ssd_image_name":
                                          _result.values.toList()[2],
                                      'faster_image_name':
                                          _result.values.toList()[3],
                                      "ssd_classes": _result.values.toList()[4],
                                      "faster_rcnn_classes":
                                          _result.values.toList()[5],
                                    });
                                print('input page Done ...');
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
      ],
    );
  }
}
