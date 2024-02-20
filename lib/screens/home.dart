import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.purpleAccent,
        title:const Text('todo list',style: TextStyle(color: Colors.black,fontSize: 50)),
      ),
      body: const Center(
        child: Text('todo list'),
      ),
    );
  }
}