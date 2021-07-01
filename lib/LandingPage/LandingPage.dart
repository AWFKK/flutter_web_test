import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_test/Screens/Products.dart';


class LandingPage extends StatelessWidget {


  List<Widget> pageChildren(double width, BuildContext context){
    return <Widget>[
      Container(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Website \nDeveloper',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40.0,
                color: Colors.white
              ),),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                "We have taken each and every project handed over to us as a challenge, which has helped us achieve a high project success rate.",
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
            ),

            MaterialButton(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              onPressed: ()
              {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Products()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
                child: Text(
                  'Our Products',
                  style: TextStyle(
                    color: Colors.red, fontWeight: FontWeight.bold
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Image.asset(
          'Assets/images/lp_image.png',
          width: width,
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
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  pageChildren(constraints.biggest.width/2, context),
            );
          }  else {
            //For Mobile Phone Screens
            return Column(
              children: pageChildren(constraints.biggest.width, context),
            );
          }
        },
      ),
    );
  }
}
