// import 'dart:async';
// import 'dart:io';
// import 'dart:typed_data';
// import 'dart:ui' as ui;

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:image/image.dart' as image;
// import 'package:path/path.dart' as path;
// // import 'package:path_provider/path_provider.dart' as syspaths;

// Color rectColor = Color(0xff000000);
// Size rectSize = Size(100, 150);

// class TestScreen extends StatefulWidget {
//   static const routeName = '/test-screen';

//   @override
//   _TestState createState() => _TestState();
// }
// ui.Image getUiImage(String imageAssetPath, int height, int width)  {
//   final ByteData assetImageByteData =  rootBundle.load(imageAssetPath);
//   image.Image baseSizeImage = image.decodeImage(assetImageByteData.buffer.asUint8List());
//   image.Image resizeImage = image.copyResize(baseSizeImage, height: height, width: width);
//   ui.Codec codec = ui.instantiateImageCodec(image.encodePng(resizeImage));
//   ui.FrameInfo frameInfo = codec.getNextFrame();
//   return frameInfo.image;
// }
// class _TestState extends State<TestScreen> {
//   File _imageFile;
//   Future<ui.Image> _image;
//   Future<void> _takePicture() async {
//     // ignore: deprecated_member_use
//     final imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
//     // final appDir = await syspaths.getApplicationDocumentsDirectory();
//     final fileName = path.basename(imageFile.path);

//     // List<int> test = _imageFile.readAsBytesSync();
//     // String test2 = base64Encode(test);
//     // Uint8List test3 = base64Decode(test2);
 

 
//     setState(() {
//       _imageFile = imageFile;
//       _image = getUiImage(fileName,200,200);
//     });
//   }
 
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: (_imageFile == null)
//           ? Center(child: Text('No image selected'))
//           : Center(
//               child: FittedBox(
//                 child: SizedBox(
//                   width: 200,
//                   height: 200,
//                   child: CustomPaint(
//                     painter: FacePainter(_image, [2, 3]),
//                   ),
//                 ),
//               ),
//             ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _takePicture,
//         tooltip: 'Pick Image',
//         child: Icon(Icons.add_a_photo),
//       ),
//     );
//   }
// }

// class FacePainter extends CustomPainter {
//   final ui.Image image;
//   final List faces;
//   final List rects = [];

//   FacePainter(this.image, this.faces);

//   @override
//   void paint(Canvas canvas, Size size) {
//     final Paint paint = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 15.0
//       ..color = Colors.yellow;

//     // canvas.drawRect(Offset(00, 100) & rectSize, paint);
//     canvas.drawImage(image, Offset.zero, Paint());
//     // for (var i = 0; i &lt; faces.length; i++) {
//     //   canvas.drawRect(rects[i], paint);
//     // }
//   }

//   @override
//   // bool shouldRepaint(CustomPainter oldDelegate) => true;
//   bool shouldRepaint(FacePainter oldDelegate) {
//     return image != oldDelegate.image || faces != oldDelegate.faces;
//   }
// }
