import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_test/Helper/DatabaseHelper.dart';
import 'Constant.dart';
import 'SharedManaged.dart';
import './../generated/i18n.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

class EmptyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  Size get preferredSize => Size(0.0, 0.0);
}

//In the cart section if no data found for the check out this common widget will show.
dataFound(BuildContext context, String text, AssetImage image, String type) {
  return new Container(
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    color: Colors.white,
    child: new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Container(
          height: (type == "0") ? 200 : 100,
          width: (type == "0") ? 200 : 100,
          decoration: BoxDecoration(
              image: DecorationImage(image: image, fit: BoxFit.cover)),
        ),
        SizedBox(
          height: 15,
        ),
        new Container(
            padding: new EdgeInsets.only(left: 15, right: 15),
            child: new Text(
              text,
              style: new TextStyle(
                  color: Colors.orange,
                  fontSize: 16.0,
                  fontFamily: SharedManager.shared.fontFamilyName),
              textAlign: TextAlign.center,
            )),
        SizedBox(height: 15),
        new Container(
          height: 40,
          width: 130,
          child: new GestureDetector(
            onTap: () {

            },
            child: new Material(
              elevation: 2.0,
              borderRadius: BorderRadius.circular(20),
              color: AppColor.themeColor,
              child: new Center(
                child: setCommonText(S.current.start_exploring, Colors.white,
                    14.0, FontWeight.w600, 1),
              ),
            ),
          ),
        )
      ],
    ),
  );
}


//This is the common function which works whole application, which set Text with different font and color.
setCommonText(String title, dynamic color, dynamic fontSize, dynamic fontweight,
    dynamic noOfLine) {
  return new AutoSizeText(
    title,
    textDirection: SharedManager.shared.direction,
    style: new TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontweight,
      fontFamily: SharedManager.shared.fontFamilyName,
    ),
    maxLines: noOfLine,
    overflow: TextOverflow.ellipsis,
    wrapWords: true,
  );
}

showSnackbar(String value) {
  SharedManager.shared.scaffoldKey.currentState.showSnackBar(new SnackBar(
      duration: Duration(seconds: 15),
      content: new Row(
        children: <Widget>[
          SizedBox(
            child: CircularProgressIndicator(),
            height: 25.0,
            width: 25.0,
          ),
          SizedBox(width: 15),
          new Expanded(
              child: setCommonText(
                  value, AppColor.white, 17.0, FontWeight.w500, 2))
        ],
      )));
}

void showInSnackBarWithKey(String value, GlobalKey<ScaffoldState> key) {
  key.currentState.showSnackBar(new SnackBar(
      content: Row(
      children: [
        Container(
          height: 20,
          width: 20,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
        SizedBox(width: 15),
        Text(value)
      ],
  )));
}

//If application works with login or registrations set this widget.
setLockedAccessWidgets(BuildContext context, bool isFromCart) {
  (isFromCart)
      ? SharedManager.shared.isFromCart = true
      : SharedManager.shared.isFromCart = false;
  return Material(
    type: MaterialType.transparency,
    child: new Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: new Column(
        children: <Widget>[
          SizedBox(height: 150),
          new Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('Assets/images/lockedAccess.png'),
                    fit: BoxFit.cover)),
          ),
          SizedBox(height: 10),
          new Padding(
            padding: new EdgeInsets.only(left: 35, right: 35),
            child: new Text(
              S.current.must_be_login,
              style: new TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                  fontFamily: SharedManager.shared.fontFamilyName,
                  fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 35),
          new GestureDetector(
            onTap: () {
              print('Add On Tap ');
            },
            child: new Container(
              height: 46,
              width: 160,
              decoration: BoxDecoration(
                  color: AppColor.themeColor,
                  borderRadius: BorderRadius.circular(23)),
              child: new Center(
                child: setCommonText(
                    S.current.login, Colors.white, 18.0, FontWeight.w400, 1),
              ),
            ),
          ),
          SizedBox(height: 25),
          new Padding(
            padding: new EdgeInsets.only(left: 20, right: 20),
            child: new GestureDetector(
              onTap: () {
                print('Add On Tap ');
              },
              child: new Center(
                child: setCommonText(S.current.dont_have_account, Colors.grey,
                    17.0, FontWeight.w600, 1),
              ),
            ),
          )
        ],
      ),
    ),
  );
}


