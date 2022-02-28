import 'package:json_annotation/json_annotation.dart';

part 'member_response.g.dart';

@JsonSerializable()
class MemberResponse {
  MemberResponse(
    this.displayName,
    this.email,
    this.photoURL,
    this.socialProvider,
    this.totalChallengeCount,
    this.finishedChallengeCount,
    this.successChallengeCount,
    this.successChallengePercent,
  );
  String displayName;
  String email;
  String photoURL;
  String socialProvider;
  int totalChallengeCount;
  int finishedChallengeCount;
  int successChallengeCount;

  String successChallengePercent;

  factory MemberResponse.fromJson(Map<String, dynamic> json) =>
      _$MemberResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MemberResponseToJson(this);
}
