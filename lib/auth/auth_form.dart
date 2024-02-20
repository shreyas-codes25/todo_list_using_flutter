import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  @override
  final _formKey = GlobalKey<FormState>();
  var _email ="";
  var _password="";
  var _username="";
   bool isLoginPage=false;
  Widget build(BuildContext context){
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child:ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if(!isLoginPage)
                  TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      key:ValueKey("Username"),
                      decoration: const InputDecoration(
                        border:OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: Colors.black, width: 2)),
                        labelText: "Username",

                      ),

                      validator: (value){
                        if(value!.isEmpty ){
                          return "Please enter Username";
                        }
                        return null;
                      },
                      onSaved: (value){
                        _username = value!;
                      }
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    key:ValueKey("email"),
                    decoration: const InputDecoration(
                      border:OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.black, width: 2)),
                      labelText: "Email",

                      ),

                    validator: (value){
                      if(value!.isEmpty || !value.contains("@")){
                        return "Please enter a valid email";
                      }
                      return null;
                    },
                    onSaved: (value){
                      _email = value!;
            }
                    ),
                  SizedBox(height: 10,),
                  TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      key:ValueKey("password"),
                      decoration: const InputDecoration(
                        border:OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: Colors.black, width: 2)),
                        labelText: "Password",

                      ),

                      validator: (value){
                        if(value!.isEmpty ){
                          return "Please enter Password";
                        }
                        return null;
                      },
                      onSaved: (value){
                        _password = value!;
                      }
                  ),
                  SizedBox(height: 10,),



                ],

              )
            ),
          ),
        ],
      ),
    );
  }
}