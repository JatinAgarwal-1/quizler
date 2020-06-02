import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quizler/services/auth.dart';
import 'package:quizler/views/signin.dart';
import 'package:quizler/widgets/widgets.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formkey = GlobalKey<FormState>();
  AuthService authService = AuthService();
  String email;
  String pass;
  String name;
  bool _isLoading = false;

  Future signUpEmailPassword(String email, String pass) async {
    FirebaseUser firebaseUser;
    try {
      AuthResult authResult = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: pass);
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
    await firebaseUser.sendEmailVerification();
  }

  signUp() async {
    if (_formkey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      await signUpEmailPassword(email, pass).then((value) {
        if (value != null) {
          setState(() {
            _isLoading = false;
          });
//          HelperFunction.setUserLoggedInDetails(isLoggedIn: true);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => SignIn(),
              ));
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
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : Form(
              key: _formkey,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    Spacer(),
                    TextFormField(
                      validator: (val) => val.isEmpty ? "Enter Name" : null,
                      decoration: InputDecoration(
                        hintText: 'Name',
                      ),
                      onChanged: (val) {
                        name = val;
                      },
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    TextFormField(
                      validator: (val) => val.isEmpty ? "Enter Email" : null,
                      decoration: InputDecoration(
                        hintText: 'Email',
                      ),
                      onChanged: (val) {
                        email = val;
                      },
                    ),
                    SizedBox(
                      height: 6,
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
                        signUp();
                      },
                      child: blueButton(context, 'Sign Up'),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: TextStyle(fontSize: 15),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignIn()));
                          },
                          child: Text(
                            'Sign In',
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
