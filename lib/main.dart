
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_list_using_flutter/auth/auth_screen.dart';
import 'package:todo_list_using_flutter/screens/home.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid ? await Firebase.initializeApp(
    options: const FirebaseOptions(apiKey:'AIzaSyA0UAgUvgQWgrk3GCtO1w1XNs1J3ZTzvW0' ,
      appId: '1:847002748656:android:d2e44f01f452b23d356435',
      messagingSenderId:'847002748656',
      projectId:'todo-list-firebase-2765f',

    ),
  )
      : await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.red),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, usersnapshot) {
          if (usersnapshot.hasData) {
            return Home();
          } else {
            return const AuthScreen();
          }
        },
      ),
    );
  }
}
