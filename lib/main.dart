import 'dart:io';
import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_project_app/categories.dart';
import 'home.dart';
import 'package:http/http.dart' as http;

void main() {
  FlutterError.onError = (details) {
    // Handle errors caught by Flutter
    FlutterError.presentError(details); // Print the error to the console
    if (kReleaseMode) exit(1); // Exit the app in release mode
  };

  PlatformDispatcher.instance.onError = (exception, stackTrace) {
    print(exception);
    print(stackTrace);
    return false;
  };

  ErrorWidget.builder = (errorDetails) {
    // Define a custom error widget
    return Scaffold(
      body: Center(
        child: Text(
          'Oops, something went wrong!',
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  };

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Montserrat',
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => MyHomePage(title: 'Games'),
        '/genres': (context) => CategoriesPage(title: 'Genres')
      },
    );
  }
}
