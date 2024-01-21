import 'package:firebase_auth/firebase_auth.dart';

// 파이어베이스 서버랑 통신을 하기 위한 코드

class FirebaseAuthService {
  // 파이어베이스 어쓰에서 값을 가져오고 있다!
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      // Handle the exception
      print("Sign in error: ${e.message}");
      return null;
    }
  }

  Future<User?> signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      // Handle the exception
      print("Sign up error: ${e.message}");
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}