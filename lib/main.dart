import 'dart:io';
import 'package:blur/blur.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_project_app/categories.dart';
import 'package:flutter_project_app/games.dart';
import 'package:flutter_project_app/auth.dart';
import 'package:flutter_project_app/profile.dart';
import 'package:flutter_project_app/services/firebase_auth_methods.dart';
import 'firebase_options.dart';
import 'home.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'login.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
          'Oops, something went wrong!!!',
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  };

  runApp(
    ChangeNotifierProvider(
      create: (context) => UserPlatform(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthMethods>(
          create: (_) => FirebaseAuthMethods(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<FirebaseAuthMethods>().authState,
          initialData: null,
        ),
      ],
      child: MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
    fontFamily: 'Montserrat',
    primarySwatch: Colors.blue,
    pageTransitionsTheme: PageTransitionsTheme(
    builders: {
    TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    },
    ),
    ),
    routes: {
    '/': (context) => MyHomePage(title: 'Games'),
    '/categories': (context) => CategoriesPage(title: 'Categories'),
    '/games': (context) => GamesPage(title: 'Games', category: "none"),
    '/auth': (context) => EmailPasswordSignup(),
      '/login': (context) => EmailPasswordLogin(),
      '/profile': (context) => ProfilePage()
    },
    ),
    );

  }
}

class UserPlatform with ChangeNotifier {
  String _platform = "Desktop";
  int _platform_id = 4;

  String get platform => _platform;
  int get platform_id => _platform_id;

  void switchPlatform(new_platform, new_platform_id) {
    _platform = new_platform;
    _platform_id = new_platform_id;
    notifyListeners();
  }
}
