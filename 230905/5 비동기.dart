import 'package:flutter/material.dart';
// 변수명 겹칠 수 있으니 작명을....
import './style.dart' as style;
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  var data = [];

  getData() async {
    var result = await http.get(Uri.parse('https://codingapple1.github.io/app/data.json'));
    var result2 = jsonDecode(result.body);
    setState(() {
      data = result2;
    });
  }

  // init 에서는 async await 못씀
  @override
  void initState() {
    super.initState();
    getData();
  }


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
      body: [Home(data : data), Text('샵')][tab],
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

class Home extends StatelessWidget {
  const Home({super.key, this.data});
  final data;

  @override
  Widget build(BuildContext context) {
    if(data.isNotEmpty){
      return ListView.builder(itemCount: 3,
          itemBuilder: (c, i){
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(data[i]['image']),
                Container(
                  constraints: BoxConstraints(maxWidth: 600),
                  padding: EdgeInsets.all(20),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('좋아요 ' + data[i]['likes'].toString()),
                      Text(data[i]['user']),
                      Text(data[i]['content']),
                    ],
                  ),
                )
              ],
            );
          });
    } else {
      return CircularProgressIndicator();
    }

  }
}

