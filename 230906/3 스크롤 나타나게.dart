import 'package:flutter/material.dart';
// 변수명 겹칠 수 있으니 작명을....
import './style.dart' as style;
import 'package:http/http.dart' as http;
import 'dart:convert';
// 스크롤관련함수들 가져다쓸수있게
import 'package:flutter/rendering.dart';
import './uploadPost.dart';
// 사진올릴때
import 'package:image_picker/image_picker.dart';
import'dart:io';
// shared preference 위해서 추가
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
// provider.. store 같은거
import 'package:provider/provider.dart';


void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (c)=> Store1()),
      ChangeNotifierProvider(create: (c)=> Store2()),
    ],
    child: MaterialApp(
        theme: style.theme,
        // initialRoute: '/',
        // routes: {
        //  '/' : (c) => Text('첫페이지'),
        //  '/detail' : (c) => Text('둘째페이지'),
        // },
        home : MyApp()
    ),
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
  var userImage;
  var userContent;

  // shared preference 에 데이터 저장(지우기 전까지 영원히 남아있음)
  saveData() async{
    var storage = await SharedPreferences.getInstance();
    // 저장하는법
    storage.setString('name', 'john');
    // 삭제하는법
    storage.remove('name');
    // 받아오는법(getBool, getString.. 확실한게 좋음)
    // var result = storage.getString('name');
    // storage.setBool 불린형 저장 / setDouble 실수 저장 / setStringList 스트링리스트저장.. 등등
    // map 자료 저장 > json으로 변환해서 저장
    var map = {'age':20};
    storage.setString('map', jsonEncode(map));
    // 꺼내려면 json을 decode
    var result = storage.getString('map') ?? '없는값';
    print(jsonDecode(result));
    // 이미지 저장하려면 cached_network_image 패키지 쓰면됨
  }


  addMyData(){
    var myData = {
      'id': data.length,
      'image': userImage,
      'likes': 5,
      'date':'July 25',
      'content':userContent,
      'liked': false,
      'user': 'John Kim'
    };
    setState(() {
      data.insert(0, myData);
    });
  }

  setUserContent(a){
    setState(() {
      userContent = a;
    });
  }

  addData(a){
    setState(() {
      data.add(a);
    });
  }

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
            onPressed: () async {
              var picker = ImagePicker();
              // 카메라띄우고싶으면 gallery 대신 카메라
              // 비디오 띄우고싶으면 pickImage 대신 pickVideo
              // 여러 이미지 선택하는경우 pickMultiImage()
              var image = await picker.pickImage(source: ImageSource.gallery);
              if(image != null){
                setState(() {
                  userImage = File(image.path);
                });
              }

              // 파일경로로 이미지 띄우는 법
              // Image.file(userImage)
              // photofilters > 필터.. 사이즈조절기능등있는 라이브러리

              // materialApp 들어있는 context 넣어야함
              Navigator.push(context,
                  // return 생략해도 되는 화살표함수
                  MaterialPageRoute(builder: (context) => Upload(userImage : userImage,
                      setUserContent : setUserContent, addMyData : addMyData)));
            },
            icon: Icon(Icons.add_box_outlined),
          ),
        ],
      ),
      body: [Home(data : data, addData : addData), Text('샵')][tab],
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

// 스크롤바 높이 측정하려면 statefulWidget이어야 함
// 부모가 보낸 state 등록은 첫  class, 사용은 두번째에서 해야함
class Home extends StatefulWidget {
  const Home({super.key, this.data, this.addData});
  final data;
  final addData;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  // 스크롤 정보저장함
  var scroll = ScrollController();

  getMore() async {
    var result = await http.get(Uri.parse('https://codingapple1.github.io/app/more1.json'));
    var result2 = jsonDecode(result.body);
    widget.addData(result2);
  }

  // 스크롤 할때마다 위치 측정해야함
  @override
  void initState() {
    super.initState();
    // 리스너 부착 : 변수가 변할때마다 코드 실행
    scroll.addListener(() {
      // 스크롤 어느정도했는지 > scroll.position.pixels
      // 최대 내릴 수 있는 높이 > maxScrollExtent
      // 스크롤되는 방향 > userScrollDirection
      if(scroll.position.pixels == scroll.position.maxScrollExtent){
        getMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // 첫 class안에 있던 변수 사용은 widget.변수명
    if(widget.data.isNotEmpty){
      return ListView.builder(itemCount: widget.data.length,
          // 얼마나 스크롤했는지 scroll에 자동으로 저장됨
          controller: scroll,
          itemBuilder: (c, i){
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 그냥 사진 올리면 file...이어서 바꿔줘야함
                widget.data[i]['image'].runtimeType == String
                    ? Image.network(widget.data[i]['image'])
                    : Image.file(widget.data[i]['image']),
                Container(
                  constraints: BoxConstraints(maxWidth: 600),
                  padding: EdgeInsets.all(20),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('좋아요 ${widget.data[i]['likes'].toString()}'),
                      // 텍스트나 이미지 클릭시... 여러동작효과있음
                      GestureDetector(
                        child: Text(widget.data[i]['user']),
                        onTap: (){
                          Navigator.push(context,
                              // 기본 파라미터 3개
                              PageRouteBuilder(pageBuilder: (c, a1, a2)=>Profile(),
                              // child > 새로띄울 페이지 c > context
                              // a1 > 페이지 전환 얼마나 됐는지 알려줌
                              // a2 > 기존 페이지 전환이 얼마나 됐는지 알려줌
                                  transitionsBuilder: (c,a1,a2,child) =>
                              // 애니메이션위젯
                                  // 이외.. 슬라이드식 > SlideTransition
                                  FadeTransition(opacity: a1, child: child),
                                // 애니메이션 동작속도 ms 단위
                                transitionDuration: Duration(milliseconds: 1500)
                              ));
                        },),
                      Text(widget.data[i]['content']),
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


//state 보관함 만드는법 provider 사용
// 이 스테이트 쓰고 싶은 위젯들을 전부 ChangeNotifierProvider 로 감싸야함
// 보통 MaterialApp을 감쌈
class Store1 extends ChangeNotifier {
  var follower = 0;
  var friend = false;
  var profileImage = [];

  getData() async {
    var result = await http.get(Uri.parse('https://codingapple1.github.io/app/profile.json'));
    var result2 = jsonDecode(result.body);
    profileImage = result2;
    notifyListeners();
  }

  // state 변경 함수 만들어놓기
  addFollower(){
    if (!friend){
      follower++;
      friend = true;
    } else {
      follower--;
      friend = false;
    }

    notifyListeners();
  }
}

class Store2 extends ChangeNotifier {
  var name = 'john kim';

  changeName(){
    name = 'john park';
    // 수정후 재렌더링 해주려면
    notifyListeners();
  }
}

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // store에 있던 state 출력문법
      appBar: AppBar(title: Text(context.watch<Store2>().name),),
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (c, i){ return Container(color: Colors.grey,);},
          itemCount: 3,
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.grey,
        ),
        Text('팔로워 ${context.watch<Store1>().follower}명'),
        ElevatedButton(onPressed: (){
          context.read<Store1>().addFollower();
          // context.read<Store1>().changeName();
        },
            child: Text('팔로우')),
        ElevatedButton(onPressed: (){
          context.read<Store1>().getData();
        },
            child: Text('사진가져오기')),
      ],
    );
  }
}
