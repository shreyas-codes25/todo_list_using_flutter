import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'add_task.dart';
import 'description.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String uid = '';

  @override
  void initState() {
    getuid();
    super.initState();
  }

  getuid() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    setState(() {
      uid = user!.uid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        title: const Text(
          'todo list',
          style: TextStyle(
            color: Colors.black,
            fontFamily: "Times New Roman",
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.red.shade100,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(uid)
              .collection('mytasks')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              final docs = snapshot.data!.docs;

              return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    var time = (docs[index]['timestamp'] as Timestamp).toDate().toString();
                    return InkWell(
                      onTap: (){Navigator.push(context,MaterialPageRoute(builder: (context)=>Description(title: docs[index]['title'],description: docs[index]['description'])));},
                      child: Container(
                        margin: EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.shade500,
                        ),
                        height: 90,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Text(
                                    docs[index]['title'],
                                    style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.white,
                                      fontStyle: FontStyle.italic,
                      
                                    ),
                                  ),
                      
                                ),
                                SizedBox(height: 5,),
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Text(
                      
                                      DateFormat.yMd().add_jm().format(DateTime.parse(time)),
                      
                                  ),
                                ),                            ],
                            ),
                            Container(
                              child: IconButton(
                                  onPressed: () async {
                                    await FirebaseFirestore.instance
                                        .collection("users")
                                        .doc(uid)
                                        .collection("mytasks")
                                        .doc(docs[index]['time'])
                                        .delete();
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.greenAccent,
                                  )),
                            )
                          ],
                        ),
                      ),
                    );
                  });
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddTask()));
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
