import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:googledrive/screens/LoginScreen.dart';
import 'package:get/get.dart';
import 'package:googledrive/screens/nav_screen.dart';
import 'controllers/authController.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initialise app based on platform- web or mobile
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyDkmUqP9uQCExZz3NjNwavqUPa-4Mgf4v8',
        appId: '1:1076464840446:web:ce7dfcf7865b14ab0b3faf',
        messagingSenderId: '1076464840446',
        projectId: 'djdrive',
        authDomain: 'djdrive.firebaseapp.com',
        storageBucket: 'djdrive.appspot.com',
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  //requestPermission();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Root(),
    );
  }
}

class Root extends StatelessWidget {
  //const Root({Key? key}) : super(key: key);
  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return authController.user.value == null ? LoginScreen() : NavScreen();
    });
  }
}
