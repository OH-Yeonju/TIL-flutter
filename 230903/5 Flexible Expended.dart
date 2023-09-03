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
        body: Row(
          children: [
            Flexible(child: Container(color: Colors.blue,), flex:3,),
            Flexible(child: Container(color: Colors.green,), flex:7,),
            // 박스 하나 넓게 채우려면 Expended
          ],
        )
      )
    );
  }
}

