import 'package:firebase_auth/firebase_auth.dart';
import 'package:quizler/model/user.dart';
import 'package:quizler/views/show_error.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  User userFromFireBaseUSer(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  Future signInEmailPassword(String email, String pass) async {
    try {
      AuthResult authResult =
          await _auth.signInWithEmailAndPassword(email: email, password: pass);
      FirebaseUser firebaseUser = authResult.user;
      return userFromFireBaseUSer(firebaseUser);
    } catch (e) {
      print(e.toString());
      ShowError(e.toString());
    }
  }

  Future signUpEmailPassword(String email, String pass) async {
    try {
      AuthResult authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      FirebaseUser firebaseUser = authResult.user;
      return userFromFireBaseUSer(firebaseUser);
    } catch (e) {
      print(e.toString());
    }
  }

  Future singOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