//This is the common textfield widgets which use whole app.
setCommonTetField(String title, Icon icon, dynamic controller, bool isSecure,
    TextInputType type) {
  return new Container(
    padding: new EdgeInsets.only(left: 8, right: 8),
    height: 50,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColor.themeColor, width: 2.0)),
    child: new Row(
      children: <Widget>[
        icon,
        SizedBox(
          width: 5,
        ),
        new Expanded(
          child: new TextFormField(
            controller: controller,
            decoration: new InputDecoration(
                hintText: title,
                hintStyle: new TextStyle(color: AppColor.white),
                border: InputBorder.none),
            style: new TextStyle(
                color: AppColor.white,
                fontFamily: SharedManager.shared.fontFamilyName,
                fontSize: 18),
            obscureText: isSecure,
            keyboardType: type,
          ),
        )
      ],
    ),
  );
}


setItemDiscountWidget(BuildContext context, String title) {
  return InkWell(
    child: Container(
        padding: EdgeInsets.only(left: 3, top: 3),
        decoration: BoxDecoration(
            color: AppColor.black38.withOpacity(0.1),
            borderRadius: BorderRadius.circular(5)),
        child: Align(
          alignment: Alignment.topLeft,
          child: Container(
            height: 25,
            width: 80,
            decoration: BoxDecoration(
                color: AppColor.red.withOpacity(0.8),
                borderRadius: BorderRadius.circular(5)),
            child: Center(
                child: setCommonText(
                    "-$title", AppColor.white, 12.0, FontWeight.bold, 1)),
          ),
        )),
  );
}

String calculateDiscount(
    String price, String discountValue, String discountType) {
  if (discountType == "0") {
    //Flat
    var endPrice = '';
    double priceValue = double.parse(price);
    double discount = double.parse(discountValue);

    endPrice = (priceValue - discount).toString();
    print('End Price:------->$endPrice');
    return endPrice;
  } else {
    // //%
    // 100 na 20%

    //   100*20/100

    //   100 - ((100*2)/100)

    var endPrice = (double.parse(price) -
            ((double.parse(price) * double.parse(discountValue)) / 100))
        .toString();

    print('End Price Percentage:------->$discountType');

    return endPrice;
  }
}

String getDiscountPrice(
    String price, String discountValue, String discountType) {
  if (discountType == "0") {
    //Flat
    return discountValue;
  } else {
    // //%
    // 100 na 20%

    //   100*20/100

    //   100 - ((100*2)/100)

    var endPrice =
        ((double.parse(price) * double.parse(discountValue)) / 100).toString();

    print('End Price Percentage:------->$discountType');

    return endPrice;
  }
}

String getPriceAfterDiscount(
    String price, String discountValue, String discountType) {
      var result = 0.00;
  if (discountType == "0") {
    //Flat
    result = double.parse(price) - double.parse(discountValue);
    return result.toStringAsFixed(2);
  } else {
    // //%
    // 100 na 20%

    //   100*20/100

    //   100 - ((100*2)/100)

    var endPrice =
        ((double.parse(price) * double.parse(discountValue)) / 100).toString();

    print('End Price Percentage:------->$discountType');
    result = (double.parse(price) - double.parse(endPrice));
    
    return result.toStringAsFixed(2);
  }
}



DatabaseHelper db = new DatabaseHelper();

