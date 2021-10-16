import 'package:ecommerce_customer_app/components/LoadingWidget.dart';
import 'package:ecommerce_customer_app/components/custom_surfix_icon.dart';
import 'package:ecommerce_customer_app/components/form_error.dart';
import 'package:ecommerce_customer_app/model/args/VeridicationArguments.dart';

import 'package:ecommerce_customer_app/screen/otp/otp_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class PhoneSignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<PhoneSignForm> {
  final _formKey = GlobalKey<FormState>();
  String phone='';
  String verificationId='';
  final List<String> errors = [];
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading=false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  //  _auth.setSettings(appVerificationDisabledForTesting: true);
  }

  void addError({required String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({required String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
        padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child:Form(
      key: _formKey,
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
            "Sign in with your phone",
            textAlign: TextAlign.center,
          ),
          SizedBox(height: SizeConfig.screenHeight! * 0.08),
          buildPhoneFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          isLoading?LoadingWidget.buildLoadingWidget():DefaultButton(
          text: "Continue",
          press: () async {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              setState(() {
                isLoading=true;
              });
              await _auth.verifyPhoneNumber(
                phoneNumber: "+880"+phone,
                verificationCompleted: (phoneAuthCredential) async {
                  //signInWithPhoneAuthCredential(phoneAuthCredential);
                  setState(() {
                    isLoading=false;
                  });
                },
                verificationFailed: (verificationFailed) async {
                  setState(() {
                    isLoading=false;
                  });
                  Fluttertoast.showToast(
                      msg: verificationFailed.message.toString(),
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM);
                  print(verificationFailed.message);
                },
                codeSent: (verificationId, resendingToken) async {
                   this.verificationId=verificationId;
                   setState(() {
                     isLoading=false;
                   });
                   Navigator.pushNamed(context, OtpScreen.routeName,arguments: VerificationArguments(verificationId: verificationId, phone: "+880"+phone));
                },
                codeAutoRetrievalTimeout: (verificationId) async {},
              );
            }
          },
        )
        ],
      ),
    )
    );
  }






  TextFormField buildPhoneFormField() {
    return TextFormField(
      autofocus: true,
      keyboardType: TextInputType.phone,
      maxLength: 10,
      onSaved: (newValue) => phone = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNullError);
        } else if (value.length<10) {
          removeError(error: kPhoneNullError);
        }
        return null;
      },

      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPhoneNullError);
          return "";
        } else if (value.length<10) {
          addError(error: kPhoneNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Phone",
        hintText: "10 Digit",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
        prefixText: "+880",

        prefixStyle: TextStyle(color: Colors.black,fontSize: 17),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            color: Stroke,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            color: kPrimaryColor,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            color: kPrimaryColor,
          ),
        ),
      ),
    );
  }
}
