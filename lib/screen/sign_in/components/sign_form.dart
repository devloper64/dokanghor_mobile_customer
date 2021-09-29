import 'package:ecommerce_customer_app/bloc/LoginBloc.dart';
import 'package:ecommerce_customer_app/components/LoadingWidget.dart';
import 'package:ecommerce_customer_app/components/custom_surfix_icon.dart';
import 'package:ecommerce_customer_app/components/form_error.dart';
import 'package:ecommerce_customer_app/helper/StreamListenableBuilder.dart';
import 'package:ecommerce_customer_app/helper/keyboard.dart';
import 'package:ecommerce_customer_app/model/body/login/LoginBody.dart';
import 'package:ecommerce_customer_app/model/response/login/LoginResponse.dart';
import 'package:ecommerce_customer_app/screen/forgot_password/forgot_password_screen.dart';
import 'package:ecommerce_customer_app/screen/login_success/login_success_screen.dart';
import 'package:ecommerce_customer_app/screen/signup_success/SignUpSuccessScreen.dart';
import 'package:flutter/material.dart';


import '../../../SharedPrefsHelper.dart';
import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String email='';
  String password='';
  bool remember = false;
  final List<String> errors = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginBloc..drain();
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
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: kPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    remember = value!;
                  });
                },
              ),
              Text("Remember me"),
              Spacer(),
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, ForgotPasswordScreen.routeName),
                child: Text(
                  "Forgot Password",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          StreamBuilder<bool>(
              stream: loginBloc.isLoading.stream,
              builder: (context, AsyncSnapshot<bool> snapshot1) {
                if (snapshot1.data == true) {
                  return LoadingWidget.buildLoadingWidget();
                } else {
                  return fetchLogin();
                }
              }),
        ],
      ),
    );
  }

  Widget fetchLogin() {
    return StreamListenableBuilder(
        stream: loginBloc.subject.stream,
        listener: (LoginResponse value) {
          if(value.id_token.isNotEmpty){
            print("User Token :"+value.id_token);
            Navigator.pushNamed(context, LoginSuccessScreen.routeName);
            SharedPrefsHelper.storeUserToken(value.id_token);
          }
        },
        builder: (BuildContext context, AsyncSnapshot<LoginResponse> snapshot) {
          return submitButton();
        });
  }

  Widget submitButton() {

    return  DefaultButton(
      text: "Continue",
      press: () {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
            loginBloc..login(LoginBody(password: password,rememberMe: remember,username: email));
        }
      },
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
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

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,

      onSaved: (newValue) => email = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },

      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
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
