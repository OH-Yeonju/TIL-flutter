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
        body: Container(
          height: 150,
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Image.asset('logo_simple.png', width: 150,),
              Expanded(child: Container(
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('카메라 팝니다'),
                    Text('금호동 3가'),
                    Text('7000원'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.favorite),
                        Text('4')
                      ],
                    ),
                  ],
                )
              )
              ),
            ],
          ),
        )
      )
    );
  }
}

