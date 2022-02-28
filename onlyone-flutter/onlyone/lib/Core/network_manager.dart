import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:onlyone/Core/data_manager.dart';
import 'package:onlyone/models/apply_challenge.dart';
import 'package:onlyone/models/book.dart';
import 'package:onlyone/models/challenge_response.dart';
import 'package:onlyone/models/challenge_result_response.dart';
import 'package:onlyone/models/comment_request.dart';
import 'package:onlyone/models/create_challenge.dart';
import 'package:onlyone/models/error_model.dart';
import 'package:onlyone/models/feed_detail_response.dart';
import 'package:onlyone/models/feed_request.dart';
import 'package:onlyone/models/feed_response.dart';
import 'package:onlyone/models/login_info.dart';
import 'package:onlyone/models/login_request.dart';
import 'package:onlyone/models/member_response.dart';
import 'package:onlyone/models/update_member_name.dart';
import 'package:pretty_json/pretty_json.dart';

class CommonResponse<T> {
  final T? data;
  final ErrorModel? error;
  final bool didFail;

  bool get didSucceed {
    return !didFail;
  }

  CommonResponse(this.data, this.error, this.didFail);

  static CommonResponse<T> _success<T>(T data) {
    return CommonResponse(data, null, false);
  }

  static CommonResponse<T> _fail<T>(ErrorModel? error) {
    return CommonResponse(null, error, true);
  }
}

class NetworkManager {
  final _authority = "ec2-18-221-139-75.us-east-2.compute.amazonaws.com:8081";
  Map<String, String>? _headers() {
    final token = DataManager().getUserToken() ?? "";
    return {
      'Content-Type': "application/json",
      'accept': "application/json",
      'Authorization': 'Bearer $token'
    };
  }

  static final NetworkManager _instance = NetworkManager._internal();

  factory NetworkManager() {
    return _instance;
  }

  NetworkManager._internal() {
    //클래스가 최초 생성될때 1회 발생
    //초기화 코드
  }

/* 👇👇 admin-controller 👇👇 */

/* 👇👇 auth-controller 👇👇 */

  /// [POST] /api/login
  Future<CommonResponse<LoginInfo>> login(LoginRequest request) async {
    final _path = "/api/login";
    final _uri = Uri.http(_authority, _path);
    var header = _headers();
    header!['ApplicationKey'] = 'onlyone-lover';

    final response =
        await http.post(_uri, headers: header, body: jsonEncode(request));

    var responseBody = utf8.decode(response.bodyBytes);
    _printNetwork(
      request: response.request,
      body: jsonEncode(request),
      headers: header,
      response: responseBody,
    );

    try {
      if (response.statusCode == 200) {
        final loginInfo = LoginInfo.fromJson(json.decode(response.body));
        DataManager().setUserToken(loginInfo.memberToken);
        return CommonResponse._success(loginInfo);
      } else {
        final error = ErrorModel.fromJson(json.decode(responseBody));
        return CommonResponse._fail(error);
      }
    } catch (e) {
      print(e);
      return CommonResponse._fail(
          ErrorModel("알수없는에러", "$e", "알수없는에러", "알수없는에러", "$e"));
    }
  }

  /// [None]
  Future<CommonResponse> logout() async {
    try {
      DataManager().setUserToken("");
      return CommonResponse._success(null);
    } catch (e) {
      print(e);
      return CommonResponse._fail(
          ErrorModel("알수없는에러", "$e", "알수없는에러", "알수없는에러", "$e"));
    }
  }

  /// [POST] /api/verify
  Future<CommonResponse> checkVerify() async {
    final _path = "/api/verify";
    final _uri = Uri.http(_authority, _path);
    final response = await http.post(_uri, headers: _headers());

    var responseBody = utf8.decode(response.bodyBytes);
    _printNetwork(
      request: response.request,
      headers: _headers(),
      response: responseBody,
    );
    print(response.statusCode);

    try {
      if (response.statusCode == 200) {
        DataManager().isUserSignedIn = true;
        return CommonResponse._success(null);
      } else {
        final error = ErrorModel.fromJson(json.decode(responseBody));
        DataManager().isUserSignedIn = false;
        return CommonResponse._fail(error);
      }
    } catch (e) {
      print(e);
      return CommonResponse._fail(
          ErrorModel("알수없는에러", "$e", "알수없는에러", "알수없는에러", "$e"));
    }
  }

/* 👇👇 challenge-controller 👇👇 */

