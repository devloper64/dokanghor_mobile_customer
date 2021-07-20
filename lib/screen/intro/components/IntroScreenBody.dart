import 'package:ecommerce_customer_app/components/Intro_button.dart';
import 'package:ecommerce_customer_app/components/LoadingWidget.dart';

import 'package:ecommerce_customer_app/bloc/IntroListBloc.dart';
import 'package:ecommerce_customer_app/model/reponse/intro/IntroResponse.dart';
import 'package:ecommerce_customer_app/screen/intro/components/IntroScreenContent.dart';
import 'package:ecommerce_customer_app/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class IntroScreenBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _IntroScreenState();
  }
}

class _IntroScreenState extends State<IntroScreenBody> {


  int currentPage = 0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    introsBloc..getIntros();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<IntroResponse>>(
            stream: introsBloc.subject.stream,
            builder: (context, AsyncSnapshot<List<IntroResponse>> snapshot) {
              if (snapshot.hasData) {
                return _buildIntrosWidget(snapshot.data!);
              }else{
                return LoadingWidget.buildLoadingWidget();
              }
            }
        );

  }
  Widget _buildIntrosWidget(List<IntroResponse> data) {
    return SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: PageView.builder(
                  onPageChanged: (value){
                    setState(() {
                      currentPage=value;
                    });
                  },
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) => IntroScreenContent(
                      text:  data[index].text,
                      image: data[index].image
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(36),),
                  child: Column(
                    children: <Widget>[
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(data.length, (index) => buildDot(index: index)),
                      ),
                      Spacer(flex: 3),
                      IntroButton(
                        text: "Continue",
                        routeName:"/home",
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }


  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
