import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:onlyone/models/challenge_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'network_manager.dart';

class DataManager extends ChangeNotifier {
  static Future<DataManager> initialize() async {
    final dataManager = DataManager();
    dataManager._prefs = await SharedPreferences.getInstance();
    dataManager._isUserSignedIn = await GoogleSignIn().isSignedIn();

    dataManager._oldAuthToken = await FirebaseMessaging.instance.getToken();
    await FirebaseMessaging.instance.deleteToken();
    dataManager._newAuthToken = await FirebaseMessaging.instance.getToken();

    return dataManager;
  }

  static final DataManager _instance = DataManager._internal();

  factory DataManager() {
    return _instance;
  }

  DataManager._internal();

  late SharedPreferences _prefs;

  String? getOldAuthToken() {
    return _oldAuthToken;
  }

  String? getNewAuthToken() {
    return _newAuthToken;
  }

  String? _oldAuthToken;
  String? _newAuthToken;

  String? getUserToken() {
    return _prefs.getString("user_token");
  }

  setUserToken(String token) {
    _prefs.setString("user_token", token);
  }

  deleteToken() {
    _prefs.remove("user_token");
  }

  // isUserSignedIn
  bool _isUserSignedIn = false;
  bool get isUserSignedIn => _isUserSignedIn;
  set isUserSignedIn(bool newValue) {
    if (!newValue) {
      deleteToken();
    }
    _isUserSignedIn = newValue;
    print(_isUserSignedIn);
    notifyListeners();
  }

  // didShowIntroView
  bool get didShowIntroView => _prefs.getBool("did_show_intro_view") ?? false;
  set didShowIntroView(bool newValue) {
    _prefs.setBool("did_show_intro_view", newValue);
  }

  updateChallengeList() async {
    await _updateChallengeList();
    await _updateMyChallengeList();
    notifyListeners();
  }

  _updateChallengeList() async {
    final response = await NetworkManager().getChallengeList();
    challengeList = response.data ?? [];
  }

  _updateMyChallengeList() async {
    final response = await NetworkManager().getMemberChallenges();
    myChallengeList = response.data ?? [];
  }

  // Challenge List
  List<ChallengeResponse> _challengeList = [];
  List<ChallengeResponse> get challengeList => _challengeList;
  set challengeList(List<ChallengeResponse> newValue) {
    _challengeList = newValue;
    notifyListeners();
  }

  // My Challenge List
  List<ChallengeResponse> _myChallengeList = [];
  List<ChallengeResponse> get myChallengeList => _myChallengeList;
  set myChallengeList(List<ChallengeResponse> newValue) {
    _myChallengeList = newValue;
    notifyListeners();
  }
}
