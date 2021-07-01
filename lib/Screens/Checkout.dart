import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_web_test/Helper/CommonWidgets.dart';
import 'package:flutter_web_test/Helper/Constant.dart';
import 'package:flutter_web_test/Helper/SharedManaged.dart';
import 'package:flutter_web_test/ModelClass/ModelCartList.dart';
import 'package:flutter_web_test/ModelClass/card_model.dart';
import 'package:flutter_web_test/generated/i18n.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';


class Checkout extends StatefulWidget {
  final String totalPrice;
  final String discountedPrice;
  final String charge;
  final String totalSaving;
  final String grandTotalAmount;
  final String tipAmount;
  final String deliveryTime;
  final String deliveryDate;
  final List<CartProduct> cartItems;
  final CardResults cardModel;

  const Checkout(
      {Key key,
        this.totalPrice,
        this.discountedPrice,
        this.charge,
        this.totalSaving,
        this.grandTotalAmount,
        this.tipAmount,
        this.deliveryTime,
        this.deliveryDate,
        this.cartItems,
        this.cardModel})
      : super(key: key);



  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {

  var charge = 5.00;

  var totalPayAble;
  double totalPayAbleTemp = 0.0;

  int selectedCardID = 0;

  double getdiscount ;

  String str_promo = 'Promotion';

  @override
  void initState() {
    totalPayAble = (double.parse(this.widget.grandTotalAmount)) - (double.parse(SharedManager.shared.discountPice));
    totalPayAbleTemp= (double.parse(this.widget.grandTotalAmount)) - (double.parse(SharedManager.shared.discountPice));

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    getdiscount = double.parse(SharedManager.shared.discountPice);
    totalPayAbleTemp= (double.parse(this.widget.grandTotalAmount) - getdiscount) + this.charge;
    totalPayAble= '${Currency.curr}${((double.parse(this.widget.grandTotalAmount) - getdiscount) + this.charge).toStringAsFixed(2)}';

    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: LayoutBuilder(
          builder: (context, constraints) {

            if (constraints.maxWidth > 800)
            {
              return Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color.fromRGBO(195, 20, 50, 1.0),
                          Color.fromRGBO(36, 11, 54, 1.0)
                        ]
                    )
                ),
                child: Center(
                  child: Container(
                    child: Text('${this.widget.charge}${this.widget.discountedPrice}${this.widget.totalPrice}${this.widget.tipAmount}${this.widget.cartItems}'),
                  ),
                ),
              );
            }else
            {
              return Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color.fromRGBO(195, 20, 50, 1.0),
                          Color.fromRGBO(36, 11, 54, 1.0)
                        ]
                    )
                ),
                child: Container(
                  color: AppColor.white,
                  child: Stack(
                    children: [

                      SingleChildScrollView(
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /*//Address Bar With Eta
                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: AppColor.newthemeColorLogo,
                                ),
                                child: new Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 7,
                                      child: Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: AppColor.white,
                                          borderRadius: new BorderRadius.only(
                                            topRight: const Radius.circular(50.0),
                                            bottomRight: const Radius.circular(50.0),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                              const EdgeInsets.only(left: 10.0),
                                              child: Image.asset(
                                                _setAddressIcon(),
                                                height: 24.0,
                                                width: 24,
                                              ),
                                            ),
                                            //For Vertical Divider
                                            Container(
                                                height: 30,
                                                child: VerticalDivider(
                                                    color: Colors.grey)),
                                            //Address Type
                                            setCommonText(
                                                _setAddressType(),
                                                AppColor.black,
                                                14.0,
                                                FontWeight.bold,
                                                1),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            //Real Address
                                            Expanded(
                                              flex: 1,
                                              child: setCommonText(
                                                  '${SharedManager.shared.address}',
                                                  AppColor.black87,
                                                  14.0,
                                                  FontWeight.w400,
                                                  1),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),

                                            //Icon
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 3.0, right: 5),
                                              child: Icon(
                                                Icons.arrow_forward_ios,
                                                color: Colors.grey,
                                                size: 15.0,
                                                semanticLabel: 'Delivery Address',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    //Estimated Time
                                    if (_eta.duration != null) Expanded(
                                      flex: 3,
                                      child: Container(
                                        height: 50,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            setCommonText('ETA', AppColor.themeColor,
                                                12.0, FontWeight.bold, 1),
                                            Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  setCommonText(
                                                      (_eta.duration / 60).toStringAsFixed(0) ,
                                                      AppColor.themeColor,
                                                      20.0,
                                                      FontWeight.bold,
                                                      1),
                                                  setCommonText(
                                                      "min" ,
                                                      AppColor.themeColor,
                                                      14.0,
                                                      FontWeight.bold,
                                                      1)
                                                ]
                                            ),
                                          ],
                                        ),
                                      ),
                                    ) else new Text(''),
                                  ],
                                ),
                              ),*/

                              //Card View And List Other Payment Method We have
                              Container(
                                width: width,
                                child: Container(
                                  height: 250,
                                  color: AppColor.themeColor,
                                ),
                              ),

                              SizedBox(
                                height: 10,
                              ),

                              Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: setCommonText(
                                    'Choose another method',
                                    Colors.grey,
                                    14.0,
                                    FontWeight.bold,
                                    1),
                              ),

                              SizedBox(
                                height: 5,
                              ),

                              //Pay With Google or Apple Button
                              Platform.isAndroid
                              //Pay With G Pay
                                  ? (InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedCardID = 989990099989;
                                  });
                                },
                                child: Center(
                                  child: Container(
                                    height: ResponsiveFlutter.of(context).hp(7),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey,
                                          offset: Offset(0.0, 1.0), //(x,y)
                                          blurRadius: 6.0,
                                        ),
                                      ],
                                      color: AppColor.white,
                                    ),
                                    child: Stack(
                                      alignment: Alignment.centerLeft, //Center Row contents vertically,
                                      children: [
                                        Positioned(
                                          left: 20.0,
                                          child: Container(
                                              child: selectedCardID == 989990099989
                                                  ?Icon(
                                                Icons.check_circle,
                                                color: AppColor.black,
                                                size: ResponsiveFlutter.of(context).wp(8),
                                              ):Icon(
                                                Icons.radio_button_unchecked_sharp,
                                                color: Colors.black,
                                                size: ResponsiveFlutter.of(context).wp(8),
                                              )

                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.center,
                                          child: Container(
                                              height: 20,
                                              child: SvgPicture.asset('Assets/g_pay.svg')),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ))
                              //Pay With Apple Pay
                                  : (InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedCardID = 989990099989;
                                  });
                                },
                                child: Center(
                                  child: Container(
                                    height: ResponsiveFlutter.of(context).hp(7),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey,
                                          offset: Offset(0.0, 1.0), //(x,y)
                                          blurRadius: 6.0,
                                        ),
                                      ],
                                      color: AppColor.white,
                                    ),
                                    child: Stack(
                                      alignment: Alignment.centerLeft,
                                      //Center Row contents vertically,
                                      children: [
                                        Positioned(
                                          left: 20.0,
                                          child: Container(
                                              child: selectedCardID == 989990099989
                                                  ? Icon(
                                                Icons.check_circle,
                                                color: AppColor.black,
                                                size: ResponsiveFlutter.of(
                                                    context)
                                                    .wp(8),
                                              )
                                                  : Icon(
                                                Icons
                                                    .radio_button_unchecked_sharp,
                                                color: Colors.black,
                                                size: ResponsiveFlutter.of(
                                                    context)
                                                    .wp(8),
                                              )),
                                        ),
                                        Align(
                                            alignment: Alignment.center,
                                            child: Container(
                                              height: 20,
                                              child: Image.asset('Assets/applepay.png'),)
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )),

                              SizedBox(
                                height: 10,
                              ),


                              Padding(
                                padding: const EdgeInsets.only(left: 20, bottom: 10),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: setCommonText(
                                      'Payment Summary',
                                      Colors.grey,
                                      10.0,
                                      FontWeight.bold,
                                      1),
                                ),
                              ),

                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColor.white),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(0.0, 1.0), //(x,y)
                                      blurRadius: 6.0,
                                    ),
                                  ],
                                ),

                                //Shopping Receipt And Promotions
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: ResponsiveFlutter.of(context).hp(1),
                                    ),

                                    //Promotions Container
                                    InkWell(
                                      onTap:() async {
                                        print('Promotion Here');
                                      },
                                      child: Container(
                                        height: ResponsiveFlutter.of(context).hp(5),
                                        child: Row(
                                          children: [
                                            Expanded( flex :1 ,
                                              child: SharedManager.shared.couponCodeImage == ''
                                                  ?Icon(Icons.card_giftcard, color: AppColor.themeColor,)
                                                  :Container(
                                                height:30,
                                                width: 30,
                                                child: Image.network(SharedManager.shared.couponCodeImage),
                                              ),
                                            ),

                                            Expanded(flex:5,
                                              child: setCommonText(
                                                  '$str_promo',
                                                  Colors.black,
                                                  10.0,
                                                  FontWeight.bold,
                                                  1),
                                            ),

                                            Expanded(
                                              flex:1,
                                              child: Icon(
                                                Icons.arrow_forward_ios,
                                                size: 15,
                                              ),
                                            )

                                          ],
                                        ),
                                      ),
                                    ),

                                    Divider(
                                      color: Colors.grey,
                                    ),

                                    //SubTotal
                                    Container(
                                      height: ResponsiveFlutter.of(context).hp(5),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20),
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                              child: Text(
                                                'Subtotal',
                                                style: TextStyle(
                                                    color: AppColor.black,
                                                    fontSize: 12.0),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: setCommonText(
                                                  '${Currency.curr}${this.widget.totalPrice}',
                                                  AppColor.black,
                                                  12.0,
                                                  FontWeight.bold,
                                                  1),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),

                                    Divider(
                                      color: Colors.grey,
                                    ),


                                    //SHIPPING
                                    Container(
                                      height: ResponsiveFlutter.of(context).hp(5),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20),
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                              child: Text(
                                                'Shipping',
                                                style: TextStyle(
                                                    color: AppColor.black,
                                                    fontSize: 12.0),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: setCommonText(
                                                  '${Currency.curr}${this.charge.toStringAsFixed(2)}',
                                                  AppColor.black,
                                                  12.0,
                                                  FontWeight.bold,
                                                  1),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),

                                    //Divider Show When Promo Applied
                                    getdiscount > 0.0
                                        ?Divider(
                                      color: Colors.grey,
                                    )
                                        :Offstage(offstage: true,),

                                    //Discount you get
                                    getdiscount > 0.0
                                     ? Container(
                                      height: ResponsiveFlutter.of(context).hp(5),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                              child: Text(
                                                'Discount',
                                                style: TextStyle(
                                                    color: AppColor.black,
                                                    fontSize: 12.0),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: setCommonText(
                                                  '-${Currency.curr}${SharedManager.shared.discountPice}',
                                                  AppColor.black,
                                                  12.0,
                                                  FontWeight.bold,
                                                  1),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                        :Offstage(offstage: true,),

                                    /*//Total Payable Amount
                          Container(
                            height: ResponsiveFlutter.of(context).hp(5),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      '${S.current.total}',
                                      style: TextStyle(
                                          color: AppColor.themeColor,
                                          fontSize: 13.0),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: setCommonText(
                                        '${Currency.curr}${(double.parse(this.widget.grandTotalAmount)) - (double.parse(SharedManager.shared.discountPice))}',
                                        AppColor.themeColor,
                                        13.0,
                                        FontWeight.bold,
                                        1),
                                  )
                                ],
                              ),
                            ),
                          ),*/


                                  ],
                                ),
                              ),

                              SizedBox(height: 70,),

                            ],
                          ),
                        ),
                      ),

                      //Payable Button
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: InkWell(
                          onTap: (){
                            print('Click');
                          },
                          child: Container(
                            height: 60,
                            color: AppColor.themeColor,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  setCommonText('Order & Pay',
                                      AppColor.white, 16.0, FontWeight.w500, 1),

                                  Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: Container(
                                      height: 30,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: AppColor.white),
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(Radius.circular(50)),
                                      ),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left: 5),
                                            child: setCommonText('${this.totalPayAble}',
                                                AppColor.black, 12.0, FontWeight.w500, 1),
                                          ),

                                          Icon(Icons.arrow_forward_ios,size: 20,),
                                        ],
                                      ),
                                    ),
                                  )

                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
          }
      ),
    );
  }

  //Set Address Icon
  String _setAddressIcon() {
    if (SharedManager.shared.deliveryAddressName == "0") {
      return 'Assets/Icons/icon-home.png';
    } else if (SharedManager.shared.deliveryAddressName == "1") {
      return 'Assets/Icons/icon-home.png';
    } else if (SharedManager.shared.deliveryAddressName == "2")
      return 'Assets/Icons/icons-office.png';
    else {
      return 'Assets/Icons/icons-office.png';
    }
  }
  //Set Address
  String _setAddressType() {
    if (SharedManager.shared.deliveryAddressName == "0") {
      return S.current.home;
    } else if (SharedManager.shared.deliveryAddressName == "1") {
      return S.current.office;
    } else if (SharedManager.shared.deliveryAddressName == "2")
      return S.current.other;
    else {
      return '';
    }
  }

}
