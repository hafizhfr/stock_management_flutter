import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<User> signUp(
      String fullName, String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      user.updateDisplayName(fullName);
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<User> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = userCredential.user;
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('Akun tidak ditemukan.');
      } else if (e.code == 'wrong-password') {
        print('Password salah.');
      }
    }
  }

  static User getUser() {
    return _auth.currentUser;
  }

  static Future signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  static Stream<User> get firebaseUserStream => _auth.authStateChanges();
}
