import 'package:flutter/material.dart';
import 'package:flutter_web_test/Helper/Constant.dart';


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color:AppColor.themeColor,
    );
  }

}

