import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// 메인페이지 만들기(stless)
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title : Text('앱임')),
        body: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            width: double.infinity, height: 50,
              margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
              // 기타 데코레이션은 여기에
              decoration: BoxDecoration(
              color: Colors.blue,
              border: Border.all(color: Colors.black)
              ),
              // margin: EdgeInsets.all(20)
            child: Text('하하'),
          ),
        ),
      ),
    );
  }
}

