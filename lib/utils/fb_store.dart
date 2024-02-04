import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseStoreService {

  FirebaseStoreService(this.userId) {
    print('[fb_store.dart:6] userId : $userId');
  } // 유저 아이디
  final String userId;

  // 1번 기능: 비동기 이용
  Future<int> getStamps() async {
    try {
      final DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      final _stampCount = snapshot.get('stampCount');
      return _stampCount is int ? _stampCount : 0; // null 이라면? 0으로 바꿔줘!
    } catch (e) {
      print('Error getting stamps: $e');
      return 0;
    }
  }

  // 2번 기능
  Future<void> setStamps(int stamps) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .set({'stampCount': stamps}, SetOptions(merge: true));
    } catch (e) {
      print('Error updating stamps: $e');
    }
  }

  // 3번 기능: 실시간 스탬프 개수 감지 (스탬프 개수 지속적으로 가져오는 기능)
  Stream<int> getStampsStream() {
    print('[fb_store.dart:40] userId : $userId');
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((snapshot) {
      final _stampCount = snapshot.get('stampCount');
      return _stampCount is int ? _stampCount : 0; // null 이라면? 0으로 바꿔줘!
    });
  }
}

