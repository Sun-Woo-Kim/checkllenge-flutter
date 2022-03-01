// will be deleted

import 'package:flutter/material.dart';

class CreateCommnetView extends StatefulWidget {
  @override
  _CreateCommnetView createState() => _CreateCommnetView();
}

class _CreateCommnetView extends State<CreateCommnetView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
        leading: Text(""), // 감추기용
        leadingWidth: 10,
        title: Text(
          "글쓰기",
          style: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0, // 그림자
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(Icons.clear, size: 40),
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          Padding(padding: EdgeInsets.only(right: 20)),
        ]);
  }
}
