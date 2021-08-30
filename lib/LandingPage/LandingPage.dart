import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_test/Helper/CommonWidgets.dart';
import 'package:flutter_web_test/Helper/Constant.dart';
import 'package:mouse_parallax/mouse_parallax.dart';


class LandingPage extends StatefulWidget {


  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  
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

  double topOne = 0;
  double topTwo = 100;

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
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
                        image: AssetImage("Assets/nrd.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  pageChildren(constraints.biggest.width/2 -40, context),
                    ),
                  ),
                ),


                Text('We have taken each and every project handed over to us as a challenge, which has helped us achieve a high project success rate.'),


                Container(
                    height:200,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("Assets/background3.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Image.asset('Assets/images/lp_image.png')
                ),

              ],
            );
          }  else {
            //For Mobile Phone Screens
            return Column(
              children: [

                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("Assets/background1.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40),
                    child: Column(
                      children: pageChildren(constraints.biggest.width, context),
                    ),
                  ),
                ),

                Text('We have taken each and every project handed over to us as a challenge, which has helped us achieve a high project success rate.'),


                Container(
                    height:200,
                    width: MediaQuery.of(context).size.width,
                    //color:AppColor.themeColor,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("Assets/background3.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Image.asset('Assets/images/lp_image.png')
                ),


              ],
            );
          }
        },
      ),
    );
  }
}

/*class TriangleClipper extends CustomPainter  {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path();


    // Path number 1
    paint.color = Color(0xffFFFFFF);
    path = Path();
    path.lineTo(0, 0);
    path.cubicTo(0, 0, size.width * 0.13, 0, size.width * 0.13, 0);
    path.cubicTo(size.width * 0.13, 0, size.width * 0.13, size.height / 5, size.width * 0.13, size.height / 5);
    path.cubicTo(size.width * 0.13, size.height / 5, 0, size.height / 5, 0, size.height / 5);
    path.cubicTo(0, size.height / 5, 0, 0, 0, 0);
    canvas.drawPath(path, paint);


    // Path number 2
    paint.color = Color(0xff7445d1);
    path = Path();
    path.lineTo(0, 0);
    path.cubicTo(0, 0, 0, size.height, 0, size.height);
    path.cubicTo(0, size.height, size.width, size.height * 0.41, size.width, size.height * 0.41);
    path.cubicTo(size.width, size.height * 0.41, size.width, size.height * 0.04, size.width, size.height * 0.04);
    path.cubicTo(size.width, size.height * 0.04, size.width, 0, size.width, 0);
    path.cubicTo(size.width, 0, 0, 0, 0, 0);
    path.cubicTo(0, 0, 0, 0, 0, 0);
    canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}*/

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
      left: -45,
      top: top,
      child: Container(
        height: 550,
        width: 900,
        child: Image.asset("assets/$asset.png", fit: BoxFit.cover),
      ),
    );
  }
}