  /// [GET] /api/challenge
  Future<CommonResponse<List<ChallengeResponse>>> getChallengeList() async {
    final _path = "/api/challenge";
    final _uri = Uri.http(_authority, _path);
    final response = await http.get(_uri, headers: _headers());

    var responseBody = utf8.decode(response.bodyBytes);
    _printNetwork(
      request: response.request,
      headers: _headers(),
      response: responseBody,
    );

    try {
      if (response.statusCode == 200) {
        //Iterable l = json.decode(response.body);
        Iterable l = json.decode(responseBody);
        final result = List<ChallengeResponse>.from(
            l.map((model) => ChallengeResponse.fromJson(model)));

        return CommonResponse._success(result);
      } else {
        final error = ErrorModel.fromJson(json.decode(responseBody));
        return CommonResponse._fail(error);
      }
    } catch (e) {
      print(e);
      return CommonResponse._fail(
          ErrorModel("알수없는에러", "$e", "알수없는에러", "알수없는에러", "$e"));
    }
  }

  /// [POST] /api/challenge
  Future<CommonResponse> createChallenge(CreateChallenge request) async {
    final _path = "/api/challenge";
    final _uri = Uri.http(_authority, _path);
    final response =
        await http.post(_uri, headers: _headers(), body: jsonEncode(request));

    var responseBody = utf8.decode(response.bodyBytes);
    _printNetwork(
      request: response.request,
      body: jsonEncode(request),
      headers: _headers(),
      response: responseBody,
    );
    print(response.statusCode);

    try {
      if (response.statusCode == 200) {
        return CommonResponse._success(null);
      } else {
        final error = ErrorModel.fromJson(json.decode(responseBody));
        return CommonResponse._fail(error);
      }
    } catch (e) {
      print(e);
      return CommonResponse._fail(
          ErrorModel("알수없는에러", "$e", "알수없는에러", "알수없는에러", "$e"));
    }
  }

  /// [GET] /api/challenge/$challengeId
  Future<CommonResponse<ChallengeResponse>> getChallenge(
      int challengeId) async {
    final _path = "/api/challenge/$challengeId";
    final _uri = Uri.http(_authority, _path);
    final response = await http.get(_uri, headers: _headers());

    var responseBody = utf8.decode(response.bodyBytes);
    _printNetwork(
      request: response.request,
      headers: _headers(),
      response: responseBody,
    );

    try {
      if (response.statusCode == 200) {
        final result = ChallengeResponse.fromJson(json.decode(responseBody));
        return CommonResponse._success(result);
      } else {
        final error = ErrorModel.fromJson(json.decode(responseBody));
        return CommonResponse._fail(error);
      }
    } catch (e) {
      print(e);
      return CommonResponse._fail(
          ErrorModel("알수없는에러", "$e", "알수없는에러", "알수없는에러", "$e"));
    }
  }

  /// [DELETE] /api/challenge/$challengeId
  Future<CommonResponse> deleteChallenge(int challengeId) async {
    final _path = "/api/challenge/$challengeId";
    final _uri = Uri.http(_authority, _path);
    final response = await http.delete(_uri, headers: _headers());

    var responseBody = utf8.decode(response.bodyBytes);
    _printNetwork(
      request: response.request,
      headers: _headers(),
      response: responseBody,
    );

    try {
      if (response.statusCode == 204) {
        return CommonResponse._success(null);
      } else {
        final error = ErrorModel.fromJson(json.decode(responseBody));
        return CommonResponse._fail(error);
      }
    } catch (e) {
      print(e);
      return CommonResponse._fail(
          ErrorModel("알수없는에러", "$e", "알수없는에러", "알수없는에러", "$e"));
    }
  }

