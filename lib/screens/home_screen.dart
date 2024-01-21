import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Home Page")),
    );
  }
}

// 이 파일 만드는 법
// 1. home_screen.dart 파일 생성
// 2. 첫줄에서 컨트롤+스페이스(커맨드+스페이스) 누르고 stful 입력후 엔터
// 3. class 이름 HomePage 로 적고 엔터
// 4. return 문에 Placeholder로 되어 있는거 Scaffold로 바꾸기
// 5. Scaffold 괄호 안에 body: Text("Home Page") 입력
// 6. Text 에다가 커서 찍어두고 알트+엔터 후 Wrap with Center 선택
// 이 뒤에도 Text 나 Center 등에 커서 찍어두고 알트+엔터 해서 여러개 쭉 봤었어요!