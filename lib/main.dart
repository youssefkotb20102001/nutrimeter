import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nutrimeter/Classes/Clients_info.dart';
import 'package:nutrimeter/Tabs.dart';
import 'package:nutrimeter/welcomePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: 'AIzaSyDE7RQkaYc-JK4cx0v7Z5BkJaH_pCtup2A',
              appId: '1:216066482015:android:34378f0b5cbc85ab45e0ea',
              messagingSenderId: '216066482015',
              projectId: 'nutrimeter-45433'))
      : await Firebase.initializeApp();
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: WelcomePage()));
}
