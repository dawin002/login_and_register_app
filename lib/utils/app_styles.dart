// AppStyles 클래스 정의
import 'package:flutter/material.dart';

class AppStyles {
  static TextStyle blueTextStyle() {
    return TextStyle(
      color: Colors.blue, // 파란색
      decoration: TextDecoration.none, // 밑줄 없음
    );
  }

  static TextStyle boldBlueTextStyle(double fontSize) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      color: Colors.blue, // 파란색
      decoration: TextDecoration.none, // 밑줄 없음
    );
  }
}