import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizler/helper/constant.dart';
import 'package:quizler/services/auth.dart';
import 'package:quizler/views/signup.dart';
import 'package:quizler/widgets/widgets.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'home.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  FirebaseUser firebaseUser;
  AuthService authService = AuthService();
  FirebaseAuth _auth = FirebaseAuth.instance;
  showSignInError() {}
  final _formkey = GlobalKey<FormState>();
  String email;
  String pass;
  bool _isLoading = false;
  Future signInEmailPassword(String email, String pass) async {
    try {
      AuthResult authResult =
          await _auth.signInWithEmailAndPassword(email: email, password: pass);
      firebaseUser = authResult.user;
      return authService.userFromFireBaseUSer(firebaseUser);
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print(e.toString());
      Alert(
        context: context,
        type: AlertType.error,
        title: e.toString(),
      ).show();
    }
  }

  signIn() async {
    if (_formkey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      await signInEmailPassword(email, pass).then((value) {
        if (value != null) {
          setState(() {
            _isLoading = false;
          });
          if (firebaseUser.isEmailVerified) {
            HelperFunction.setUserLoggedInDetails(isLoggedIn: true);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Home(),
                ));
          } else {
            Alert(
                    context: context,
                    type: AlertType.error,
                    title: "Please First Verify The Email To Login")
                .show();
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
      ),
      body: _isLoading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : Form(
              key: _formkey,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    Spacer(),
                    TextFormField(
                      validator: (val) => val.isEmpty ? "Enter Email id" : null,
                      decoration: InputDecoration(
                        hintText: 'Email',
                      ),
                      onChanged: (val) {
                        email = val;
                      },
                    ),
                    TextFormField(
                      obscureText: true,
                      validator: (val) => val.isEmpty ? "Enter Password" : null,
                      decoration: InputDecoration(
                        hintText: 'Password',
                      ),
                      onChanged: (val) {
                        pass = val;
                      },
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    GestureDetector(
                        onTap: () {
                          signIn();
                        },
                        child: blueButton(context, 'Sign In')),
                    SizedBox(
                      height: 14,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account? ',
                          style: TextStyle(fontSize: 15),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUp()));
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 15,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
