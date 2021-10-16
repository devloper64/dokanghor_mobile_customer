import 'package:ecommerce_customer_app/model/PushNotification.dart';
import 'package:ecommerce_customer_app/model/body/login/LoginBody.dart';
import 'package:ecommerce_customer_app/screen/splash/SplashScreen.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';

import '../constants.dart';


class NotificationBloc{

  final BehaviorSubject<PushNotification> _subject = BehaviorSubject<PushNotification>();

  notification(PushNotification pushNotification) async {
    _subject.sink.add(pushNotification);
    showSimpleNotification(
      Text(pushNotification.title!.isNotEmpty?pushNotification.title!:pushNotification.dataTitle!),
      leading: NotificationBadge(totalNotifications: 1),
      subtitle: Text(pushNotification.body!.isNotEmpty?pushNotification.body!:pushNotification.dataBody!),
      background: kPrimaryColor,
      duration: Duration(seconds: 10),
    );
  }
  dispose() {
    _subject.close();
  }

  BehaviorSubject<PushNotification> get subject => _subject;

}

final notificationBloc = NotificationBloc();
