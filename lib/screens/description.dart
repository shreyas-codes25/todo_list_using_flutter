import 'package:flutter/material.dart';

class Description extends StatelessWidget {

   String title = "";
   String description = "";
   Description({super.key,required this.title,required this.description});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.blue.shade50,
        title: Text("Description"),

      ),
        body:Container(

            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.red.shade100,

            child:Column(

              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: Text(
                      title,
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Text(
                    description,
                    style: TextStyle(
                      fontSize:18,
                      color: Colors.black,

                    ),
                  ),
                )
              ],
            )
        )
    );
  }
}
