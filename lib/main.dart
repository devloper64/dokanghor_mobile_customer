import 'package:ecommerce_customer_app/routes.dart';
import 'package:ecommerce_customer_app/screen/splash/SplashScreen.dart';
import 'package:ecommerce_customer_app/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

import 'bloc/auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
        create: (context) => AuthBloc(),
        child: OverlaySupport(
            child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "DokanGhor",
          theme: theme(),
          initialRoute: MySplashScreen.routeName,
          routes: routes,
        )));
  }

}
