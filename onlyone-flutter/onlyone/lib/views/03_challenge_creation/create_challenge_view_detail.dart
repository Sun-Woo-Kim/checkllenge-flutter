// 03_챌린지 만들기_Detail

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import 'package:onlyone/Core/network_manager.dart';
import 'package:onlyone/Core/color_theme.dart';
import 'package:onlyone/Core/font_theme.dart';

import 'package:onlyone/models/book.dart';
import 'package:onlyone/models/book_request.dart';
import 'package:onlyone/models/enum/certification_cycle.dart';
import 'package:onlyone/models/enum/character_type.dart';
import 'package:onlyone/models/create_challenge.dart';
import 'package:onlyone/models/enum/read_term.dart';
import 'package:onlyone/models/enum/recruit_term.dart';

import 'package:onlyone/views/02_main/home.dart';
import 'package:onlyone/views/components/popup_view.dart';

class CreateChallengeViewDetail extends StatefulWidget {
  final Book book;

  CreateChallengeViewDetail({Key? key, required this.book}) : super(key: key);

  @override
  CreateChallengeViewDetailState createState() =>
      CreateChallengeViewDetailState();
}

class CreateChallengeViewDetailState extends State<CreateChallengeViewDetail> {
  final _formKey = GlobalKey<FormState>();

  late CreateChallenge challenge;

  final challengeName = TextEditingController();
  final description = TextEditingController();

  late bool isButtonDisabled;

  List<RadioModel> inputGroupSize = <RadioModel>[];
  List<RadioModel> inputRecruitTerm = <RadioModel>[];
  List<RadioModel> inputReadTerm = <RadioModel>[];
  List<RadioModel> inputCertificationCycle = <RadioModel>[];
  List<RadioModel> inputCharacterType = <RadioModel>[];

  @override
  void dispose() {
    challengeName.dispose();
    description.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    this.challenge = new CreateChallenge(
      challengeName: "",
      groupSize: 1,
      recruitTerm: RecruitTerm.AFTER_3_DAYS,
      readTerm: ReadTerm.WEEK_OF_2,
      certificationCycle: CertificationCycle.NONE,
      characterType: CharacterType.HARD_CERTIFICATION,
      description: "",
      book: BookRequest(
        isbn: widget.book.isbn,
        bookName: widget.book.name,
        writer: widget.book.writer,
        publisher: widget.book.publisher,
        thumbnailImagePath: widget.book.thumbnailImagePath,
      ),
    );

    this.isButtonDisabled = true;

    inputGroupSize.add(new RadioModel(true, 1, '혼자서 읽기'));
    inputGroupSize.add(new RadioModel(false, 5, '5명'));
    inputGroupSize.add(new RadioModel(false, 10, '10명'));
    inputGroupSize.add(new RadioModel(false, 20, '20명'));

    inputRecruitTerm
        .add(new RadioModel(true, RecruitTerm.AFTER_3_DAYS, '3일 뒤'));
    inputRecruitTerm
        .add(new RadioModel(false, RecruitTerm.AFTER_7_DAYS, '1주일 뒤'));
    inputRecruitTerm
        .add(new RadioModel(false, RecruitTerm.ON_FULL, '다 모이면 시작'));

    inputReadTerm.add(new RadioModel(true, ReadTerm.WEEK_OF_2, '2주'));
    inputReadTerm.add(new RadioModel(false, ReadTerm.WEEK_OF_4, '4주'));
    inputReadTerm.add(new RadioModel(false, ReadTerm.WEEK_OF_6, '6주'));
    inputReadTerm.add(new RadioModel(false, ReadTerm.WEEK_OF_8, '8주'));

    inputCertificationCycle
        .add(new RadioModel(true, CertificationCycle.NONE, '인증 없음'));
    inputCertificationCycle
        .add(new RadioModel(false, CertificationCycle.ONCE_A_WEEK, "1주일에 한 번"));
    inputCertificationCycle.add(
        new RadioModel(false, CertificationCycle.TWICE_A_WEEK, "1주일에 두 번"));
    inputCertificationCycle.add(
        new RadioModel(false, CertificationCycle.THIRD_A_WEEK, "1주일에 세 번"));

    inputCharacterType.add(
        new RadioModel(true, CharacterType.HARD_CERTIFICATION, "열심히 인증하기"));
    inputCharacterType
        .add(new RadioModel(false, CharacterType.WRITE_A_REVIEW, "감상 남기기"));
    inputCharacterType.add(
        new RadioModel(false, CharacterType.DISCUSS_ACTIVELY, "적극적으로 토론하기"));

    var keyboardVisibilityController = KeyboardVisibilityController();
    keyboardVisibilityController.onChange.listen((bool visible) {
      _checkValue();
    });
  }

