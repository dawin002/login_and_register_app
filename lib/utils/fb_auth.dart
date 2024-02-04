import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_register_app/utils/helpers/navigation_helper.dart';
import 'package:login_register_app/values/app_routes.dart';

import '../values/shared_preferences.dart';

// 파이어베이스 서버랑 통신을 하기 위한 코드

class FirebaseAuthService {

  // 파이어베이스 어쓰에서 값을 가져오고 있다!
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // 1번 기능: 로그인
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("Sign in(Login) succeed");
      print("[fb_auth.dart:22] User uid : ${userCredential.user!.uid}"); // 얘는 정상적으로 나옴
      setCurrentUserId(userCredential.user!.uid); // 이 부분 없어서 에러나던 것?
      NavigationHelper.pushReplacementNamed(
        AppRoutes.default_card,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      // Handle the exception
      print("Sign in error: ${e.message}");
      return null;
    }
  }

  // 2번 기능: 회원가입
  Future<User?> signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("Sign up(register) succeed");
      NavigationHelper.pushReplacementNamed(
        AppRoutes.login,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      // Handle the exception
      print("Sign up error: ${e.message}");
      return null;
    }
  }

  // 3번 기능: 로그아웃
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // 4번 기능: 로그인한 유저 아이디 가져오기
  Future<void> setCurrentUserId(String _userId) async {
    print('[fb_auth.dart:61] _userId : $_userId');
    await UserPreferences.setUserId(_userId);
    print('[fb_auth.dart:63] _userId : $_userId');
  }
}