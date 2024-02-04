import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static SharedPreferences? _preferences;

  static const _keyUserId = 'userId';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();
  // init으로 생성하기

  // 사용자 ID를 설정하는 메서드
  static Future setUserId(String userId) async {
    print('[shared_preferences.dart:14] userId : $userId');
    await _preferences?.setString(_keyUserId, userId);
    print('[shared_preferences.dart:16] userId : $userId');
    // setString() : key, value 쌍을 이용해 아이디를 생성
  }

  // 사용자 ID를 가져오는 메서드
  static String getUserId() {
    final userId = _preferences?.getString(_keyUserId) ?? '';
    print('[shared_preferences.dart:23] userId : $userId');
    print('[shared_preferences.dart:24] _preferences?.getString(_keyUserId) : ${_preferences?.getString(_keyUserId)}');
    return userId;
  }
}