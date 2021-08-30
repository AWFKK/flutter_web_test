import 'package:flutter/material.dart';
import 'package:flutter_web_test/LandingPage/ParallexEffectHome.dart';
import 'package:flutter_web_test/LandingPage/orderNow.dart';
import 'package:flutter_web_test/LandingPage/packAndDeliver.dart';
import 'package:flutter_web_test/LandingPage/LandingPage.dart';
import 'package:flutter_web_test/Navbar/Navbar.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue, fontFamily: "Montserrat"
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children:<Widget>[
            Container(
                color: Colors.white,
                child: NavBar()
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              child: ParallexEffectHome(),
            ),
          ],
        ),
      ),
    );
  }
}

class TriangleClipper extends CustomPainter  {
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
}
