import 'package:flutter/material.dart';

class SearchChallengeView extends StatefulWidget {
  @override
  _SearchChallengeView createState() => _SearchChallengeView();
}

class _SearchChallengeView extends State<SearchChallengeView> {
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
          "검색창",
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
