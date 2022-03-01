import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:onlyone/Core/data_manager.dart';
import 'package:provider/provider.dart';

import 'views/02_main/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await DataManager.initialize();

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional permission');
  } else {
    print('User declined or has not accepted permission');
  }

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (condext) => DataManager())],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  FirebaseAnalytics analytics = FirebaseAnalytics();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Text("SomethingWentWrong!!..");
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                fontFamily: "NotoSansCJKkr",
                primarySwatch: Colors.blue,
              ),
              navigatorObservers: [
                FirebaseAnalyticsObserver(analytics: analytics),
              ],
              home: ChallengeListHome(),
              // font size 고정을 위한 MediaQuery
              // https://stackoverflow.com/questions/59143443/how-to-make-flutter-app-font-size-independent-from-device-settings
              builder: EasyLoading.init(builder: (context, child) {
                return MediaQuery(
                  child: child!,
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                );
              }));
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Container(
          color: Colors.white, // loading...
        );
      },
    );

    // return MaterialApp(
    //   title: 'Flutter Demo',
    //   theme: ThemeData(
    //     primarySwatch: Colors.blue,
    //   ),
    //   home: ChallengeListHome(),
    // );
  }
}