  /// [PATCH] /api/challenge/{challengeId}/start-now
  Future<CommonResponse> startNowChallenge(int challengeId) async {
    final _path = "/api/challenge/$challengeId/start-now";
    final _uri = Uri.http(_authority, _path);
    final response = await http.patch(_uri, headers: _headers());

    var responseBody = utf8.decode(response.bodyBytes);
    _printNetwork(
      request: response.request,
      headers: _headers(),
      response: responseBody,
    );

    try {
      if (response.statusCode == 204) {
        return CommonResponse._success(null);
      } else {
        final error = ErrorModel.fromJson(json.decode(responseBody));
        return CommonResponse._fail(error);
      }
    } catch (e) {
      print(e);
      return CommonResponse._fail(
          ErrorModel("알수없는에러", "$e", "알수없는에러", "알수없는에러", "$e"));
    }
  }

  /// [POST] /api/challenge/apply
  Future<CommonResponse> applyChallenge(ApplyChallenge request) async {
    final _path = "/api/challenge/apply";
    final _uri = Uri.http(_authority, _path);
    final response =
        await http.post(_uri, headers: _headers(), body: jsonEncode(request));

    var responseBody = utf8.decode(response.bodyBytes);
    _printNetwork(
      request: response.request,
      body: jsonEncode(request),
      headers: _headers(),
      response: responseBody,
    );

    try {
      if (response.statusCode == 201) {
        return CommonResponse._success(null);
      } else {
        final error = ErrorModel.fromJson(json.decode(responseBody));
        return CommonResponse._fail(error);
      }
    } catch (e) {
      print(e);
      return CommonResponse._fail(
          ErrorModel("알수없는에러", "$e", "알수없는에러", "알수없는에러", "$e"));
    }
  }

  /// [DELETE] /api/challenge/{challengeId}/apply
  Future<CommonResponse> deleteApplyChallenge(int challengeId) async {
    final _path = "/api/challenge/$challengeId/apply";
    final _uri = Uri.http(_authority, _path);
    final response = await http.delete(_uri, headers: _headers());

    var responseBody = utf8.decode(response.bodyBytes);
    _printNetwork(
      request: response.request,
      headers: _headers(),
      response: responseBody,
    );

    try {
      if (response.statusCode == 204) {
        return CommonResponse._success(null);
      } else {
        final error = ErrorModel.fromJson(json.decode(responseBody));
        return CommonResponse._fail(error);
      }
    } catch (e) {
      print(e);
      return CommonResponse._fail(
          ErrorModel("알수없는에러", "$e", "알수없는에러", "알수없는에러", "$e"));
    }
  }

  /// [GET] /api/challenge/books
  Future<CommonResponse<List<Book>>> getBookList(String bookName) async {
    final _path = "/api/challenge/books";
    final _uri = Uri.http(_authority, _path, {"bookName": bookName});
    final response = await http.get(_uri, headers: _headers());

    var responseBody = utf8.decode(response.bodyBytes);
    _printNetwork(
      request: response.request,
      headers: _headers(),
      response: responseBody,
    );

    try {
      if (response.statusCode == 200) {
        Iterable l = json.decode(responseBody);
        final list = List<Book>.from(l.map((model) => Book.fromJson(model)));
        return CommonResponse._success(list);
      } else {
        final error = ErrorModel.fromJson(json.decode(responseBody));
        return CommonResponse._fail(error);
      }
    } catch (e) {
      print(e);
      return CommonResponse._fail(
          ErrorModel("알수없는에러", "$e", "알수없는에러", "알수없는에러", "$e"));
    }
  }

  /// [GET] /api/challenge/$challengeId/result
  Future<CommonResponse<ChallengeResultResponse>> getChallengeResult(
      int challengeId) async {
    final _path = "/api/challenge/$challengeId/result";
    final _uri = Uri.http(_authority, _path);
    final response = await http.get(_uri, headers: _headers());

    var responseBody = utf8.decode(response.bodyBytes);
    _printNetwork(
      request: response.request,
      headers: _headers(),
      response: responseBody,
    );

    try {
      if (response.statusCode == 200) {
        //Iterable l = json.decode(response.body);
        final result =
            ChallengeResultResponse.fromJson(json.decode(responseBody));
        return CommonResponse._success(result);
      } else {
        final error = ErrorModel.fromJson(json.decode(responseBody));
        return CommonResponse._fail(error);
      }
    } catch (e) {
      print(e);
      return CommonResponse._fail(
          ErrorModel("알수없는에러", "$e", "알수없는에러", "알수없는에러", "$e"));
    }
  }

