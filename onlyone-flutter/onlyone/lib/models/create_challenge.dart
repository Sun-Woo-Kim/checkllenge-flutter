import 'package:json_annotation/json_annotation.dart';
import 'package:onlyone/models/book_request.dart';
import 'package:onlyone/models/enum/character_type.dart';
import 'package:onlyone/models/enum/read_term.dart';
import 'package:onlyone/models/enum/recruit_term.dart';

import 'enum/certification_cycle.dart';

part 'create_challenge.g.dart';

@JsonSerializable()
class CreateChallenge {
  CreateChallenge({
    required this.challengeName,
    required this.groupSize,
    required this.recruitTerm,
    required this.readTerm,
    required this.certificationCycle,
    required this.characterType,
    required this.description,
    required this.book,
  });
  String challengeName;
  int groupSize;
  RecruitTerm recruitTerm;
  ReadTerm readTerm;
  CertificationCycle certificationCycle;
  CharacterType characterType;
  String description;
  // DateTime startDate;
  // DateTime endDate;

  BookRequest book;

  factory CreateChallenge.fromJson(Map<String, dynamic> json) =>
      _$CreateChallengeFromJson(json);

  Map<String, dynamic> toJson() => _$CreateChallengeToJson(this);
}
