import 'package:json_annotation/json_annotation.dart';

import 'enum/social_type.dart';

part 'login_request.g.dart';

@JsonSerializable()
class LoginRequest {
  LoginRequest({
    required this.uid,
    required this.displayName,
    required this.email,
    required this.phoneNumber,
    required this.photoURL,
    required this.socialProvider,
    required this.pushToken,
    required this.oldToken,
    required this.newToken,
    required this.socialType,
  });

  String uid;
  String displayName;
  String email;
  String phoneNumber;
  String photoURL;
  String socialProvider;
  String pushToken;
  String oldToken;
  String newToken;
  SocialType socialType;

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}
