// 05_MY_나의책장

import 'package:flutter/material.dart';

class MyBooksView extends StatefulWidget {
  @override
  _MyBooksViewState createState() => _MyBooksViewState();
}

class _MyBooksViewState extends State<MyBooksView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: IconButton(
          icon: Image.asset("images/ic_32_arrow_left.png", height: 32),
          onPressed: () {
            Navigator.pop(context);
          }),
      title: Text(
        "나의 책장",
        style: TextStyle(
            color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.white,
      elevation: 0, // 그림자
    );
  }
}
