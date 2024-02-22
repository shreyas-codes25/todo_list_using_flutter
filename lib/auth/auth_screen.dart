import 'package:flutter/material.dart';
import 'package:todo_list_using_flutter/auth/auth_form.dart';


class AuthScreen extends StatefulWidget{
  const AuthScreen({super.key});

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text('Authentication',
          style: TextStyle(color: Colors.black,
          fontWeight:FontWeight.bold,
           fontFamily: "Times New Roman",
           fontStyle: FontStyle.italic,
          ),
      ),
        backgroundColor: Colors.blue.shade100,
      ),
      body: AuthForm(),
      backgroundColor: Colors.red.shade100,
    );
  }
}
