import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// 메인페이지 만들기(stless)
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // material theme 이용해서 유용한 ui, 위젯들 사용가능, iphone의 경우 Cupertino어쩌고
    return MaterialApp(
      // home : Center(
      //   child: Container( width: 50, height: 50, color : Color(0xffa1cba1)))
      // 상중하로 나눠주는 Scaffold위젯
      home: Scaffold(
        appBar: AppBar(title : Text('앱임')),
        // 가로로 배치하기
        // 세로로 배치시 Column
        body: Row(
          // 중앙정렬
          mainAxisAlignment: MainAxisAlignment.center,
          // 세로정렬
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.star),
            Icon(Icons.star),
            Icon(Icons.star)
          ],
        ),
        bottomNavigationBar: BottomAppBar( child: Text('하단 ㅎㅎ'),),
      ),
    );
  }
}

