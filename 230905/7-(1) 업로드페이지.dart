import 'package:flutter/material.dart';

class Upload extends StatelessWidget {
  const Upload({Key? key}) : super(key: key);
  @override

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('이미지업로드화면'),
            IconButton(
                onPressed: (){
                  // MaterialApp 포함한 app 넣어야
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close)
            ),
          ],
        )
    );
  }
}