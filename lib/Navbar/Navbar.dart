import 'package:flutter/material.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
      child: Container(
        child: Column(
          children: [

            SizedBox(height: 20.0,),

            Text('InstaDoor',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.white, fontSize: 30),
            ),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Home',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(width: 10,),
                  Text(
                    'About Us',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(width: 10,),
                  Text(
                    'Portfolio',
                    style: TextStyle(color: Colors.white),
                  ),


                ],
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
            Text('Instadoor',
              style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 30),
            ),

            Row(
              children: [
                Text(
                  'Home',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(width: 10,),
                Text(
                  'About Us',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(width: 10,),
                Text(
                  'Portfolio',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(width: 10,),

                MaterialButton(
                  color: Colors.pink,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  onPressed: (){},
                  child: Text(
                    'Get Started',
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




