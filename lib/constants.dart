import 'package:flutter/material.dart';

String compute = "ec2-54-82-124-201.compute-1.amazonaws.com";
String kBaseUrl = "http://$compute:8080/docs/";
String kUrl = "http://$compute:8080/uploadfile/";
String kImageUrl = "https://tea-object-detection-results.s3.amazonaws.com/";

var kButtonStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 22,
  color: Colors.green,
);
var kTextStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 30,
  color: Colors.green,
);

var kBoxStyle = BoxDecoration(
  borderRadius: BorderRadius.circular(150),
);
//  image: const DecorationImage(
//     image: NetworkImage(
//         'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
//     fit: BoxFit.cover,
//   ),