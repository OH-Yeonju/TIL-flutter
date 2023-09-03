import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}





// 메인페이지 만들기(stless)
// state 사용시 state사용하는 위젯이 자동 재렌더링
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // statefulwidget에 변수 만들면 자동으로 state화
  var a = 1;
  var name = ['홍중', '산', '윤호', '우영', '성화'];
  var like = [0, 0, 0, 0, 0];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Text(a.toString()),
          onPressed: (){
            // state 변경하려면 setState
            setState(() {
              a++;
            });
          },
        ),
        appBar: AppBar(title: Text('연락처앱'),),
        body: ListView.builder(
          itemCount: 5,
          // 파라미터 2개 꼭 넣어야함 i = 반복생성될때마다 +1씩 되는 정수
          itemBuilder: (context, i){
          return ListTile(
            leading: Text(like[i].toString()),
            title: Text(name[i]),
            trailing: ElevatedButton(child: Text('좋아요'), onPressed: (){
              setState(() {
                like[i]++;
              });
            },),
          );
        },
    ),
      )
    );
  }
}

