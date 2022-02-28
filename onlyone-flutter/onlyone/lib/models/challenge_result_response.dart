import 'package:json_annotation/json_annotation.dart';

import 'enum/challenge_member_status.dart';

part 'challenge_result_response.g.dart';

@JsonSerializable()
class ChallengeResultResponse {
  ChallengeResultResponse(
    this.challengeId,
    this.memberId,
    this.certificationCount,
    this.certificationTotalCount,
    this.certificationRate,
    this.challengeMemberStatus,
  );

  // String memberToken;
  int challengeId;
  int memberId;
  int certificationCount;
  int certificationTotalCount;
  String certificationRate;
  ChallengeMemberStatus challengeMemberStatus;

  factory ChallengeResultResponse.fromJson(Map<String, dynamic> json) =>
      _$ChallengeResultResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChallengeResultResponseToJson(this);
}
