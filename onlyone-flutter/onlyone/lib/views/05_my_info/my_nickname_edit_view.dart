// 05_MY_닉네임수정
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:onlyone/Core/color_theme.dart';
import 'package:onlyone/Core/font_theme.dart';
import 'package:onlyone/Core/network_manager.dart';
import 'package:onlyone/models/member_response.dart';
import 'package:onlyone/models/update_member_name.dart';
import 'package:onlyone/views/components/popup_view.dart';

class MyNicknameEditView extends StatefulWidget {
  @override
  _MyNicknameEditViewState createState() => _MyNicknameEditViewState();
}

class _MyNicknameEditViewState extends State<MyNicknameEditView> {
  final _formKey = GlobalKey<FormState>();

  MemberResponse member = MemberResponse("blank", "", "", "", 0, 0, 0, "0.0");
  late UpdateMemberName updateMemberName;

  final editMemberName = TextEditingController();

  late bool isButtonDisabled;

  @override
  void dispose() {
    editMemberName.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    getMember();
    this.updateMemberName = UpdateMemberName(displayName: "");
    this.isButtonDisabled = true;
  }

  Future getMember() async {
    final response = await NetworkManager().getMember();

    if (response.data != null) {
      setState(() {
        this.member = response.data!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _buildBody(),
      bottomNavigationBar: _buildButton(),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Image.asset("images/ic_32_arrow_left.png", height: 32),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text("닉네임 수정하기", style: FontTheme.h4_with(ColorTheme.gray900)),
      backgroundColor: Colors.white,
      elevation: 0, // 그림자
    );
  }

  Widget _buildButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      margin: EdgeInsets.only(bottom: 40, top: 5),
      height: 56,
      child: ElevatedButton(
        onPressed: isButtonDisabled
            ? null
            : () async {
                await EasyLoading.show(
                    status: '변경 중...', maskType: EasyLoadingMaskType.black);
                changeDisplayName();
              },
        style: ButtonStyle(
          backgroundColor: isButtonDisabled
              ? MaterialStateProperty.all<Color>(ColorTheme.gray300)
              : MaterialStateProperty.all<Color>(ColorTheme.point400),
        ),
        child: Text(
          '확인',
          style: FontTheme.h4_with(
              isButtonDisabled ? ColorTheme.gray600 : Colors.white),
        ),
      ),
    );
  }

  changeDisplayName() async {
    updateMemberName = UpdateMemberName(displayName: editMemberName.text);

    print(editMemberName.text);

    final response = await NetworkManager().updateMemberName(updateMemberName);
    await EasyLoading.dismiss();
    if (response.didSucceed) {
      print("displayName 변경 성공!");
      Navigator.pop(context);
    } else {
      print("displayName 변경 실패!");
      showDialog(
        context: context,
        builder: (context) {
          return PopupView(
            title: response.error?.message,
            description: "${response.error?.error}\n${response.error?.code}",
            action: () {
              Navigator.pop(context);
            },
            actionText: "확인",
          );
        },
      );
    }
  }

  Widget _buildBody() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
            child: Text(
              "수정할 닉네임을 입력해주세요.",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 5, 20, 20),
            child: TextFormField(
              controller: editMemberName,
              decoration: InputDecoration(
                hintText: "8글자 이내로 입력해주세요",
              ),
              onChanged: (value) {
                if (value.length <= 0) {
                  setState(() {
                    isButtonDisabled = true;
                  });
                } else {
                  setState(() {
                    isButtonDisabled = false;
                  });
                }
              },
              validator: (value) => value == null ? "변경할 닉네임을 입력하세요" : null,
            ),
          ),
        ],
      ),
    );
  }
}