setRunningBalanceWidget(BuildContext context, Color bgColor) {
  return Stack(
    children: <Widget>[
      FutureBuilder(
        future: db.getCartTotalAmount(),
        builder: (BuildContext _context, AsyncSnapshot<double> text)
        {
          if(text.data == 0)
          {
            return Text('');
          }else{
            return Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Center(
                child: InkWell(
                  onTap: () async {
                    print('Add Cart Screen Here');
                  },
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                          bottomLeft: Radius.circular(5)),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Image.asset('Assets/Icons/icons-basket.png'),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColor.newSubCategoryBarColor,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(5),
                                bottomRight: Radius.circular(5)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: Center(
                                child: (text.data == null)
                                    ? Container(
                                    child: setCommonText('${Currency.curr}' +"0.00",
                                        AppColor.themeColor, 12.0,
                                        FontWeight.w900, 1))
                                    :Container(child: setCommonText('${Currency.curr}' +
                                    text.data.toStringAsFixed(2)??"0.00",
                                    AppColor.themeColor, 12.0, FontWeight.w900, 1),)
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }

         }
      ),
    ],
  );
}

setCartWidget(BuildContext context, Color bgColor) {
  return Stack(
    children: <Widget>[
      new IconButton(
          icon: Icon(Icons.shopping_cart, size: 30), onPressed: () {
        cartShowDialog(context);
      }),
      Positioned(
          top: 3,
          right: 4,
          child: new Container(
            height: 16,
            width: 14,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), color: bgColor),
            child: new Center(
              child: setCommonText('${SharedManager.shared.cartCount}',
                  AppColor.black, 12.0, FontWeight.w900, 1),
            ),
          )
      ),
    ],
  );
}
//OverLay DialogBox
setDialogBoxSuccess(BuildContext context, String description, bool isOrder, String order_ID ) {
  return showGeneralDialog(
    barrierLabel: "Success",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: Duration(milliseconds: 300),
    context: context,
    pageBuilder: (context, anim1, anim2) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: ResponsiveFlutter.of(context).hp(30),
          // child: SizedBox.expand(child: FlutterLogo()),
          child: successfulOverlayDialog(context, description, isOrder, order_ID),
          decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.only(
                  topLeft:  const  Radius.circular(20.0),
                  topRight: const  Radius.circular(20.0))
          ),
        ),
      );
    },
    transitionBuilder: (context, anim1, anim2, child) {
      return SlideTransition(
        position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
        child: child,
      );
    },
  );
}
//For Success
Widget successfulOverlayDialog(BuildContext context, String description, bool isOrder, String order_ID)
{
  return Material(
    type: MaterialType.transparency,
    child: ListView(
      children:<Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 20, left: 20),
          child: Row(
            children: <Widget>[
              Expanded(
                flex:1,
                child: CircleAvatar(
                  backgroundColor: Colors.green,
                  child: new Icon(Icons.check,size: 20,),
                  foregroundColor: Colors.white,
                ),
              ),

              Expanded(
                flex:9,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: setCommonText('${S.current.congratulation}',
                            AppColor.black, 24.0, FontWeight.bold, 1),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Container(
                          child: setCommonText(description,
                              AppColor.black, 16.0, FontWeight.w500, 2),
                        ),
                      ),

                    ],
                  ),
                ),
              )

            ],
          ),
        ),

        //Track Order
        _successButton(context, isOrder, order_ID),
      ],
    ),
  );
}
//Button Of Success Dialog
 Widget _successButton(BuildContext context, bool isOrder, String order_ID){
  if(isOrder){
    return Padding(
      padding: const EdgeInsets.only(right: 20,top: 30),
      child: Align(
        alignment: Alignment.centerRight,
        child: ButtonTheme(
          minWidth: 50.0,
          height: 40.0,
          child: RaisedButton(
            color: AppColor.themeColor,
            onPressed: () {
              print('001');
            },
            child: setCommonText(S.current.trackOrder, AppColor.white, 14.0, FontWeight.bold, 1),
          ),
        ),
      ),
    );
  }else{
    return Padding(
      padding: const EdgeInsets.only(right: 20,top: 30),
      child: Align(
        alignment: Alignment.centerRight,
        child: ButtonTheme(
          minWidth: 50.0,
          height: 40.0,
          child: RaisedButton(
            color: AppColor.themeColor,
            onPressed: () {
              Navigator.pop(context);
            },
            child: setCommonText(S.current.ok, AppColor.white, 14.0, FontWeight.bold, 1),
          ),
        ),
      ),
    );
  }
 }

