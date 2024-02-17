import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:screl_interview/views/homepage.dart';

void main() {
  runApp( DevicePreview(
    builder: (context) {
      return MaterialApp(
          useInheritedMediaQuery: true,
          debugShowCheckedModeBanner: false,
          home: MyApp());
    }
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home:  HomePage(),
    );
  }
}