  /// [GET] /api/challenge/books/{isbn}
  Future<CommonResponse<List<FeedResponse>>> getTotalFeedList(
      String isbn) async {
    final _path = "/api/challenge/books/$isbn";
    final _uri = Uri.http(_authority, _path);
    final response = await http.get(_uri, headers: _headers());

    var responseBody = utf8.decode(response.bodyBytes);
    _printNetwork(
      request: response.request,
      headers: _headers(),
      response: responseBody,
    );

    try {
      if (response.statusCode == 200) {
        //Iterable l = json.decode(response.body);
        Iterable l = json.decode(responseBody);
        final result = List<FeedResponse>.from(
            l.map((model) => FeedResponse.fromJson(model)));

        return CommonResponse._success(result);
      } else {
        final error = ErrorModel.fromJson(json.decode(responseBody));
        return CommonResponse._fail(error);
      }
    } catch (e) {
      print(e);
      return CommonResponse._fail(
          ErrorModel("알수없는에러", "$e", "알수없는에러", "알수없는에러", "$e"));
    }
  }

/* 👇👇 feed-controller 👇👇 */

  /// [GET] /api/challenges/{challengeId}/feeds
  Future<CommonResponse<List<FeedResponse>>> getFeedList(
      int challengeId) async {
    final _path = "/api/challenges/$challengeId/feeds";
    final _uri = Uri.http(_authority, _path);
    final response = await http.get(_uri, headers: _headers());

    var responseBody = utf8.decode(response.bodyBytes);
    _printNetwork(
      request: response.request,
      headers: _headers(),
      response: responseBody,
    );

    try {
      if (response.statusCode == 200) {
        Iterable l = json.decode(responseBody);
        final list = List<FeedResponse>.from(
            l.map((model) => FeedResponse.fromJson(model)));
        return CommonResponse._success(list);
      } else {
        final error = ErrorModel.fromJson(json.decode(responseBody));
        return CommonResponse._fail(error);
      }
    } catch (e) {
      print(e);
      return CommonResponse._fail(
          ErrorModel("알수없는에러", "$e", "알수없는에러", "알수없는에러", "$e"));
    }
  }

  /// [GET] /api/challenges/$challengeId/feeds/$feedId
  Future<CommonResponse<FeedDetailResponse>> getFeed(
      int challengeId, int feedId) async {
    final _path = "/api/challenges/$challengeId/feeds/$feedId";
    final _uri = Uri.http(_authority, _path);
    final response = await http.get(_uri, headers: _headers());

    var responseBody = utf8.decode(response.bodyBytes);
    _printNetwork(
      request: response.request,
      headers: _headers(),
      response: responseBody,
    );

    try {
      if (response.statusCode == 200) {
        //Iterable l = json.decode(response.body);
        final result = FeedDetailResponse.fromJson(json.decode(responseBody));
        return CommonResponse._success(result);
      } else {
        final error = ErrorModel.fromJson(json.decode(responseBody));
        return CommonResponse._fail(error);
      }
    } catch (e) {
      print(e);
      return CommonResponse._fail(
          ErrorModel("알수없는에러", "$e", "알수없는에러", "알수없는에러", "$e"));
    }
  }

  /// [DELETE] /api/challenges/{challengeId}/feeds/{feedId}
  Future<CommonResponse> deleteFeed(int challegeId, int feedId) async {
    final _path = "/api/challenges/$challegeId/feeds/$feedId";
    final _uri = Uri.http(_authority, _path);
    final response = await http.delete(_uri, headers: _headers());

    var responseBody = utf8.decode(response.bodyBytes);
    _printNetwork(
      request: response.request,
      headers: _headers(),
      response: responseBody,
    );

    try {
      if (response.statusCode == 200) {
        return CommonResponse._success(null);
      } else {
        final error = ErrorModel.fromJson(json.decode(responseBody));
        return CommonResponse._fail(error);
      }
    } catch (e) {
      print(e);
      return CommonResponse._fail(
          ErrorModel("알수없는에러", "$e", "알수없는에러", "알수없는에러", "$e"));
    }
  }