setDialogBoxUnSuccess(BuildContext context, String description,) {
  return showGeneralDialog(
    barrierLabel: "UnSuccess",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: Duration(milliseconds: 300),
    context: context,
    pageBuilder: (context, anim1, anim2) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: ResponsiveFlutter.of(context).hp(30),
          // child: SizedBox.expand(child: FlutterLogo()),
          child: wrongPromoCode(context, description),
          decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.only(
                  topLeft:  const  Radius.circular(20.0),
                  topRight: const  Radius.circular(20.0))
          ),
        ),
      );
    },
    transitionBuilder: (context, anim1, anim2, child) {
      return SlideTransition(
        position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
        child: child,
      );
    },
  );
}

  Widget wrongPromoCode(BuildContext context, String description)
  {
    return Material(
      type: MaterialType.transparency,
      child: ListView(
        children:<Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex:1,
                  child: CircleAvatar(
                    backgroundColor: AppColor.themeColor,
                    child: new Icon(Icons.close,size: 20,),
                    foregroundColor: Colors.white,
                  ),
                ),

                Expanded(
                    flex: 9,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(

                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: setCommonText('${S.current.oops}',
                                AppColor.black, 24.0, FontWeight.bold, 1),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Container(
                              /*child: setCommonText(description,
                                  AppColor.black, 16.0, FontWeight.w500, 2),*/
                              child: RichText(text: TextSpan(children: [
                                TextSpan(text: description, style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black,fontSize: 14)),
                              ],)),
                            ),
                          ),

                        ],
                      ),
                    )
                )

              ],
            ),
          ),

          //Select location Button
          Padding(
            padding: const EdgeInsets.only(right: 20,top: 30),
            child: Align(
              alignment: Alignment.center,
              child: ButtonTheme(
                minWidth: 50.0,
                height: 40.0,
                child: RaisedButton(
                  color: AppColor.themeColor,
                  onPressed: () {Navigator.pop(context);},
                  child: setCommonText(S.current.cancel, AppColor.white, 14.0, FontWeight.bold, 1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _fromTop = false;
  //Cart OverLay Dialog
  cartShowDialog(BuildContext context) async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showGeneralDialog(
        barrierLabel: "Cart",
        barrierDismissible: true,
        barrierColor: Colors.white.withOpacity(0.5),
        transitionDuration: Duration(milliseconds: 300),
        context: context,
        pageBuilder: (context, anim1, anim2) {
          return Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                margin: EdgeInsets.only(top: 70),
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.only(
                        topLeft:  const  Radius.circular(20.0),
                        topRight: const  Radius.circular(20.0))
                ),
                child: (SharedManager.shared.isLoggedIN == 'yes')
                    ? Text('Hello002')
                    : setLockedAccessWidgets(context, true),
              ),
              Positioned(
                  top: 40,
                  child: Material(
                    type: MaterialType.transparency,
                    child: InkWell(
                      onTap: (){Navigator.pop(context);},
                      child: CircleAvatar(
                        backgroundColor: AppColor.red,
                        radius: 15,
                        child: Icon(Icons.close, color: AppColor.white, size: 20,),
                      ),
                    ),
                  )
              ),
            ],
          );
        },
        transitionBuilder: (context, anim1, anim2, child) {
          return SlideTransition(
            position: Tween(begin: Offset(0, _fromTop ? -1 : 1), end: Offset(0, 0)).animate(anim1),
            child: child,
          );
        },
      );
    });
  }

  //Common Overlay
