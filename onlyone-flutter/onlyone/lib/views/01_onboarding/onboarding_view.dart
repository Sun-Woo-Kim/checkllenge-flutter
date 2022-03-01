// 01_온보딩_step01
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:onlyone/Core/color_theme.dart';
import 'package:onlyone/Core/data_manager.dart';
import 'package:onlyone/Core/font_theme.dart';

import 'login_view.dart';
//import 'package:onlyone/views/01_onboarding/login_view.dart';

class OnboardingView extends StatefulWidget {
  @override
  _OnboardingViewState createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final introKey = GlobalKey<IntroductionScreenState>();

  Widget _buildImage(String assetName) {
    return Align(
      child: Image.asset('images/$assetName.png'),
      alignment: Alignment.bottomCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    DataManager().didShowIntroView = true;

    const pageDecoration = const PageDecoration(
        descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
        pageColor: Colors.white,
        imagePadding: EdgeInsets.zero,
        titlePadding: EdgeInsets.symmetric(horizontal: 16));

    return IntroductionScreen(
      key: introKey,

      pages: [
        PageViewModel(
          titleWidget: _Title("01", "책 + 챌린지 = 책린지!\n책린지는 독서 챌린지 서비스에요."),
          bodyWidget: _Body("책린지 소개"),
          image: _buildImage('img_intro_01'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          titleWidget: _Title("02", "책 + 챌린지 = 책린지!\n책린지는 독서 챌린지 서비스에요."),
          bodyWidget: _Body("책린지를 만들고 함께 할 책린저들을 모아보세요."),
          image: _buildImage('img_intro_02'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          titleWidget: _Title("03", "책 + 챌린지 = 책린지!\n책린지는 독서 챌린지 서비스에요."),
          bodyWidget: _Body("책린지 안에서 독서를 인증하거나 토론하는\n커뮤니티 기능설명하기"),
          image: _buildImage('img_intro_03'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      // onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: const Text('Skip',
          style: TextStyle(
              fontWeight: FontWeight.w600, color: ColorTheme.point400)),
      next: const Icon(
        Icons.arrow_forward,
        color: ColorTheme.point400,
      ),
      done: const Text('시작하기',
          style: TextStyle(
              fontWeight: FontWeight.w600, color: ColorTheme.point400)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        activeColor: ColorTheme.point400,
        color: ColorTheme.gray300,
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }

  _onIntroEnd(context) {
    // Navigator.of(context).pop();

    Navigator.of(context).pushReplacement(
        new MaterialPageRoute(builder: (context) => new LoginView()));
  }
}

class _Title extends StatelessWidget {
  final String text, description;
  _Title(this.text, this.description);
  final titleStyle = TextStyle(
    fontWeight: FontWeight.bold,
    color: ColorTheme.point400,
    fontSize: 36,
  );

  final descriptionStyle = FontTheme.h3_with(ColorTheme.gray900);
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              textAlign: TextAlign.left,
              style: titleStyle,
            ),
            SizedBox(height: 20),
            Text(
              description,
              textAlign: TextAlign.left,
              style: descriptionStyle,
            ),
            SizedBox(height: 20),
          ],
        ));
  }
}

class _Body extends StatelessWidget {
  final String text;
  _Body(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Text(
        text,
        textAlign: TextAlign.left,
        style: FontTheme.p_with(ColorTheme.gray800),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: const Center(child: Text("This is the screen after Introduction")),
    );
  }
}
