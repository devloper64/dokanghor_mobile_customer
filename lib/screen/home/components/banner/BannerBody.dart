import 'dart:async';

import 'package:ecommerce_customer_app/components/Intro_button.dart';
import 'package:ecommerce_customer_app/components/LoadingWidget.dart';

import 'package:ecommerce_customer_app/screen/home/components/banner/discount_banner.dart';
import 'package:ecommerce_customer_app/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../constants.dart';

class BannerBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BannerBodyState();
  }
}

class _BannerBodyState extends State<BannerBody> {
  int currentPage = 0;
  PageController _pageController = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (currentPage < 3) {
        currentPage++;
      } else {
        currentPage = 0;
      }

      if (_pageController.hasClients){
        _pageController.animateToPage(
          currentPage,
          duration: Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildBanner();
  }

  Widget _buildBanner() {
    List<Map<String, dynamic>> bannerList = [
      {
        "image": "",
        "tittle": "A Summer Surprise",
        "highLightTittle": "CashBack 20%"
      },
      {
        "image": "assets/images/Image Banner 2.png",
        "tittle": "A Summer Surprise",
        "highLightTittle": "CashBack 40%"
      },
      {
        "image": "assets/images/Image Banner 3.png",
        "tittle": "A Summer Surprise",
        "highLightTittle": "CashBack 50%"
      },
    ];
    return SafeArea(
        child: SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(180),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (value) {
                setState(() {
                  currentPage = value;
                });
              },
              itemCount: bannerList.length,
              itemBuilder: (BuildContext context, int index) => DiscountBanner(
                highLightTittle: bannerList[index]["highLightTittle"],
                image: bannerList[index]["image"],
                tittle: bannerList[index]["tittle"],
                press: () { print("Banner click"+index.toString()); },
              ),
            ),
          ),
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                    bannerList.length, (index) => buildDot(index: index)),
              ),
            ],
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