  /// [POST] /api/challenges/feed-comment-like
  Future<CommonResponse> likeFeedComment(int commentId) async {
    final _path = "/api/challenges/feed-comment-like";
    final _uri = Uri.http(_authority, _path);
    final response = await http.post(_uri,
        headers: _headers(), body: jsonEncode({"commentId": commentId}));

    var responseBody = utf8.decode(response.bodyBytes);
    _printNetwork(
      request: response.request,
      headers: _headers(),
      response: responseBody,
    );

    try {
      if (response.statusCode == 201) {
        return CommonResponse._success(null);
      } else {
        final error = ErrorModel.fromJson(json.decode(responseBody));
        return CommonResponse._fail(error);
      }
    } catch (e) {
      print(e);
      return CommonResponse._fail(
          ErrorModel("알수없는에러", "$e", "알수없는에러", "알수없는에러", "$e"));
    }
  }

  /// [POST] /api/challenges/feed-comments
  Future<CommonResponse> commentFeed(CommentRequest request) async {
    final _path = "/api/challenges/feed-comments";
    final _uri = Uri.http(_authority, _path);
    final response =
        await http.post(_uri, headers: _headers(), body: jsonEncode(request));

    var responseBody = utf8.decode(response.bodyBytes);
    _printNetwork(
      request: response.request,
      body: jsonEncode(request),
      headers: _headers(),
      response: responseBody,
    );

    try {
      if (response.statusCode == 201) {
        return CommonResponse._success(null);
      } else {
        final error = ErrorModel.fromJson(json.decode(responseBody));
        return CommonResponse._fail(error);
      }
    } catch (e) {
      print(e);
      return CommonResponse._fail(
          ErrorModel("알수없는에러", "$e", "알수없는에러", "알수없는에러", "$e"));
    }
  }

  /// [DELETE] /api/challenges/{challengeId}/feeds/{feedId}
  Future<CommonResponse> deleteComment(int commentId) async {
    final _path = "/api/challenges/feed-comments/$commentId";
    final _uri = Uri.http(_authority, _path);
    final response = await http.delete(_uri, headers: _headers());

    var responseBody = utf8.decode(response.bodyBytes);
    _printNetwork(
      request: response.request,
      headers: _headers(),
      response: responseBody,
    );

    try {
      if (response.statusCode == 200) {
        return CommonResponse._success(null);
      } else {
        final error = ErrorModel.fromJson(json.decode(responseBody));
        return CommonResponse._fail(error);
      }
    } catch (e) {
      print(e);
      return CommonResponse._fail(
          ErrorModel("알수없는에러", "$e", "알수없는에러", "알수없는에러", "$e"));
    }
  }

  /// [POST] /api/challenges/feed-like
  Future<CommonResponse> likeFeed(int feedId) async {
    final _path = "/api/challenges/feed-like";
    final _uri = Uri.http(_authority, _path);
    final response = await http.post(_uri,
        headers: _headers(), body: jsonEncode({"feedId": feedId}));

    var responseBody = utf8.decode(response.bodyBytes);
    _printNetwork(
      request: response.request,
      headers: _headers(),
      response: responseBody,
    );

    try {
      if (response.statusCode == 200) {
        return CommonResponse._success(null);
      } else {
        final error = ErrorModel.fromJson(json.decode(responseBody));
        return CommonResponse._fail(error);
      }
    } catch (e) {
      print(e);
      return CommonResponse._fail(
          ErrorModel("알수없는에러", "$e", "알수없는에러", "알수없는에러", "$e"));
    }
  }

  /// [POST] /api/challenges/feeds
  Future<CommonResponse> postFeed(FeedRequest request) async {
    final _path = "/api/challenges/feeds";
    final _uri = Uri.http(_authority, _path);
    final response =
        await http.post(_uri, headers: _headers(), body: jsonEncode(request));

    var responseBody = utf8.decode(response.bodyBytes);
    _printNetwork(
      request: response.request,
      headers: _headers(),
      response: responseBody,
    );
    print(response.statusCode);

    try {
      if (response.statusCode == 201) {
        return CommonResponse._success(null);
      } else {
        final error = ErrorModel.fromJson(json.decode(responseBody));
        return CommonResponse._fail(error);
      }
    } catch (e) {
      print(e);
      return CommonResponse._fail(
          ErrorModel("알수없는에러", "$e", "알수없는에러", "알수없는에러", "$e"));
    }
  }

/* 👇👇 member-controller 👇👇 */

