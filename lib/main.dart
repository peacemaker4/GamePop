import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_app/categories.dart';
import 'home.dart';
import 'package:http/http.dart' as http;

void main() {
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
