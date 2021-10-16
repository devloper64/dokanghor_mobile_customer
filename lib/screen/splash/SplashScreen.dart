import 'dart:async';
import 'dart:ui';
import 'package:ecommerce_customer_app/SharedPrefsHelper.dart';
import 'package:ecommerce_customer_app/bloc/CategoryListBloc.dart';
import 'package:ecommerce_customer_app/bloc/NotificationBloc.dart';
import 'package:ecommerce_customer_app/model/PushNotification.dart';
import 'package:ecommerce_customer_app/screen/home/HomeScreen.dart';
import 'package:ecommerce_customer_app/screen/intro/IntroScreen.dart';
import 'package:ecommerce_customer_app/screen/notification/NotificationScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

import '../../constants.dart';
import '../../size_config.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

class MySplashScreen extends StatefulWidget {
  static String routeName = "/splash";

  @override
  _SplashState createState() => new _SplashState();
}

//background: #DB3022;
class _SplashState extends State<MySplashScreen> {


  late final FirebaseMessaging _messaging;
  late int _totalNotifications;
  PushNotification? _notificationInfo;


  void registerNotification() async {
    await Firebase.initializeApp();
    _messaging = FirebaseMessaging.instance;

    _messaging.getToken().then((value) {
      print(value);
      SharedPrefsHelper.storeFcmToken(value!);
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');


      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print(
            'Message title: ${message.notification?.title}, body: ${message.notification?.body}, data: ${message.data}');

        // Parse the message received
        PushNotification notification = PushNotification(
          title: message.notification?.title,
          body: message.notification?.body,
          dataTitle: message.data['title'],
          dataBody: message.data['body'],
        );
        notificationBloc..notification(notification);


      });
    } else {
      print('User declined or has not accepted permission');
    }
  }


  // For handling notification when the app is in terminated state
  checkForInitialMessage() async {
    await Firebase.initializeApp();
    RemoteMessage? initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      PushNotification notification = PushNotification(
        title: initialMessage.notification?.title,
        body: initialMessage.notification?.body,
        dataTitle: initialMessage.data['title'],
        dataBody: initialMessage.data['body'],
      );

      setState(() {
        _notificationInfo = notification;
        _totalNotifications++;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _totalNotifications = 0;
    registerNotification();
    checkForInitialMessage();

    // For handling notification when the app is in background
    // but not terminated
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      PushNotification notification = PushNotification(
        title: message.notification?.title,
        body: message.notification?.body,
        dataTitle: message.data['title'],
        dataBody: message.data['body'],
      );

      setState(() {
        _notificationInfo = notification;
        _totalNotifications++;
      });
    });
    Timer(Duration(seconds: 3), () async {
      bool isFirstTimeOpen = await SharedPrefsHelper.getFirstTimeOpenStatus();
      if (!isFirstTimeOpen) {
        Navigator.pushReplacementNamed(context, IntroScreen.routeName);
      } else {
        if( _notificationInfo != null){
          Navigator.pushReplacementNamed(context, NotificationScreen.routeName);
        }else{
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        }

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
        color: SPLASH_BACK,
        child: Image.asset("assets/images/splash_icon.png"));
  }
}


class NotificationBadge extends StatelessWidget {
  final int totalNotifications;

  const NotificationBadge({required this.totalNotifications});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.0,
      height: 40.0,
      decoration: new BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '$totalNotifications',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
