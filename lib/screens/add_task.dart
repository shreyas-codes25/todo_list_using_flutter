import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  //function creation
  addtasktofirebase()async{
    String title = titleController.text;
    String description = descriptionController.text;

    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    String uid = user!.uid;
    var time = DateTime.now();
    await FirebaseFirestore.instance.collection("users").doc(uid).collection("mytasks").doc(time.toString()).set({
      "title":title,
      "description":description,
      "time":time.toString(),
      'timestamp':time

    });

  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Add Task"),
        backgroundColor: Theme.of(context).secondaryHeaderColor,
      ),
        body:Container(
          padding:const  EdgeInsets.all(10),
          color: Colors.red.shade50,
          child: Column(
            children : [
              
              Container(child: TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: "Enter Title",
                  border: OutlineInputBorder(),
                ),
              ),
              ),
              const SizedBox(height: 10,),
              Container(child: TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: "Enter Description",
                  border: OutlineInputBorder(),
                ),
              ),
              ),
              const SizedBox(height: 10,),
              Container(
                width: double.infinity,
                height: 50,
                child:ElevatedButton(onPressed: (){addtasktofirebase();},
                  style: ButtonStyle(backgroundColor:
                  MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states){
                    if(states.contains(MaterialState.pressed)){
                      return Colors.red.shade700;
                    }
                    return Theme.of(context).primaryColor;
                  })),
                  child: const Text(
                    "Add Task"
                    , style: TextStyle(
                      fontSize:20,
                      fontFamily: "Poppins",
                      color: Colors.white,
                  ),
                  ),
                ),
              ),
            ]
          )
        ),
    );
  }
}
