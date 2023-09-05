import 'package:flutter/material.dart';

// 변수를 다른파일에서 쓰기 싫으면 앞에 언더바 _theme 이런식으로

var theme = ThemeData(
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
            backgroundColor: Colors.grey,
        )
    ),
    appBarTheme: AppBarTheme(
        color : Colors.white,
        elevation: 1,
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 25),
        actionsIconTheme: IconThemeData(color: Colors.black, size: 30)
    ),
    textTheme: TextTheme(
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      selectedLabelStyle: TextStyle(fontSize: 10),
      unselectedLabelStyle: TextStyle(fontSize: 10)
    )
);