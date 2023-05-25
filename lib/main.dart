import 'package:blood_donations/constant/depedency_injection.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart' as google_fonts;

import 'package:blood_donations/firebase_options.dart';
import 'package:blood_donations/screens/auth/loading_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  //WidgetsFlutterBinding.ensureInitialized();
  print('before initail');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print('After initail');
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Blood Donation',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: TextTheme(
            headline1: google_fonts.GoogleFonts.lato(
              textStyle: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
            ),
            headline2: google_fonts.GoogleFonts.openSans(
              textStyle: const TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            headline3: google_fonts.GoogleFonts.openSans(
              textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
            headline4: google_fonts.GoogleFonts.literata(
              textStyle: const TextStyle(
                fontSize: 20,
                letterSpacing: 1.5,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            headline5: google_fonts.GoogleFonts.literata(
              textStyle: const TextStyle(
                fontSize: 20,
                letterSpacing: .5,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
        ),
        home: const LoadingPage(),
      ),
    );
  }
}
