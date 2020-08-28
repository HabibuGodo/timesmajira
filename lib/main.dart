import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_radio/flutter_radio.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './screens/appintro.dart';
import './screens/splashscreen.dart';
import './utility/fadetransation.dart';

String debugLabelString = "";
void main() => runApp(
      // DevicePreview(
      //   enabled: !kReleaseMode,
      //   builder: (context) => 
        MyApp(),
      // ),
    );

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
// WidgetsFlutterBinding.ensureInitialized();

  String _debugLabelString = "";

  @override
  void initState() {
    super.initState();
    audioStart();
    initOneSignal();
    // initUniLinks(context);
  }

  audioStart() async {
    await FlutterRadio.audioStart();
  }

  void initOneSignal() async {
    if (!mounted) return;

    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    OneSignal.shared
        .setNotificationReceivedHandler((OSNotification notification) {
      this.setState(() {
        _debugLabelString =
            "Received notification: \n${notification.jsonRepresentation().replaceAll("\\n", "\n")}";
      });
    });

    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      print("OPENED NOTIFICATION");
      print(result.notification.jsonRepresentation().replaceAll("\\n", "\n"));
      this.setState(() {
        _debugLabelString =
            "Opened notification: \n${result.notification.jsonRepresentation().replaceAll("\\n", "\n")}";
      });
    });

    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);

    OneSignal.shared
        .promptUserForPushNotificationPermission(fallbackToSettings: true);

    OneSignal.shared.init("bae11dca-b0c9-4642-8797-b4691824c2e8", iOSSettings: {
      OSiOSSettings.autoPrompt: false,
      OSiOSSettings.inAppLaunchUrl: true
    });
  }

  // StreamSubscription _sub;

  // Future<Null> initUniLinks(BuildContext context) async {
  //   _sub = getLinksStream().listen((String link) {
  //     String parse = link.replaceFirst("app://timesmajira.co.tz/", "");
  //     print("LINK IS $link");
  //     print("AFTER PARSE IS $parse");

  //     List<String> links = parse.split("/");
  //     switch (links[0]) {
  //       case "2":
  //         print('Link Imefunguliwa');
  //         //_goToPage2(context, links[1]);
  //         break;
  //       //   case "3":
  //       //     _goToPage3(context, links[1]);
  //       //     break;
  //       default:
  //         print('Link Imefunguliwa default');
  //         // _goToPage2(context, links[1]);
  //         break;
  //     }
  //   }, onError: (error) {
  //     print("ERROR ${error.toString()}");
  //   });
  // }

  // @override
  // void dispose() {
  //   _sub?.cancel();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TimesMajira',
      theme: ThemeData(
        fontFamily: 'Raleway-SemiBold',
      ),
      home: CheckPage(),
    );
  }
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
}

bool firstRun;

class CheckPage extends StatefulWidget {
  @override
  _CheckPageState createState() => _CheckPageState();
}

class _CheckPageState extends State<CheckPage> {
  //check if the app runs for the first time after the installation
  //and save the instance for future runs
  Future checkFirst() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool firstRun = (prefs.getBool('firstRun') ?? true);
    if (!firstRun) {
      Navigator.pushReplacement(
        context,
        MyCustomRoute(
          builder: (context) => SplashScreen(),
        ),
      );
    } else {
      await prefs.setBool('firstRun', false);
      Navigator.push(
        context,
        MyCustomRoute(
          builder: (context) => AppIntro(),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    checkFirst();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
