import 'package:flutter/material.dart';

void main() {
  runApp(
      const MaterialApp(
          home: MyApp()
      )
  );
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
  var total = 5;
  var name = ['홍중', '산', '윤호', '우영', '성화'];
  var like = [0, 0, 0, 0, 0];

  // 수정함수만들기
  addOne(){
    setState(() {
      total++;
    });
  }

  @override
  // context : 부모위젯의 정보 알려줌
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            // showDialog, Scaffold.of, Navigator.pop, Theme.of > context 필수로 함
            // showDialog의 경우 MaterialApp이 들어 있는 context를 입력해야 동작함
            showDialog(context: context, builder: (context){
              // 자식 위젯에 보내는 법
              return DialogUI(state : total, addOne : addOne);
            });
          },
        ),
        appBar: AppBar(title: Text(total.toString()),),
        body: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, i){
              return ListTile(
                leading: Image.asset('logo_simple.png'),
                title: Text(name[i]),
              );
            })
      );

  }
}

class DialogUI extends StatelessWidget {
  // 등록하고
  DialogUI({super.key, this.state, this.addOne});
  // 등록
  final state;
  final addOne;
  var inputData = TextEditingController();
  var inputData2 = '';
  // 많을 경우 {}나 []에 넣는다

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: 300,
        height: 300,
        child: Column(
          children: [
            TextField(controller: inputData,),
            // textfield가 많을 경우
            //TextField( onChanged: (text){inputData2 = text;},)
            TextButton(onPressed: (){addOne(); Navigator.pop(context);}, child: Text('완료')),
            // 다이얼로그 닫히게
            TextButton(onPressed: (){Navigator.pop(context);}, child: Text('취소'))
          ],
        ),
      ),
    );
  }
}


