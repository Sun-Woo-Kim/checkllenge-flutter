// 03_챌린지 만들기
import 'package:flutter/material.dart';
import 'package:onlyone/Core/data_manager.dart';
import 'search_book_view.dart';
import 'package:onlyone/views/01_onboarding/login_view.dart';

class CreateChallengeView extends StatefulWidget {
  @override
  _CreateChallengeViewState createState() => _CreateChallengeViewState();
}

class _CreateChallengeViewState extends State<CreateChallengeView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DataManager().isUserSignedIn ? SearchBookView() : LoginView();
  }
}