  _checkValue() {
    if (challengeName.text.isNotEmpty && description.text.isNotEmpty) {
      setState(() {
        isButtonDisabled = false;
      });
    } else {
      setState(() {
        isButtonDisabled = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Container(
          child: _buildBody(), padding: EdgeInsets.symmetric(horizontal: 16)),
      bottomNavigationBar: _buildButton(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
        leading: IconButton(
            icon: Image.asset("images/ic_32_arrow_left.png", height: 32),
            onPressed: () {
              Navigator.pop(context);
            }),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(Icons.clear, size: 30),
            color: Colors.black,
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
          Padding(padding: EdgeInsets.only(right: 10)),
        ]);
  }

  _uploadChallenge() async {
    challenge.challengeName = challengeName.text;
    challenge.description = description.text;

    print(challenge.toJson());
    print(challenge.book.toJson());

    final challengeInfo = await NetworkManager().createChallenge(challenge);

    await EasyLoading.dismiss();
    if (challengeInfo.didSucceed) {
      print("챌린지 생성 성공!");
      print(challengeInfo);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => ChallengeListHome()),
          (route) => false);
    } else {
      print("챌린지 생성 실패!");
      showDialog(
          context: context,
          builder: (context) {
            return PopupView(
              title: challengeInfo.error?.message,
              description:
                  "${challengeInfo.error?.error}\n${challengeInfo.error?.code}",
              action: () {
                Navigator.pop(context);
              },
              actionText: "확인",
            );
          });
    }
  }

