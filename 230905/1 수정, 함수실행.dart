import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';

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

  // 함수 권한 얻는 코드
  getPermission() async {
    var status = await Permission.contacts.status;
    if (status.isGranted) {
      print('허락됨');
      // 연락처 불러오기
      var contacts = await ContactsService.getContacts();
      setState(() {
        name = contacts;
      });
      // print(contacts[0].givenName);
      // 연락처 강제로 추가하기
      // var newPerson = Contact();
      // newPerson.givenName = '민수';
      // newPerson.familyName = '김';
      // ContactsService.addContact(newPerson);

    } else if (status.isDenied) {
      print('거절됨');
      Permission.contacts.request();
      // 앱 설정화면 켜줌
      openAppSettings();
    }
  }

  // 처음 실행될때 함수 실행하려면
  // 요즘엔 이렇게안함.... 기능 필요할 때 넣는것이 낫다
  // @override
  // void initState() {
  //  super.initState();
  //  getPermission();
  //}

  // statefulwidget에 변수 만들면 자동으로 state화
  int total = 5;
  List<Contact> name = [];
  // 변수 만들 때 미리 타입을 강제 지정할 수도 있음
  // List<Contact> name = [];
  List<int> like = [0, 0, 0, 0, 0];

  addName(a){
    setState(() {
      name.add(a);
    });
  }


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
              return DialogUI(state : total, addOne : addOne, addName : addName);
            });
          },
        ),
        appBar: AppBar(title: Text(total.toString()), actions: [
          IconButton(onPressed: (){
            getPermission();
          }, icon: Icon(Icons.contacts))
        ],),
        body: ListView.builder(
            // 얼마나 반복해야할까요?
            itemCount: name.length,
            // 반복하는부분
            itemBuilder: (context, i){
              return ListTile(
                leading: Image.asset('assets/logo_simple.png'),
                // null체크.. 있으면 앞에거 null이면 뒤에거
                title: Text(name[i].givenName ?? '이름없음'),
              );
            })
    );

  }
}

class DialogUI extends StatelessWidget {
  // 등록하고
  DialogUI({super.key, this.state, this.addOne, this.addName});
  // 등록
  final state;
  final addOne;
  final addName;
  var inputData = TextEditingController();
  var inputData2 = '';
  // 많을 경우 {}나 []에 넣는다

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(20),
        width: 300,
        height: 300,
        child: Column(
          children: [
            TextField(controller: inputData,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              borderSide : BorderSide(
                color: Color(0xffA1CBA1),
                width: 3.0,
              ),
            )
            )
        ),
            // textfield가 많을 경우
            //TextField( onChanged: (text){inputData2 = text;},)
            TextButton(onPressed: (){
              addOne();
              addName(inputData.text);
              Navigator.pop(context);},
                child: Text('완료')),
            // 다이얼로그 닫히게
            TextButton(onPressed: (){Navigator.pop(context);}, child: Text('취소'))
          ],
        ),
      ),
    );
  }
}
