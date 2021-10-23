import 'package:ecommerce_customer_app/screen/cart/cart_screen.dart';
import 'package:ecommerce_customer_app/screen/categories/AllCategoriesScreen.dart';
import 'package:ecommerce_customer_app/screen/complete_profile/complete_profile_screen.dart';
import 'package:ecommerce_customer_app/screen/details/details_screen.dart';
import 'package:ecommerce_customer_app/screen/forgot_password/forgot_password_screen.dart';
import 'package:ecommerce_customer_app/screen/home/HomeScreen.dart';
import 'package:ecommerce_customer_app/screen/intro/IntroScreen.dart';
import 'package:ecommerce_customer_app/screen/login_success/login_success_screen.dart';
import 'package:ecommerce_customer_app/screen/notification/NotificationScreen.dart';
import 'package:ecommerce_customer_app/screen/otp/otp_screen.dart';
import 'package:ecommerce_customer_app/screen/phone_sign_in/phone_sign_in_screen.dart';
import 'package:ecommerce_customer_app/screen/productviewbyid/ProductViewByIdScreen.dart';
import 'package:ecommerce_customer_app/screen/profile/profile_screen.dart';
import 'package:ecommerce_customer_app/screen/search/SearchScreen.dart';
import 'package:ecommerce_customer_app/screen/sign_in/sign_in_screen.dart';
import 'package:ecommerce_customer_app/screen/sign_up/sign_up_screen.dart';
import 'package:ecommerce_customer_app/screen/signup_success/SignUpSuccessScreen.dart';
import 'package:ecommerce_customer_app/screen/sipping_address/ShippingAddress.dart';
import 'package:ecommerce_customer_app/screen/splash/SplashScreen.dart';
import 'package:flutter/widgets.dart';


// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  MySplashScreen.routeName: (context) => MySplashScreen(),
  IntroScreen.routeName: (context) => IntroScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  DetailsScreen.routeName: (context) => DetailsScreen(),
  SearchScreen.routeName: (context) => SearchScreen(),
  NotificationScreen.routeName: (context) => NotificationScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  OtpScreen.routeName: (context) => OtpScreen(),
  SignUpSuccessScreen.routeName: (context) => SignUpSuccessScreen(),
  PhoneSignInScreen.routeName: (context) => PhoneSignInScreen(),
  AllCategoriesScreen.routeName: (context) => AllCategoriesScreen(),
  ProductViewByIdScreen.routeName: (context) => ProductViewByIdScreen(),
  CartScreen.routeName: (context) => CartScreen(),
  ShippingAddressScreen.routeName: (context) => ShippingAddressScreen(),

};
