import 'dart:async';
//import 'dart:convert';

import 'package:flutter/material.dart';
//import 'package:http/http.dart' as http;
import 'package:onlyone/models/login_info.dart';

class NetworkTest extends StatefulWidget {
  @override
  _NetworkTestState createState() => _NetworkTestState();
}

class _NetworkTestState extends State<NetworkTest> {
  Future<LoginInfo>? loginInfo;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example'),
        ),
        bottomNavigationBar: TextButton(
          child: Container(
            child: Text("login test (check console)"),
            height: 50,
          ),
          onPressed: () async {
            // final info = await NetworkManager().login();
            // print(info.memberToken);

            setState(() async {
              // final request = LoginRequest(
              //   "uid",
              //   "displayName",
              //   "email",
              //   "phoneNumber",
              //   "photoURL",
              //   "socialProvider",
              //   "pushToken",
              // );
              // final response = await NetworkManager().login(request);
              // this.loginInfo = Future<LoginInfo>.value(response.data);
            });
          },
        ),
        body: Center(
          child: FutureBuilder<LoginInfo>(
            future: loginInfo,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data?.memberToken ?? "");
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // 기본적으로 로딩 Spinner를 보여줍니다.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
