import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  @override
  //variable declaration
  final _formKey = GlobalKey<FormState>();
  var _email = "";
  var _password = "";
  var _username = "";
  bool isLoginPage = false;
  //function
  startauthentication() {
    final validity = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (validity) {
      _formKey.currentState!.save();
      submitform(_email, _password, _username);
    }
  }

  submitform(String email, String password, String username) async {
    final auth = FirebaseAuth.instance;
    UserCredential authResult;
    try {
      if (isLoginPage) {
        authResult = await auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authResult = await auth.createUserWithEmailAndPassword(
            email: email, password: password);
        String uid = authResult.user!.uid;
        await FirebaseFirestore.instance
            .collection("users")
            .doc(uid)
            .set({"username": username, "email": email});
      }
    } on FirebaseAuthException catch (error) {
      var message = "An error occurred, please check your credentials!";
    }
  }

  //widget build
  Widget build(BuildContext context) {
    return Container(

      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        children: [
          Container(
              height: 200,
              margin: EdgeInsets.all(20),
              child: Image.asset("assets/images/todo.png")
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (!isLoginPage)
                      TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          key: ValueKey("Username"),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide:
                                    BorderSide(color: Colors.black, width: 2)),
                            labelText: "Username",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter Username";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _username = value!;
                          }),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        key: ValueKey("email"),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide:
                                  BorderSide(color: Colors.black, width: 2)),
                          labelText: "Email",
                        ),
                        validator: (value) {
                          if (value!.isEmpty || !value.contains("@")) {
                            return "Please enter a valid email";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _email = value!;
                        }),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        obscureText: true,
                        keyboardType: TextInputType.emailAddress,
                        key: ValueKey("password"),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide:
                                  BorderSide(color: Colors.black, width: 2)),
                          labelText: "Password",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter Password";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _password = value!;
                        }),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 80, right: 80),
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                        onPressed: () {
                          startauthentication();
                        },
                        child: isLoginPage
                            ? Text(
                                "Login",
                                style: TextStyle(
                                    fontSize: 20
                                , fontFamily: "Times New Roman", color: Colors.white),
                              )
                            : Text(
                                "Submit",
                            style: TextStyle(
                                fontSize: 20
                                , fontFamily: "Times New Roman", color: Colors.white)
                              ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: TextButton(
                        child: isLoginPage
                            ? Text(
                                "Not a user?",
                                style: TextStyle(color: Colors.green),
                              )
                            : Text(
                                "already a user?",
                                style: TextStyle(color: Colors.green),
                              ),
                        onPressed: () {
                          setState(() {
                            isLoginPage = !isLoginPage;
                          });
                        },
                      ),
                    ),
                  ], //end of children
                )),
          ),
        ],
      ),
    );
  }
}
