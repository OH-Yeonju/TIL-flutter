import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// 이렇게 해도 되는데 성능상 이슈
// 변하지 않는  ui들은 변수 함수로 축약해도 상관 x
// var a = SizedBox(
//  child: Text('안녕'),
// );

// 메인페이지 만들기(stless)
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: ShopItem(),
      )
    );
  }
}


class ShopItem extends StatelessWidget {
  const ShopItem({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Text('안녕'),
    );
  }
}
