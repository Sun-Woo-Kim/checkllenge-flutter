// 01_login

import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:onlyone/Core/color_theme.dart';
import 'package:onlyone/Core/data_manager.dart';
import 'package:onlyone/Core/font_theme.dart';
import 'package:onlyone/Core/network_manager.dart';
import 'package:onlyone/models/enum/social_type.dart';
import 'package:onlyone/models/login_request.dart';
import 'package:onlyone/views/02_main/home.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  GoogleSignIn _googleSignIn = GoogleSignIn();

  late FirebaseAuth _auth;

  @override
  void initState() {
    super.initState();

    initApp();
  }

  void initApp() async {
    FirebaseApp defaultApp = await Firebase.initializeApp();
    _auth = FirebaseAuth.instanceFor(app: defaultApp);
    _auth.signOut();
    DataManager().isUserSignedIn = false;
    NetworkManager().logout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar(),
        body: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                Image.asset(
                  "images/logo_01.png",
                  height: 210,
                ),
                Spacer(),
                TextButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: BorderSide(color: ColorTheme.gray300)))),
                  onPressed: () {
                    onGoogleSignIn(context);
                  },
                  child: Container(
                      height: 48,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Image.asset('images/ic_google.png', height: 20),
                          SizedBox(width: 4),
                          Text("구글 계정으로 로그인",
                              style: FontTheme.p_with(ColorTheme.gray900))
                        ],
                      )),
                ),
                SizedBox(height: 8),
                (Platform.isIOS)
                    ? TextButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.black),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    side: BorderSide(color: Colors.black)))),
                        onPressed: () {
                          onAppleSignIn(context);
                        },
                        child: Container(
                            height: 48,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Image.asset('images/ic_apple.png', height: 20),
                                SizedBox(width: 4),
                                Text("Apple로 로그인",
                                    style: FontTheme.p_with(Colors.white))
                              ],
                            )),
                      )
                    : Container(),
                TextButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ))),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                ChallengeListHome()),
                        (route) => false);
                  },
                  // color: isUserSignedIn ? Colors.black : Colors.black,
                  child: Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("일단 둘러보기",
                              style: FontTheme.p_with(ColorTheme.gray700))
                        ],
                      )),
                ),
                Spacer(),
                Text("회원가입 시 개인정보처리방침 및 이용약관에\n동의한 것으로 간주합니다.",
                    textAlign: TextAlign.center,
                    style: FontTheme.p_with(ColorTheme.gray700)),
                SizedBox(height: 28)
              ],
            )));
  }

  AppBar _buildAppBar() {
    return AppBar(
        leading: Container(),
        // IconButton(
        //   icon: Icon(Icons.clear, size: 30),
        //   color: Colors.black,
        //   onPressed: () {
        //     Navigator.pushAndRemoveUntil(
        //         context,
        //         MaterialPageRoute(
        //             builder: (BuildContext context) => ChallengeListHome()),
        //         (route) => false);
        //   },
        // ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        actions: [
          // IconButton(
          //   icon: Icon(Icons.clear, size: 30),
          //   color: Colors.black,
          //   onPressed: () {
          //     Navigator.of(context).popUntil((route) => route.isFirst);
          //   },
          // ),
          Padding(padding: EdgeInsets.only(right: 10)),
        ]);
  }

  Future<User?> _handleGoogleSignIn() async {
    if (_auth.currentUser != null) {
      return _auth.currentUser!;
    }

    _googleSignIn.signOut();
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      return null;
    }
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final user = (await _auth.signInWithCredential(credential)).user!;
    return user;
  }

  void onGoogleSignIn(BuildContext context) async {
    User? user = await _handleGoogleSignIn();
    if (user == null) {
      return;
    }

    final oldToken = DataManager().getOldAuthToken();
    final newToken = DataManager().getNewAuthToken();
    final request = LoginRequest(
        uid: user.uid,
        displayName: user.displayName ?? "",
        email: user.email ?? "",
        phoneNumber: user.phoneNumber ?? "",
        photoURL: user.photoURL ?? "",
        socialProvider: "Google",
        pushToken: newToken ?? "",
        oldToken: oldToken ?? "",
        newToken: newToken ?? "",
        socialType: SocialType.Google);

    final response = await NetworkManager().login(request);
    final loginInfo = response.data;

    if (response.didSucceed) {
      print("로그인 성공!");
      print("${loginInfo?.memberToken}");
    } else {
      print("로그인 실패!");
    }

    // var userSignedIn = await Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //       builder: (context) => WelcomeUserWidget(user, _googleSignIn)),
    // );
    DataManager().isUserSignedIn = true;
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => ChallengeListHome()),
        (route) => false);

    // setState(() {
    //   isUserSignedIn = userSignedIn == null ? true : false;
    // });
  }

  Future<User?> _handleAppleSignIn() async {
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      accessToken: appleCredential.authorizationCode,
    );

    final user = (await _auth.signInWithCredential(oauthCredential)).user;
    return user;
  }

  void onAppleSignIn(BuildContext context) async {
    User? user = await _handleAppleSignIn();
    if (user == null) {
      return;
    }
    final oldToken = DataManager().getOldAuthToken();
    final newToken = DataManager().getNewAuthToken();

    final request = LoginRequest(
        uid: user.uid,
        displayName: user.displayName ?? "",
        email: user.email ?? "",
        phoneNumber: user.phoneNumber ?? "",
        photoURL: user.photoURL ?? "",
        socialProvider: "Apple",
        pushToken: newToken ?? "",
        oldToken: oldToken ?? "",
        newToken: newToken ?? "",
        socialType: SocialType.Apple);

    final response = await NetworkManager().login(request);
    final loginInfo = response.data;

    if (response.didSucceed) {
      print("로그인 성공!");
      print("${loginInfo?.memberToken}");
      DataManager().isUserSignedIn = true;
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => ChallengeListHome()),
          (route) => false);
    } else {
      print("로그인 실패!");
      DataManager().isUserSignedIn = false;
    }

    // var userSignedIn = await Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //       builder: (context) => WelcomeUserWidget(user, _googleSignIn)),
    // );

    // setState(() {
    //   isUserSignedIn = userSignedIn == null ? true : false;
    // });
  }
}

class WelcomeUserWidget extends StatelessWidget {
  final GoogleSignIn? _googleSignIn;
  final User? _user;

  WelcomeUserWidget(this._user, this._googleSignIn);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
        ),
        body: Container(
            color: Colors.white,
            padding: EdgeInsets.all(50),
            child: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ClipOval(
                        child: Image.network(_user!.photoURL!,
                            width: 100, height: 100, fit: BoxFit.cover)),
                    SizedBox(height: 20),
                    Text('Welcome,', textAlign: TextAlign.center),
                    Text(_user!.displayName!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25)),
                    SizedBox(height: 20),
                    FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        onPressed: () async {
                          await _googleSignIn?.signOut();
                          DataManager().deleteToken();
                          DataManager().isUserSignedIn = false;

                          await Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      ChallengeListHome()),
                              (route) => false);
                        },
                        color: Colors.redAccent,
                        child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.exit_to_app, color: Colors.white),
                                SizedBox(width: 10),
                                Text('Log out of Google',
                                    style: TextStyle(color: Colors.white))
                              ],
                            ))),
                  ],
                ))));
  }
}