logOutOverLay(BuildContext context, String title, String description, dynamic icon_name, String btn_name ){
  return showGeneralDialog(
    barrierLabel: title,
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: Duration(milliseconds: 300),
    context: context,
    pageBuilder: (context, anim1, anim2) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: ResponsiveFlutter.of(context).hp(30),
          //child: wrongPromoCode(context, description),
          child: logoutOverLay(context, title, description, icon_name, btn_name),
          decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.only(
                  topLeft:  const  Radius.circular(20.0),
                  topRight: const  Radius.circular(20.0))
          ),
        ),
      );
    },
    transitionBuilder: (context, anim1, anim2, child) {
      return SlideTransition(
        position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
        child: child,
      );
    },
  );
}

Widget logoutOverLay(BuildContext context, String title, String description, dynamic icon_name, String btn_name)
{
  if(btn_name == "Profile")
  {
    return Material(
      type: MaterialType.transparency,
      child: ListView(
        children:<Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex:1,
                  child: CircleAvatar(
                    backgroundColor: AppColor.themeColor,
                    child: new Icon(icon_name,size: 20,),
                    foregroundColor: Colors.white,
                  ),
                ),

                Expanded(
                    flex: 9,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, top: 10),
                      child: Column(

                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: setCommonText('$title',
                                AppColor.black, 24.0, FontWeight.bold, 1),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20, top: 10),
                            child: Container(
                              child: setCommonText(description,
                                  AppColor.black, 16.0, FontWeight.w500, 2),
                            ),
                          ),

                        ],
                      ),
                    )
                )

              ],
            ),
          ),

          //Select location Button
          _CustomLogoutButton(context, btn_name),
        ],
      ),
    );
  }else if(btn_name == "Address")
    {
      return Material(
        type: MaterialType.transparency,
        child: ListView(
          children:<Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20, bottom: 10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex:1,
                    child: CircleAvatar(
                      backgroundColor: AppColor.themeColor,
                      child: new Icon(icon_name,size: 20,),
                      foregroundColor: Colors.white,
                    ),
                  ),

                  Expanded(
                      flex: 9,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, top: 10),
                        child: Column(

                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: setCommonText('$title',
                                  AppColor.black, 24.0, FontWeight.bold, 1),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 20, top: 10),
                              child: Container(
                                child: setCommonText(description,
                                    AppColor.black, 16.0, FontWeight.w500, 2),
                              ),
                            ),

                          ],
                        ),
                      )
                  )

                ],
              ),
            ),

            //Select location Button
            _CustonAddressButton(context, btn_name),
          ],
        ),
      );
    }
    else if(btn_name == '${S.current.login}')
    {
      return Material(
        type: MaterialType.transparency,
        child: ListView(
          children:<Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex:1,
                    child: CircleAvatar(
                      backgroundColor: AppColor.themeColor,
                      child: new Icon(icon_name,size: 20,),
                      foregroundColor: Colors.white,
                    ),
                  ),

                  Expanded(
                      flex: 9,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, top: 10),
                        child: Column(

                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: setCommonText('$title',
                                  AppColor.black, 24.0, FontWeight.bold, 1),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 20, top: 10),
                              child: Container(
                                child: setCommonText(description,
                                    AppColor.black, 16.0, FontWeight.w500, 2),
                              ),
                            ),

                          ],
                        ),
                      )
                  )

                ],
              ),
            ),
            //Select location Button
            _customLoginButton(context, btn_name),
          ],
        ),
      );
    }
      else
      {
        return Material(
          type: MaterialType.transparency,
          child: ListView(
            children:<Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex:1,
                      child: CircleAvatar(
                        backgroundColor: AppColor.themeColor,
                        child: new Icon(icon_name,size: 20,),
                        foregroundColor: Colors.white,
                      ),
                    ),

                    Expanded(
                        flex: 9,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, top: 10),
                          child: Column(

                            crossAxisAlignment: CrossAxisAlignment.start,
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: setCommonText('$title',
                                    AppColor.black, 24.0, FontWeight.bold, 1),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 20, top: 10),
                                child: Container(
                                  child: setCommonText(description,
                                      AppColor.black, 16.0, FontWeight.w500, 2),
                                ),
                              ),

                            ],
                          ),
                        )
                    )

                  ],
                ),
              ),


            ],
          ),
        );
      }
}