  Widget _buildButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      margin: EdgeInsets.only(bottom: 40, top: 5),
      height: 56,
      child: TextButton(
        child: Text(
          '만들기',
          style: FontTheme.h4_with(
              isButtonDisabled ? ColorTheme.gray600 : Colors.white),
        ),
        onPressed: isButtonDisabled
            ? null
            : () async {
                await EasyLoading.show(
                    status: '생성 중...', maskType: EasyLoadingMaskType.black);
                _uploadChallenge();
              },
        style: ButtonStyle(
          backgroundColor: isButtonDisabled
              ? MaterialStateProperty.all<Color>(ColorTheme.gray300)
              : MaterialStateProperty.all<Color>(ColorTheme.point400),
        ),
      ),
    );
  }

  Widget _buildQuestion(String item) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 32, 0, 0),
      child: Text(
        item,
        textAlign: TextAlign.left,
        style: FontTheme.h3_with(ColorTheme.gray900),
      ),
    );
  }

  Widget _buildRadioInput(List<RadioModel> item, String setType) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 8, 0, 24),
      child: new ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: item.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: new EdgeInsets.only(bottom: 8),
            child: new InkWell(
              splashColor: Colors.white,
              hoverColor: Colors.white,
              onTap: () {
                setState(() {
                  item.forEach((element) => element.isSelected = false);
                  item[index].isSelected = true;
                  switch (setType) {
                    case 'groupSize':
                      this.challenge.groupSize = item[index].value;
                      break;
                    case 'recruitTerm':
                      this.challenge.recruitTerm = item[index].value;
                      break;
                    case 'readTerm':
                      this.challenge.readTerm = item[index].value;
                      break;
                    case 'certificationCycle':
                      this.challenge.certificationCycle = item[index].value;
                      break;
                    case 'characterType':
                      this.challenge.characterType = item[index].value;
                      break;
                    default:
                      break;
                  }
                });
              },
              child: new RadioItem(item[index]),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody() {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Hero(
                    tag: challenge.book.isbn,
                    child: challenge.book.thumbnailImagePath != ""
                        ? Image.network(challenge.book.thumbnailImagePath,
                            width: 44, height: 68, fit: BoxFit.fill)
                        : Image.asset('images/img_default.png',
                            width: 44, height: 68, fit: BoxFit.fill),
                  ),
                  SizedBox(width: 20),
                  Flexible(
                    child: new Container(
                      padding: const EdgeInsets.all(2),
                      child: Text(
                        "${challenge.book.bookName}",
                        softWrap: true,
                        //overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "책린지 제목을 입력해주세요.",
                    style: FontTheme.h3_with(ColorTheme.gray900),
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: challengeName,
                    decoration: new InputDecoration(
                      // labelText: "Some Text",
                      hintText: "ex) 2주동안 달려요",
                      hintStyle: FontTheme.p_with(ColorTheme.gray700),
                      // labelStyle:
                      //     TextStyle(fontSize: 20.0, color: Colors.white),
                      filled: true,
                      fillColor: ColorTheme.gray200,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator: (value) =>
                        value!.trim().isEmpty ? "책린지 제목을 입력하세요" : null,
                    onChanged: _checkValue(),
                  ),
                  SizedBox(height: 32),
                  Divider(color: ColorTheme.gray300, height: 1),
                  _buildQuestion("몇 명이서 읽으실건가요?"),
                  _buildRadioInput(inputGroupSize, "groupSize"),
                  Divider(color: ColorTheme.gray300, height: 1),
                  _buildQuestion("언제부터 시작할까요?"),
                  _buildRadioInput(inputRecruitTerm, "recruitTerm"),
                  Divider(color: ColorTheme.gray300, height: 1),
                  _buildQuestion("얼마 동안 읽으실건가요?"),
                  _buildRadioInput(inputReadTerm, "readTerm"),
                  Divider(color: ColorTheme.gray300, height: 1),
                  _buildQuestion("인증 주기를 선택해주세요."),
                  _buildRadioInput(
                      inputCertificationCycle, "certificationCycle"),
                  Divider(color: ColorTheme.gray300, height: 1),
                  _buildQuestion("어떤 모임을 만들고 싶으세요?"),
                  _buildRadioInput(inputCharacterType, "characterType"),
                  Divider(color: ColorTheme.gray300, height: 1),
                  _buildQuestion("우리 책린지의 추가 정보를 적어주세요."),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: description,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      // labelText: "Some Text",
                      hintStyle: FontTheme.p_with(ColorTheme.gray700),
                      hintText:
                          "ex) 책린지 멤버에게 바라는 점,\n우리 책린지의 추가적인 규칙 등을 적어주세요.\n\n\n",
                      // labelStyle:
                      //     TextStyle(fontSize: 20.0, color: Colors.white),
                      filled: true,
                      fillColor: ColorTheme.gray200,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator: (value) =>
                        value!.trim().isEmpty ? "피드 내용을 입력하세요" : null,
                    onChanged: _checkValue(),
                  ),
                  SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RadioModel {
  bool isSelected;
  final dynamic value;
  final String text;

  RadioModel(this.isSelected, this.value, this.text);
}

class RadioItem extends StatelessWidget {
  final RadioModel _item;

  RadioItem(this._item);

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 48,
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Spacer(),
          new Container(
            height: 24.0,
            width: 24.0,
            child: new Center(
                child: new Image.asset(_item.isSelected
                    ? 'images/ic_32_check_orange.png'
                    : 'images/ic_32_blank.png')),
          ),
          SizedBox(width: 4),
          Text(_item.text,
              style: _item.isSelected
                  ? TextStyle(
                      color: ColorTheme.gray900,
                      fontWeight: FontWeight.w700,
                      fontSize: 16)
                  : FontTheme.p_with(ColorTheme.gray800)),
          SizedBox(width: 24),
          Spacer(),
        ],
      ),
      decoration: new BoxDecoration(
        color: _item.isSelected ? Colors.white : ColorTheme.gray200,
        border: new Border.all(
            width: 2.0,
            color: _item.isSelected ? ColorTheme.point400 : Colors.white),
        borderRadius: const BorderRadius.all(const Radius.circular(8)),
      ),
    );
  }
}
