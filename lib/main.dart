import 'package:flutter/material.dart';
import "package:firebase_core/firebase_core.dart";
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sports_app/Authentication/auth_screen.dart';
import 'package:sports_app/splash_screen.dart';

import 'Global/global.dart';
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedpreference=await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
final navigatorKey=GlobalKey<NavigatorState>();
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Splash_screen(),
    );
  }
}




