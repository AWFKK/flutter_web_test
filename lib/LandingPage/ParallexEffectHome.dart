import 'package:flutter/material.dart';
import 'package:flutter_web_test/Helper/CommonWidgets.dart';
import 'package:flutter_web_test/Helper/Constant.dart';
import 'package:flutter_web_test/LandingPage/packAndDeliver.dart';

import 'orderNow.dart';



class ParallexEffectHome extends StatefulWidget {

  @override
  _ParallexEffectHomeState createState() => _ParallexEffectHomeState();
}

class _ParallexEffectHomeState extends State<ParallexEffectHome> {

  ScrollController _scrollController;

  double _currOffset = 0.0;

  void get _refresh => setState(() {});

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }


  //Widgets
  List<Widget> pageChildren(double width, BuildContext context){
    return <Widget>[
      // Welcome Text And Over View Button
      Container(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('WELCOME TO INSTADOOR!',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40.0,
                  color: AppColor.newthemeColorLogo
              ),),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                "Instadoor is an online supermarket, new in your town. We assure you instant and quickest deliveries of your needs. Just order it, we’ll deliver it instantly. Try Now!",
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
            ),

            Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColor.white,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child:Padding(
                  padding: EdgeInsets.all(10.0),
                  child: setCommonText('OVERVIEWS',
                      AppColor.white, 16.0,
                      FontWeight.w900, 1),
                )
            )
          ],
        ),
      ),

      //Main Image
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Image.asset(
          'Assets/mobile.png',
          width: width,
        ),
      ),

    ];
  }

  double rateZero = 0;
  double rateOne = 0;
  double rateTwo = 0;
  double rateThree = 0;
  double rateFour = 0;
  double rateFive = 0;
  double rateSix = 0;
  double rateSeven = 0;
  double rateEight = 90;

  String asset;
  double top;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: _handleScrollNotification,
        child: Stack(
          children: [
            ParallaxWidget(top: rateOne, asset: "nrd"),

            ListView(
              children: [

                LayoutBuilder(
                  builder: (context, constraints) {
                    //Making Layout Responsive
                    if (constraints.maxWidth > 800) {
                      //For Desktops Screens
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:  pageChildren(constraints.biggest.width/2 -40, context),
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

                //Footer
                Container(
                  color: Color(0xff210002),
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(top: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Parallax In",
                        style: TextStyle(
                            fontSize: 30,
                            fontFamily: "MontSerrat-ExtraLight",
                            letterSpacing: 1.8,
                            color: Color(0xffffaf00)),
                      ),
                      Text(
                        "Flutter",
                        style: TextStyle(
                            fontSize: 51,
                            fontFamily: "MontSerrat-Regular",
                            letterSpacing: 1.8,
                            color: Color(0xffffaf00)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      //Divider
                      SizedBox(
                        width: 190,
                        child: Divider(
                          height: 1,
                          color: Color(0xffffaf00),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Footer",
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: "Montserrat-Extralight",
                          letterSpacing: 1.3,
                          color: Color(0xffffaf00),
                        ),
                      ),
                      Text(
                        "We can Add Footer here",
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: "Montserrat-Regular",
                          letterSpacing: 1.8,
                          color: Color(0xffffaf00),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      )
                    ],
                  ),
                ),

                //Order Now
                Container(
                  color: AppColor.white,
                  child:  OrderNow(),
                ),

                //Delivery
                Container(
                  color: AppColor.white,
                  child:  PackAndDelivered(),
                ),

              ],
            )

          ],
        ),
      ),
    );
  }


  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      // print('>>>>>Scroll ${notification.scrollDelta}');
      _currOffset = notification.metrics.pixels;
    }

    _refresh;
    return false;
  }

}

class ParallaxWidget extends StatelessWidget {
  const ParallaxWidget({
    Key key,
    @required this.top,
    @required this.asset,
  }) : super(key: key);

  final double top;
  final String asset;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Image.asset("assets/$asset.jpg", fit: BoxFit.cover),
      ),
    );
  }




}