import 'package:flutter/material.dart';

class Upload extends StatelessWidget {
  const Upload({Key? key, this.userImage}) : super(key: key);
  final userImage;
  @override

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.file(userImage),
            Text('이미지업로드화면'),
            TextField(),
            IconButton(
                onPressed: (){
                  // MaterialApp 포함한 app 넣어야
                  // 닫는법
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close)
            ),
          ],
        )
    );
  }
}