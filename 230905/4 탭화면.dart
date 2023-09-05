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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var tab = 0;


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
      body: [Text('홈'), Text('샵')][tab],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        // 파라미터 하나 꼭 입력 i = 지금 누른 버튼 번호임
        onTap: (i){
          setState(() {
            tab = i;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined), label: '샵')
        ],
      ),

    );
  }
}
