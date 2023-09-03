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
        appBar: AppBar(),
        // 무한스크롤, 자동반복문 등 해줌
        body: ListView(
          children: [
            Text('안녕'),
            Text('안녕'),
            Text('안녕'),
            Text('안녕'),
            Text('안녕'),
            Text('안녕'),
            Text('안녕'),
    ],
    ),
      )
    );
  }
}

