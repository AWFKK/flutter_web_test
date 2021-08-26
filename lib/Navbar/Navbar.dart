import 'package:flutter/material.dart';
import 'package:flutter_web_test/Helper/CommonWidgets.dart';
import 'package:flutter_web_test/Helper/Constant.dart';
import 'package:flutter_web_test/Screens/Products.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context,constraints){
          //Making Layout Responsive
          if(constraints.maxWidth>1200){
            //For Desktops Screens
            return DesktopNavBar();
          }else if(constraints.maxWidth>800 && constraints.maxWidth<1200)
          {
            //For Tablets Screens
            return DesktopNavBar();
          }else{
            //For Mobile Phone Screens
            return MobileNavBar();
          }
        },
    );
  }
}

class MobileNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      child: Container(
        child: Column(
          children: [

            SizedBox(height: 10.0,),

            Text('InstaDoor',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.black, fontSize: 30),
            ),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    setCommonText('Home',
                        AppColor.black, 16.0,
                        FontWeight.w900, 1),

                    SizedBox(width: 10,),
                    setCommonText('About Us',
                        AppColor.black, 16.0,
                        FontWeight.w900, 1),

                    SizedBox(width: 10,),
                    setCommonText('Terms And Conditions',
                        AppColor.black, 16.0,
                        FontWeight.w900, 1),

                    SizedBox(width: 10,),
                    setCommonText('Privacy Policy',
                        AppColor.black, 16.0,
                        FontWeight.w900, 1),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Creating Desktop NavBar
class DesktopNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Container(
        //constraints: BoxConstraints(maxWidth:1200 ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            setCommonText('InstaDoor',
                AppColor.black, 30.0,
                FontWeight.w900, 1),

            Row(
              children: [
                setCommonText('Home',
                    AppColor.black, 16.0,
                    FontWeight.w900, 1),

                SizedBox(width: 10,),
                setCommonText('About Us',
                    AppColor.black, 16.0,
                    FontWeight.w900, 1),

                SizedBox(width: 10,),
                setCommonText('Terms And Conditions',
                    AppColor.black, 16.0,
                    FontWeight.w900, 1),

                SizedBox(width: 10,),
                setCommonText('Privacy Policy',
                    AppColor.black, 16.0,
                    FontWeight.w900, 1),

                SizedBox(width: 30,),

                MaterialButton(
                  color: AppColor.newthemeColorLogo,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40.0))),
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Products()),
                      //MaterialPageRoute(builder: (context) => StripPayment()),
                    );
                  },
                  child: Text(
                    'F&Qs ',
                    style: TextStyle(color: Colors.white),
                  ),
                )

              ],
            ),
          ],
        ),
      ),
    );
  }
}