  /// [GET] /api/members
  Future<CommonResponse<MemberResponse>> getMember() async {
    final _path = "/api/members/";
    final _uri = Uri.http(_authority, _path);
    final response = await http.get(_uri, headers: _headers());

    var responseBody = utf8.decode(response.bodyBytes);
    _printNetwork(
      request: response.request,
      headers: _headers(),
      response: responseBody,
    );

    try {
      if (response.statusCode == 200) {
        final result = MemberResponse.fromJson(json.decode(responseBody));
        return CommonResponse._success(result);
      } else {
        final error = ErrorModel.fromJson(json.decode(responseBody));
        return CommonResponse._fail(error);
      }
    } catch (e) {
      print(e);
      return CommonResponse._fail(
          ErrorModel("알수없는에러", "$e", "알수없는에러", "알수없는에러", "$e"));
    }
  }

  /// [GET] /api/members/challenges
  Future<CommonResponse<List<ChallengeResponse>>> getMemberChallenges() async {
    final _path = "/api/members/challenges";
    final _uri = Uri.http(_authority, _path);
    final response = await http.get(_uri, headers: _headers());

    var responseBody = utf8.decode(response.bodyBytes);
    _printNetwork(
      request: response.request,
      headers: _headers(),
      response: responseBody,
    );

    try {
      if (response.statusCode == 200) {
        Iterable l = json.decode(responseBody);
        final result = List<ChallengeResponse>.from(
            l.map((model) => ChallengeResponse.fromJson(model)));
        return CommonResponse._success(result);
      } else {
        final error = ErrorModel.fromJson(json.decode(responseBody));
        return CommonResponse._fail(error);
      }
    } catch (e) {
      print(e);
      return CommonResponse._fail(
          ErrorModel("알수없는에러", "$e", "알수없는에러", "알수없는에러", "$e"));
    }
  }

  /// [PATCH] /api/members/names
  Future<CommonResponse> updateMemberName(UpdateMemberName request) async {
    final _path = "/api/members/names";
    final _uri = Uri.http(_authority, _path);
    final response =
        await http.patch(_uri, headers: _headers(), body: jsonEncode(request));

    var responseBody = utf8.decode(response.bodyBytes);
    _printNetwork(
      request: response.request,
      headers: _headers(),
      response: responseBody,
    );

    try {
      if (response.statusCode == 204) {
        return CommonResponse._success(null);
      } else {
        final error = ErrorModel.fromJson(json.decode(responseBody));
        return CommonResponse._fail(error);
      }
    } catch (e) {
      print(e);
      return CommonResponse._fail(
          ErrorModel("알수없는에러", "$e", "알수없는에러", "알수없는에러", "$e"));
    }
  }
}

var logger = Logger(
  printer: PrettyPrinter(
      methodCount: 2, // number of method calls to be displayed
      errorMethodCount: 8, // number of method calls if stacktrace is provided
      lineLength: 120, // width of the output
      colors: true, // Colorful log messages
      printEmojis: true, // Print an emoji for each log message
      printTime: false // Should each log print contain a timestamp
      ),
);

_printNetwork(
    {BaseRequest? request,
    String? body,
    Map<String, String>? headers,
    required String response}) {
  var result = "\n";

  // result += "┏━━━━━━━━━━━━━━━━━━━┓\n";
  // result += "┗━━━━━━━━━━━━━━━━━━━┛";
  //
  result += "$request\n";
  result += "$headers\n";

// Request
  try {
    final request = prettyJson(jsonDecode(body ?? ""));

    result += "\n";
    result +=
        "-------------------------------- [ R E Q U E S T ] ---------------------------------------";
    result += "\n";
    result += request;
  } catch (e) {
    result += "\n";
    result +=
        "-------------------------------- [ R E Q U E S T ] ---------------------------------------";
    result += "\n";
    result += "$body\n";
  }
// Response
  try {
    result += "\n";
    result +=
        "------------------------------- [ R E S P O N S E ] --------------------------------------";
    result += "\n";
    result += prettyJson(jsonDecode(response));
    logger.v(result);
  } catch (e) {
    result += "\n";
    result +=
        "------------------------------- [ R E S P O N S E ] --------------------------------------";
    result += "\n";
    result += "$response\n";
    logger.e(result);
  }
}
