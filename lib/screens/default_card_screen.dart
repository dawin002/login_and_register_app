import 'package:flutter/material.dart';
import 'package:login_register_app/utils/app_styles.dart';
import 'package:login_register_app/values/app_strings.dart';
import 'package:login_register_app/values/shared_preferences.dart';
import 'package:just_audio/just_audio.dart';

import '../utils/fb_store.dart';

class DefaultCardScreen extends StatefulWidget {
  const DefaultCardScreen({Key? key}) : super(key: key);

  @override
  _DefaultCardScreenState createState() => _DefaultCardScreenState();
}

class _DefaultCardScreenState extends State<DefaultCardScreen> {
  late FirebaseStoreService _firebaseStoreService = FirebaseStoreService(UserPreferences.getUserId());
  // late FirebaseStoreService _firebaseStoreService = FirebaseStoreService('abcd');
  int _stampCount = 0;

  final AudioPlayer player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    // _loadStamps();
    _listenToStamps();
  }

  // void _loadStamps() async {
  //   var stamps = await _firebaseStoreService.getStamps();
  //   setState(() {
  //     _stampCount = stamps is int ? stamps : 0;
  //   });
  // }

  void _listenToStamps(){
    // 아래의 .listen() : 상태가 변하는지 지켜본는 함수
    _firebaseStoreService.getStampsStream().listen((stamps) {
      setState(() {
        _stampCount = stamps;
      });
    });
  }

  Future playPopCatAudio() async {
    final duration = await player.setAsset("assets/audios/pop-cat.mp3");
    await player.play();
  }

  Future playResetAudio() async {
    final duration = await player.setAsset("assets/audios/josh.mp3");
    await player.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.appName4,
          style: AppStyles.boldBlueTextStyle(20.0),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Card(
                elevation: 5, // 그림자 효과
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StampDisplayWidget(stampCount: _stampCount),
                ),
              ),
              SizedBox(height: 20),
              CollectStampButton(onPressed: () {
                setState(() {
                  if (_stampCount< 10) {
                    _stampCount++;
                    _firebaseStoreService.setStamps(_stampCount);
                  }
                });
                playPopCatAudio();
              }),
              SizedBox(height: 20),
              ResetStampButton(onPressed: () {
                setState(() {
                  _firebaseStoreService.setStamps(0);
                });
                playResetAudio();
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class StampDisplayWidget extends StatelessWidget {
  final int stampCount;

  const StampDisplayWidget({required this.stampCount});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        childAspectRatio: 1.0,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
      ),
      itemCount: 10,
      itemBuilder: (context, index) {
        return AnimatedSwitcher(
            duration: const Duration(milliseconds: 1000),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            child: Image.asset(
              index < stampCount
                  ? 'assets/images/popcat_close.png'
                  : 'assets/images/popcat_open.png',
              fit: BoxFit.cover,
            ));
      },
    );
  }
}

class CollectStampButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CollectStampButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.amber,
        onPrimary: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
      ),
      onPressed: onPressed,
      child: Text(AppStrings.stampButton, style: TextStyle(fontSize: 16)),
    );
  }
}

class ResetStampButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ResetStampButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Color(0xffE18B71),
        onPrimary: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
      ),
      onPressed: onPressed,
      child: Text(AppStrings.resetStampButton, style: TextStyle(fontSize: 16)),
    );
  }
}