import 'package:flutter/material.dart';

import '../constants.dart';

class LoadingWidget{

  static Widget buildLoadingWidget() {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 45.0,
              width: 45.0,
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(kPrimaryColor),
                strokeWidth: 4.0,
              ),
            )
          ],
        ));
  }
}