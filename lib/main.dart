import 'package:flutter/material.dart';
import 'package:todo_list_using_flutter/auth/auth_screen.dart';
import 'package:todo_list_using_flutter/screens/home.dart';
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.red),
      home:const AuthScreen(),


    );
  }
}
