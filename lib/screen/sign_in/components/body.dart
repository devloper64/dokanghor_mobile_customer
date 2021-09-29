import 'dart:async';

import 'package:ecommerce_customer_app/bloc/GmailLoginBloc.dart';
import 'package:ecommerce_customer_app/bloc/auth_bloc.dart';
import 'package:ecommerce_customer_app/components/LoadingWidget.dart';
import 'package:ecommerce_customer_app/components/no_account_text.dart';
import 'package:ecommerce_customer_app/components/socal_card.dart';
import 'package:ecommerce_customer_app/helper/StreamListenableBuilder.dart';
import 'package:ecommerce_customer_app/model/body/gmaillogin/GmailLoginBody.dart';
import 'package:ecommerce_customer_app/model/response/login/LoginResponse.dart';
import 'package:ecommerce_customer_app/screen/login_success/login_success_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../SharedPrefsHelper.dart';
import '../../../golbal.dart';
import '../../../size_config.dart';
import 'sign_form.dart';

class Body extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StateBody();
  }

}

class _StateBody extends State<Body>{

  late StreamSubscription<User?> loginStateSubscription;

  @override
  void initState() {
    gmailLoginBloc..drain();
    super.initState();
  }

  @override
  void dispose() {
    loginStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = Provider.of<AuthBloc>(context);

    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight! * 0.04),
                Text(
                  "Welcome Back",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenWidth(28),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Sign in with your email and password  \nor continue with social media",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight! * 0.08),
                SignForm(),
                SizedBox(height: SizeConfig.screenHeight! * 0.08),

                StreamBuilder<bool>(
                    stream: gmailLoginBloc.isLoading.stream,
                    builder: (context, AsyncSnapshot<bool> snapshot1) {
                      if (snapshot1.data == true) {
                        return LoadingWidget.buildLoadingWidget();
                      } else {
                        return  StreamListenableBuilder(
                            stream: gmailLoginBloc.subject.stream,
                            listener: (LoginResponse value) {
                              if(value.id_token.isNotEmpty){
                                print("User Token :"+value.id_token);
                                Navigator.pushNamed(context, LoginSuccessScreen.routeName);
                                SharedPrefsHelper.storeUserToken(value.id_token);
                              }
                            },
                            builder: (BuildContext context, AsyncSnapshot<LoginResponse> snapshot) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SocalCard(
                                    icon: "assets/icons/google-icon.svg",
                                    press: () {
                                      authBloc.loginGoogle();
                                      fetch();
                                    },
                                  ),
                                  SocalCard(
                                    icon: "assets/icons/smartphone.svg",
                                    press: () {

                                    },
                                  ),
                                ],
                              );
                            });
                      }
                    }),



                SizedBox(height: getProportionateScreenHeight(20)),
                NoAccountText(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  fetch(){
    var authBloc = Provider.of<AuthBloc>(context, listen: false);
    loginStateSubscription = authBloc.currentUser.listen((googleUser) {
      if (googleUser != null) {
        fcmToken().then((token) => gmailLoginBloc..login(GmailLoginBody(email: googleUser.email!, fcm: token, firstName: googleUser.displayName!, imageUrl: googleUser.photoURL!, lastName: "")));
      }

    });
  }

}
