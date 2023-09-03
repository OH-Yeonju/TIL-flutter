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
        appBar: AppBar(title : Text('앱임')),
        body: Text('안녕'),
        bottomNavigationBar: const SizedBox(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.phone),
              Icon(Icons.message),
              Icon(Icons.contact_page),
            ],
          ),
        ),
      ),
    );
  }
}

