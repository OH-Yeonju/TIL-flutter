import 'package:flutter/material.dart';
// 변수명 겹칠 수 있으니 작명을....
import './style.dart' as style;

void main() {
  runApp(MaterialApp(
    theme: style.theme,
      home : MyApp()
    )
  );
}

var a = TextStyle();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Instagram'),
        actions: [
          IconButton(
              onPressed: (){},
              icon: Icon(Icons.add_box_outlined),
              ),
        ],
      ),
      body: TextButton(onPressed: (){},
        // 이런식으로해도되는데 평소엔 굳이...
        child: Text('안녕', style: Theme.of(context).textTheme.bodyText2,),),
      // 만약 레이아웃 중간에 스타일일 바꾸고싶다면
      // 위젯으로 감싸고
      // Theme(
      // 새로운 ThemeData 만들기
      //    data: ThemeData(
      //      textTheme:
      //    ),
      //    child: Container())
    );
  }
}
