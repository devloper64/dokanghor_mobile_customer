import 'package:ecommerce_customer_app/model/args/VeridicationArguments.dart';
import 'package:flutter/material.dart';

import '../../size_config.dart';
import 'components/body.dart';

class OtpScreen extends StatelessWidget {
  static String routeName = "/otp";
  @override
  Widget build(BuildContext context) {
    final VerificationArguments agrs = ModalRoute.of(context)!.settings.arguments as VerificationArguments;
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("OTP Verification"),
      ),
      body: Body(verificationArguments: agrs,),
    );
  }
}
