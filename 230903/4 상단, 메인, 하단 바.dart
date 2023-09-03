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
        // leading : 왼쪽에 넣을 아이콘 title: 왼쪽 제목 actions:[우측아이콘들]
        appBar: AppBar(leading: Icon(Icons.star), title: Text('개신기해'),),
        body:SizedBox(
          child: ElevatedButton(child: Text('글자'), onPressed: (){},
          style: ButtonStyle(),),
          //child: Text('안녕하세요',
              //style: TextStyle( color: Colors.red,
              //fontWeight: FontWeight.w700)),
    ),
    ),
    );
  }
}

