import 'package:flutter/material.dart';
import 'package:flutter_web_test/BlocClass/MainModelBlocClass/CartDetailsBloC.dart';
import 'package:flutter_web_test/Helper/CommonWidgets.dart';
import 'package:flutter_web_test/Helper/Constant.dart';
import 'package:flutter_web_test/Helper/DatabaseHelper.dart';
import 'package:flutter_web_test/Helper/SharedManaged.dart';
import 'package:flutter_web_test/ModelClass/ModelCartList.dart';
import 'package:flutter_web_test/Navbar/Navbar.dart';
import 'package:flutter_web_test/Screens/Checkout.dart';
import 'package:flutter_web_test/Screens/Products.dart';
import 'package:flutter_web_test/generated/i18n.dart';
import 'package:flutter_web_test/main.dart';
import 'package:intl/intl.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {

  var totalPrice = 0.0;
  var paidPrice = 0.0;

  var riderTip = 0;
  var charge = 10;            //We Can Set Delivery Charges Here

  var discountedPrice = 0.0;
  var grandTotalAmount = 0.0;

  List<CartProduct> cartList;

  int cartCount;
  var time = '';
  var date = '';

  bool isLoaded = false;

  @override
  void initState() {
    getCount();
    _fetchCartList();
    _selectDate('1');
    _getCurrentTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                child: Column(
                  children: [
                    NavBar(),
                  ],
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
                child: Column(
                  children: [
                    NavBar(),

                    Expanded(
                      child: Container(
                        color:AppColor.white ,
                        child: Stack(
                          children: [
                            Column(
                              children: [

                                SizedBox(height: 20,),

                                //List of Products In Cart
                                Expanded(
                                  child: Container(
                                    margin:EdgeInsets.only(left:20,right: 20,),
                                    decoration: BoxDecoration(

                                      color: Colors.white,
                                    ),
                                    child: _cartData(),

                                  ),
                                ),

                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: isLoaded ? InkWell(
                                    onTap: (){
                                      _fetchCartList();
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => Checkout(
                                            charge: "${this.charge}",
                                            discountedPrice: "${this.discountedPrice}",
                                            grandTotalAmount: "${this.totalPrice.toStringAsFixed(2)}",
                                            tipAmount: "${this.riderTip}",
                                            totalPrice: "${this.totalPrice.toStringAsFixed(2)}",
                                            totalSaving: "${this.paidPrice + 20}",
                                            cartItems: cartList,
                                            deliveryDate: this.date,
                                            deliveryTime: this.time,
                                          )));
                                    },
                                    child: Container(
                                      height: 60,
                                      color: AppColor.themeColor,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: setCommonText('Checkout',
                                                      AppColor.white, 16.0, FontWeight.bold, 1),
                                                ),
                                                SizedBox(width: 5,),
                                                setCommonText('(${cartCount} items)',
                                                    AppColor.white, 16.0, FontWeight.w500, 1),
                                              ],
                                            ),

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
                                                      child: FutureBuilder(
                                                        future: db.getCartTotalAmount(),
                                                        builder: (BuildContext _context, AsyncSnapshot<double> text)
                                                        {
                                                          if(text.data == null)
                                                          {
                                                            return setCommonText('${Currency.curr}' +"0.00", AppColor.black, 14.0, FontWeight.w900, 1);
                                                          }else
                                                          {
                                                            return setCommonText('${Currency.curr}' +
                                                                text.data.toStringAsFixed(2)??"0.00", AppColor.black, 14.0, FontWeight.w900, 1);
                                                          }

                                                        },
                                                      ),
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
                                  ) :Container(
                                    height: 60,
                                    color: AppColor.themeColor,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: setCommonText('',
                                                    AppColor.white, 16.0, FontWeight.bold, 1),
                                              ),
                                              SizedBox(width: 5,),
                                              setCommonText('',
                                                  AppColor.white, 16.0, FontWeight.w500, 1),
                                            ],
                                          ),

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
                                                    child: FutureBuilder(
                                                      future: db.getCartTotalAmount(),
                                                      builder: (BuildContext _context, AsyncSnapshot<double> text)
                                                      {
                                                        if(text.data == null)
                                                        {
                                                          return setCommonText('${Currency.curr}' +"0.00", AppColor.black, 14.0, FontWeight.w900, 1);
                                                        }else
                                                        {
                                                          return setCommonText('${Currency.curr}' +
                                                              text.data.toStringAsFixed(2)??"0.00", AppColor.black, 14.0, FontWeight.w900, 1);
                                                        }

                                                      },
                                                    ),
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
                                )
                              ],
                            ),

                          ],

                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          }
      ),
    );
  }


  //API Calling For Cart data
  _fetchCartList() {
    cartDetailsBloC.fetchCartDetails("2");
  }

  //Get Cart Count
  getCount()
  {
    DatabaseHelper db = new DatabaseHelper();
    db.getCount().then((value) {
      setState(() {
        cartCount = value;
      });
    });
  }

  //Cart Widget
  Widget _cartData() {
    return Material(
      type: MaterialType.transparency,
      child: StreamBuilder(
          stream: cartDetailsBloC.cartDetails,
          builder: (context, AsyncSnapshot<ResCartList> snapshot) {
            //return Center(child:CircularProgressIndicator(),);
            if (snapshot.hasData) {
              cartList = snapshot.data.result.data;
              // print('Final cart list:$cartList');
              if (!isLoaded)
                Future<void>.delayed(const Duration(seconds: 0)).then((value) {
                  setState(() {
                    isLoaded = true;
                  });
                });
              return (cartList.length > 0)
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                            child: new Container(
                          child: new ListView(
                            children: <Widget>[
                              //Product List In Cart
                              _setAddedProductList(
                                  ((cartList.length * 110.0) + 10), cartList),
                            ],
                          ),
                        )),
                      ],
                    )
                  : dataFound(context, S.current.dont_have_single_item_to_cart,
                      AssetImage(AppImages.cartDefaultImage), "0");
            }

            return Center(child: _searchEmptyContainer()
                //child: CircularProgressIndicator(),
                );
          }),
    );
  }

  //Products Which User Added into Cart
  _setAddedProductList(double height, List<CartProduct> cartItems) {
    return new Container(
      height: height,
      child: new ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          return new Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: new Column(
              children: <Widget>[

                Row(
                  children: [
                    Expanded(
                      flex:2,
                      child: Column(
                        children: [
                          Container(
                            // color: Colors.amber,
                              padding: new EdgeInsets.all(8),
                              child: Image(
                                image: NetworkImage(
                                    '${cartItems[index].image}'),
                                fit: BoxFit.cover,
                              )),
                        ],
                      ),
                    ),

                    Expanded(
                      flex:3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          setCommonText(cartItems[index].name,
                              Colors.black45, 14.0, FontWeight.bold, 2),

                          setCommonText(
                              '${Currency.curr}${cartItems[index].unitPrice}',
                              Colors.grey,
                              12.0,
                              FontWeight.w500,
                              1),
                        ],
                      ),
                    ),
                    //Product Counter
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              height: 25,
                              child: new Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: new Container(
                                        color: Colors.white,
                                        child: new Align(
                                          alignment: Alignment.topCenter,
                                          child: new GestureDetector(
                                            onTap: () async {

                                            },
                                            child: Container(
                                              width: 30,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                border: Border.all(color: AppColor.themeColor),
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(topLeft: Radius.circular(50),
                                                    bottomLeft: Radius.circular(50)),
                                              ),
                                              child: Center(
                                                  child:
                                                  Icon(Icons.remove, color: AppColor.themeColor, size: 19)),
                                            ),
                                          ),
                                        )),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: new Container(
                                      color: AppColor.themeColor,
                                      child: new Center(
                                        child: setCommonText(
                                            '${cartItems[index].totalQuantity}',
                                            Colors.white,
                                            10.0,
                                            FontWeight.w500,
                                            1),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: new Container(
                                      color: Colors.white,
                                      child: new Center(
                                        child: new GestureDetector(
                                          onTap: () async {
                                            //Update Local DB
                                            final param2 = {
                                              "product_id": cartItems[index].productId,
                                              "total_quantity": '1',
                                            };
                                            //Updating
                                            db.saveUpdateCartItem(param2).then((value) {
                                              setState(() {cartItems[index].totalQuantity =
                                                  (double.parse(cartItems[index].totalQuantity) + value).toString();
                                              _setTotalPriceCount(cartItems);
                                              });
                                            });

                                          },
                                          child: Container(
                                              width: 30,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                border: Border.all(color: AppColor.themeColor),
                                                color: Colors.white,
                                                borderRadius:BorderRadius.only(topRight: Radius.circular(50),
                                                    bottomRight: Radius.circular(50)),
                                              ),
                                              child: Icon(Icons.add, color: AppColor.themeColor,size: 22,)
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ],
                ),

                Divider(color: Colors.black38,),
              ],
            ),
          );
        },
      ),
    );
  }

  //Total Price
  _setTotalPriceCount(List<CartProduct> cartItems) {
    var total = 0.0;
    var totalWithDis = 0.0;
    for (var i = 0; i < cartItems.length; i++) {
      var price = double.parse(cartItems[i].unitPrice);
      var count = double.parse(cartItems[i].totalQuantity);

      total = total + (count * price);
      totalWithDis = totalWithDis +
          (count *
              double.parse(getPriceAfterDiscount(cartItems[i].unitPrice,
                  cartItems[i].discount, cartItems[i].discountType)));
    }
    this.paidPrice = total;
    this.totalPrice = total;
    print("Total Price 9 ${this.totalPrice}");
  }

  //Select Data
  _selectDate(String status) {
    //1 for today
    //0 for tomorrow
    if (status == '1') {
      DateTime today = DateTime.now();
      today = today.add(new Duration(days: 0));
      date = '${today.day}/${today.month}/${today.year}';
      print('Today\'s date is:$date');
    } else {
      DateTime today = DateTime.now();
      today = today.add(new Duration(days: 1));
      date = '${today.day}/${today.month}/${today.year}';
      print('Tommorow\'s date is:$date');
    }
  }
  //Select Time
  _getCurrentTime() {
    final now = new DateTime.now();
    time = DateFormat('Hm').format(now);
    print('${time}');
  }

  //Empty Container Wiget
  _searchEmptyContainer() {
    return new Container(
      color: AppColor.white,
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Expanded(
              child: new Container(
                child: new Center(
                  child: new Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        image: DecorationImage(
                            image: AssetImage('Assets/Cart/emptyCart.png'),
                            fit: BoxFit.fill)),
                  ),
                ),
              )),
          //CircularProgressIndicator()
          // _setLanguageOptions()
        ],
      ),
    );
  }
}
