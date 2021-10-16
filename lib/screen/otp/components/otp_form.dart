import 'dart:async';

import 'package:ecommerce_customer_app/bloc/PhoneLoginBloc.dart';
import 'package:ecommerce_customer_app/bloc/auth_bloc.dart';
import 'package:ecommerce_customer_app/components/LoadingWidget.dart';
import 'package:ecommerce_customer_app/components/default_button.dart';
import 'package:ecommerce_customer_app/helper/StreamListenableBuilder.dart';
import 'package:ecommerce_customer_app/model/args/VeridicationArguments.dart';
import 'package:ecommerce_customer_app/model/body/gmaillogin/GmailLoginBody.dart';
import 'package:ecommerce_customer_app/model/body/phonelogin/PhoneLoginBody.dart';
import 'package:ecommerce_customer_app/model/response/login/LoginResponse.dart';
import 'package:ecommerce_customer_app/screen/login_success/login_success_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../SharedPrefsHelper.dart';
import '../../../constants.dart';
import '../../../golbal.dart';
import '../../../size_config.dart';

class OtpForm extends StatefulWidget {
  final VerificationArguments verificationArguments;

  OtpForm({
    Key? key,
    required this.verificationArguments,
  }) : super(key: key);

  @override
  _OtpFormState createState() =>
      _OtpFormState(verificationArguments: verificationArguments);
}

class _OtpFormState extends State<OtpForm> {
  _OtpFormState({required this.verificationArguments});

  final VerificationArguments verificationArguments;

  late StreamSubscription<User?> loginStateSubscription;

  FocusNode? pin2FocusNode;
  FocusNode? pin3FocusNode;
  FocusNode? pin4FocusNode;

  FocusNode? pin5FocusNode;
  FocusNode? pin6FocusNode;

  String pin1 = '';
  String pin2 = '';
  String pin3 = '';
  String pin4 = '';
  String pin5 = '';
  String pin6 = '';

  String finalPin = '';

  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();

    pin5FocusNode = FocusNode();
    pin6FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode!.dispose();
    pin3FocusNode!.dispose();
    pin4FocusNode!.dispose();

    pin5FocusNode!.dispose();
    pin6FocusNode!.dispose();
  }

  void nextField(String value, FocusNode focusNode) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = Provider.of<AuthBloc>(context);
    return Form(
      child: Column(
        children: [
          SizedBox(height: SizeConfig.screenHeight! * 0.15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: getProportionateScreenWidth(40),
                child: TextFormField(
                  onSaved: (newValue) => pin1 = newValue!,
                  autofocus: true,
                  obscureText: true,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    pin1 = value;
                    nextField(value, pin2FocusNode!);
                  },
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(40),
                child: TextFormField(
                  onSaved: (newValue) => pin2 = newValue!,
                  focusNode: pin2FocusNode,
                  obscureText: true,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    pin2 = value;
                    nextField(value, pin3FocusNode!);
                  },
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(40),
                child: TextFormField(
                  onSaved: (newValue) => pin3 = newValue!,
                  focusNode: pin3FocusNode,
                  obscureText: true,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    pin3 = value;
                    nextField(value, pin4FocusNode!);
                  },
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(40),
                child: TextFormField(
                  onSaved: (newValue) => pin4 = newValue!,
                  focusNode: pin4FocusNode,
                  obscureText: true,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    pin4 = value;
                    nextField(value, pin5FocusNode!);
                  },
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(40),
                child: TextFormField(
                    onSaved: (newValue) => pin5 = newValue!,
                    focusNode: pin5FocusNode,
                    obscureText: true,
                    style: TextStyle(fontSize: 24),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: otpInputDecoration,
                    onChanged: (value) {
                      pin5 = value;
                      nextField(value, pin6FocusNode!);
                    }),
              ),
              SizedBox(
                width: getProportionateScreenWidth(40),
                child: TextFormField(
                  onSaved: (newValue) => pin6 = newValue!,
                  focusNode: pin6FocusNode,
                  obscureText: true,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    if (value.length == 1) {
                      pin6 = value;
                      pin6FocusNode!.unfocus();
                      // Then you need to check is the code is correct or not
                    }
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: SizeConfig.screenHeight! * 0.15),
          StreamBuilder<bool>(
              stream: phoneLoginBloc.isLoading.stream,
              builder: (context, AsyncSnapshot<bool> snapshot1) {
                if (snapshot1.data == true) {
                  return LoadingWidget.buildLoadingWidget();
                }else{
                  return  StreamListenableBuilder(
                      stream: phoneLoginBloc.subject.stream,
                      listener: (LoginResponse value) {
                        if(value.id_token.isNotEmpty){
                          print("User Token :"+value.id_token);
                          Navigator.pushNamed(context, LoginSuccessScreen.routeName);
                          SharedPrefsHelper.storeUserToken(value.id_token);
                        }
                      },
                      builder: (BuildContext context, AsyncSnapshot<LoginResponse> snapshot) {
                        return DefaultButton(
                          text: "Continue",
                          press: () {
                            print('AllPin: $pin1 $pin2 $pin3 $pin4 $pin5 $pin6');
                            finalPin = pin1 + pin2 + pin3 + pin4 + pin5 + pin6;
                            PhoneAuthCredential phoneAuthCredential =
                            PhoneAuthProvider.credential(
                                verificationId: verificationArguments.verificationId,
                                smsCode: finalPin);
                            authBloc.signInWithPhoneAuthCredential(phoneAuthCredential);
                            fetch(verificationArguments.phone);
                          },
                        );
                      });
                }
              }),

        ],
      ),
    );
  }

  fetch(String phone) {
    var authBloc = Provider.of<AuthBloc>(context, listen: false);
    loginStateSubscription = authBloc.currentUser.listen((phoneUser) {
      if (phoneUser != null) {
        fcmToken().then((token) =>
            phoneLoginBloc..login(PhoneLoginBody(fcm: token, phone: phone)));
        print("User phone:::"+phoneUser.phoneNumber!);
      }else{
        print("User null:::");
      }
    });
  }
}
