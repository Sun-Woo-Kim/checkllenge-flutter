import 'package:json_annotation/json_annotation.dart';

part 'apply_challenge.g.dart';

@JsonSerializable()
class ApplyChallenge {
  ApplyChallenge({required this.challengeId});

  int challengeId;

  factory ApplyChallenge.fromJson(Map<String, dynamic> json) =>
      _$ApplyChallengeFromJson(json);

  Map<String, dynamic> toJson() => _$ApplyChallengeToJson(this);
}
