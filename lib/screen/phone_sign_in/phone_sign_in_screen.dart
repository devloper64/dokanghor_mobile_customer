import 'package:flutter/material.dart';

import 'components/phone_sign_form.dart';


class PhoneSignInScreen extends StatelessWidget {
  static String routeName = "/phone_sign_in";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PhoneSignForm(),
    );
  }
}
