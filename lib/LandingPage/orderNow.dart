import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_test/Helper/CommonWidgets.dart';
import 'package:flutter_web_test/Helper/Constant.dart';


class OrderNow extends StatelessWidget {



  List<Widget> pageChildren(double width, BuildContext context){
    return <Widget>[
      // Welcome Text And Over View Button
      Container(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('ORDER NOW!',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40.0,
                  color: AppColor.themeColor
              ),),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0,),
              child: setCommonText('Instadoor is an online supermarket, new in your town. \nWe assure you instant and quickest deliveries of your needs.\n'
                  'Just order it, we’ll deliver it instantly. Try Now!',
                    AppColor.black, 16.0,
                    FontWeight.w900, 5),
              ),

          ],
        ),
      ),

      //Main Image
      Container(
        height: MediaQuery.of(context).size.height / 2,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("Assets/images/bgImage.png"),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Image.asset(
            'Assets/images/lp_image.png',
            width: width,
          ),
        ),
      ),

    ];
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: LayoutBuilder(
        builder: (context, constraints) {
          //Making Layout Responsive
          if (constraints.maxWidth > 800) {
            //For Desktops Screens
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  pageChildren(constraints.biggest.width/2 - 40, context),
                  ),
                ),
              ],
            );
          }  else {
            //For Mobile Phone Screens
            return Column(
              children: [

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40),
                  child: Column(
                    children: pageChildren(constraints.biggest.width, context),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

}