_CustomLogoutButton(BuildContext context, String btn_name){
  print(btn_name);
    return Padding(
      padding: const EdgeInsets.only(right: 20,top: 30),
      child: Align(
        alignment: Alignment.center,
        child: ButtonTheme(
          minWidth: 50.0,
          height: 40.0,
          child: RaisedButton(
            color: AppColor.themeColor,
            onPressed: () async {
             print('003');
            },
            child: setCommonText(S.current.log_out, AppColor.white, 14.0, FontWeight.bold, 1),
          ),
        ),
      ),
    );

}

_customLoginButton(BuildContext context, String btn_name){
  print(btn_name);
    return Padding(
      padding: const EdgeInsets.only(right: 20,top: 30),
      child: Align(
        alignment: Alignment.center,
        child: ButtonTheme(
          minWidth: 50.0,
          height: 40.0,
          child: RaisedButton(
            color: AppColor.themeColor,
            onPressed: () async {
              print('004');
            },
            child: setCommonText(S.current.login, AppColor.white, 14.0, FontWeight.bold, 1),
          ),
        ),
      ),
    );

}

_CustonAddressButton(BuildContext context, String btn_name){
  print(btn_name);
  return Padding(
    padding: const EdgeInsets.only(right: 20,top: 30),
    child: Align(
      alignment: Alignment.center,
      child: ButtonTheme(
        minWidth: 50.0,
        height: 40.0,
        child: RaisedButton(
          color: AppColor.themeColor,
          onPressed: () async {
            print('005');
          },
          child: setCommonText('Address', AppColor.white, 14.0, FontWeight.bold, 1),
        ),
      ),
    ),
  );

}



 //Common Overlay
  commonErrorOverlay(BuildContext context, String title, String description, dynamic icon_name, String btn_name, int btn_route ){
    return showGeneralDialog(
      barrierLabel: title,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 300),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 250,
            //child: wrongPromoCode(context, description),
            child: commonOverlyWidget(context, title, description, icon_name, btn_name, btn_route),
            decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.only(
                    topLeft:  const  Radius.circular(20.0),
                    topRight: const  Radius.circular(20.0))
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
          child: child,
        );
      },
    );
  }

  //Over Dialog Box
  commonOverlyWidget(context, title, description, icon_name, btn_name, btn_route){
    return Material(
      type: MaterialType.transparency,
      child: ListView(
        children:<Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex:1,
                  child: CircleAvatar(
                    backgroundColor: AppColor.red,
                    child: new Icon(icon_name,size: 20,),
                    foregroundColor: Colors.white,
                  ),
                ),

                Expanded(
                    flex: 9,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, top: 10),
                      child: Column(

                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: setCommonText('$title',
                                AppColor.black, 24.0, FontWeight.bold, 1),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20, top: 10),
                            child: Container(
                              child: setCommonText(description,
                                  AppColor.black, 16.0, FontWeight.w500, 2),
                            ),
                          ),

                        ],
                      ),
                    )
                )

              ],
            ),
          ),

          //Close Button
          Padding(
            padding: const EdgeInsets.only(right: 20,top: 30),
            child: Align(
              alignment: Alignment.center,
              child: ButtonTheme(
                minWidth: 50.0,
                height: 40.0,
                child: RaisedButton(
                  color: AppColor.themeColor,
                  onPressed: () async {
                    //For Close Dialog
                    if(btn_route == 0){
                      Navigator.pop(context);
                    }else if(btn_route == 1){
                      print('006');
                    }else if(btn_route == 2){
                      print('007');
                    }
                  },
                  child: setCommonText('Close', AppColor.white, 14.0, FontWeight.bold, 1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


