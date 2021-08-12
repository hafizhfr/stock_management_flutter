import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthServices {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<User> signUp(
      String fullName, String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      user.updateDisplayName(fullName);
      Fluttertoast.showToast(msg: 'Berhasil membuat akun baru.');
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: 'Password terlalu lemah.');
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(msg: 'Alamat email sudah digunakan akun lain.');
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
        Fluttertoast.showToast(msg: 'Akun tidak ditemukan.');
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: 'Password salah.');
      }
    }
  }

  static User getUser() {
    return _auth.currentUser;
  }

  static Future updateUser(String name, String email) async {
    _auth.currentUser.updateDisplayName(name);
    _auth.currentUser.updateEmail(email);
  }

  static Future signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  static Stream<User> get firebaseUserStream => _auth.authStateChanges();
}
