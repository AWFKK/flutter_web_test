import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_web_test/Helper/CommonWidgets.dart';
import 'package:flutter_web_test/Helper/Constant.dart';
import 'package:flutter_web_test/Helper/DatabaseHelper.dart';
import 'package:flutter_web_test/Helper/RequestManager.dart';
import 'package:flutter_web_test/Helper/SharedManaged.dart';
import 'package:flutter_web_test/ModelClass/ModelShopProductList.dart';
import 'package:flutter_web_test/Navbar/Navbar.dart';
import 'package:flutter_web_test/Screens/CartItems.dart';
import 'package:flutter_web_test/generated/i18n.dart';

import '../main.dart';




class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {

  //DB Object
  DatabaseHelper db = new DatabaseHelper();

  List<ShopProduct> similarResult = [];

  bool _canShowButton = false;
  void hideWidget(){
    setState(() {
      _canShowButton = true;
    });
  }

  @override
  void initState() {
    _fetchProductsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double bottomPadding = MediaQuery.of(context).padding.bottom;

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
            child: Padding(
              padding: EdgeInsets.only(bottom: bottomPadding),
              child: Column(
                children: [
                  NavBar(),
                  setRunningBalanceWidget(context,AppColor.white),
                  SizedBox(height: 10,),
                  Expanded(
                    child: Container(
                      //color: Colors.grey,
                      child: _gridLayout(context, 4),
                    ),
                  ),

                ],
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
              child: Padding(
                padding: EdgeInsets.only(bottom: bottomPadding),
                child: Column(
                  children: [
                    NavBar(),
                    setRunningBalanceWidget(context,AppColor.white),
                    SizedBox(height: 10,),
                    Expanded(
                      child: Container(
                        //color: Colors.grey,
                        child: _gridLayout(context, 2),
                      ),
                    ),

                  ],
                ),
              ),
            );
          }
      }
    ),
      );
  }

  Widget _gridLayout(BuildContext context, int count){
    return GridView.count(
      // Create a grid with 2 columns. If you change the scrollDirection to
      // horizontal, this produces 2 rows.
      crossAxisCount: count,
      // Generate 100 widgets that display their index in the List.
      children: List.generate(similarResult.length, (index) {
        return Center(
          child: _productCard(index)
        );
      }),
    );
  }

  _productCard(int _index){
    return Stack(
      children: [
        Card(
            margin:EdgeInsets.only(left:15,right: 15, top: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(10)
              ),
            ),
            color: Colors.grey.shade200,
            child: InkWell(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  crossAxisAlignment:
                  CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 5,),
                    //Image
                    Expanded(
                        flex: 10,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:NetworkImage(this.similarResult[_index].image))),
                        )),
                    //Title
                    Expanded(
                        flex: 4,
                        child: Container(
                            padding: EdgeInsets.only(
                                left: 15, right: 15),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(this.similarResult[_index].name,
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight:
                                    FontWeight.w400,
                                    color: AppColor.black
                                ),
                              ),
                            ))),
                    //Price + Counter
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15,0,15,0),
                        child: Row(
                          children: <Widget>[
                            //Price
                            Expanded(
                              flex: 2,
                              child: Text('${Currency.curr} ${getPriceAfterDiscount(similarResult[_index].price,
                                  similarResult[_index].discount, similarResult[_index].discountType)}',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight:
                                  FontWeight.w700,
                                  color: AppColor.themeColor
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 15,),
                  ],
                ),
              ),
            )),
        Positioned(
          right: 5,
          top: 5,
          child: Container(
            child: _counterRow(_index,),
          ),
        ),
      ],
    );
  }

  Widget _counterRow(int _index) {
    int ressult = int.tryParse(similarResult[_index].totalQuantity) == null?0:int.tryParse(similarResult[_index].totalQuantity) ;
    return Row(
      children: [
        //Counter here
        //Fro Removing
        Visibility(
          visible: ressult > 0,
          maintainSize: true,
          maintainState: true,
          maintainAnimation: true,
          child: InkWell(
            onTap: () async {
              if (int.parse(similarResult[_index].totalQuantity) > 0) {
                final param = {
                  "user_id": "0",
                  "shop_id": "1",
                  "total_quantity": '-1',
                  "product_id": similarResult[_index].id,
                  "unit_price": getPriceAfterDiscount(similarResult[_index].price, similarResult[_index].discount, similarResult[_index].discountType),
                  "discount_price":
                  "${getDiscountPrice(similarResult[_index].price, similarResult[_index].discount, similarResult[_index].discountType)}",
                  "unit": similarResult[_index].unit
                };

                db.saveUpdateCartItem(param).then((value) {
                  SharedManager.shared.scaffoldKey.currentState
                      .hideCurrentSnackBar();
                });

                //Removing Items One By One
                //Adding  Into Cart
                db.getCartItemQuantity(similarResult[_index].id).then((value) {
                  print('Value from Server===>$value');
                  if (value == '') {
                    setState(() {
                      similarResult[_index].totalQuantity = '1';
                    });
                  } else if (int.parse(value) >= 1) {
                    int test = int.parse(value);
                    test--;
                    setState(() {
                      similarResult[_index].totalQuantity = test.toString();
                    });
                  }
                });
              } else {
                db
                    .deleteCartItem(int.parse(similarResult[_index].id))
                    .then((value) {
                  SharedManager.shared.scaffoldKey.currentState
                      .hideCurrentSnackBar();
                });
              }
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
        ),
        //For Count
        Visibility(
          visible: ressult > 0,
          maintainSize: true,
          maintainState: true,
          maintainAnimation: true,
          child: Container(
            width: 30,
            height: 30,
            color: AppColor.themeColor,
            child: new Center(
              child: setCommonText(
                  similarResult[_index].totalQuantity == ''
                      ? similarResult[_index].totalQuantity = '0'
                      :similarResult[_index].totalQuantity.toString(),
                  AppColor.white,
                  18.0,
                  FontWeight.w500,
                  1),
            ),
          ),
        ),
        //For Adding
        Visibility(
          visible: true,
          maintainSize: true,
          maintainState: true,
          maintainAnimation: true,
          child: InkWell(
            onTap:() async {
              hideWidget();
              final param = {
                "user_id": "0",
                "shop_id": "1",
                "total_quantity": '1',
                "product_id": similarResult[_index].id,
                "unit_price": getPriceAfterDiscount(similarResult[_index].price, similarResult[_index].discount, similarResult[_index].discountType),
                "discount_price":
                "${getDiscountPrice(similarResult[_index].price, similarResult[_index].discount, similarResult[_index].discountType)}",
                "unit": similarResult[_index].unit
              };
              //Save And Update data
              await db.saveUpdateCartItem(param).then((value) {
                print('Total Quantity Of Selected Product $value');
              });
              //Get Total Quantity
              db.getCartItemQuantity(similarResult[_index].id).then((value) {
                setState(() {
                  similarResult[_index].totalQuantity = value.toString();
                });
              });
            },
            child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColor.themeColor),
                  color: Colors.white,
                  borderRadius: ressult<1?BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                      bottomLeft:Radius.circular(50)
                  )
                      :BorderRadius.only(topRight: Radius.circular(50),
                      bottomRight: Radius.circular(50)),
                ),
                child: Icon(Icons.add, color: AppColor.themeColor,size: 25,)
            ),
          ),
        ),
      ],
    );
  }

  setRunningBalanceWidget(BuildContext context, Color bgColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
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
                          _updateCartItemsOnServer();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CartItems()),
                          );
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
      ),
    );
  }


  _fetchProductsList() async {

    Requestmanager manager = Requestmanager();
    //await manager.ShopProducts('https://jsonplaceholder.typicode.com/albums/1');
    final param = {
      "subcat_id": "0",
      "shop_id": "1",
      "user_id": "2",
      "cat_id": "10"
    };
    // print('Record Valur ${json.encode(param)}');
    await manager.fetchShopProducts(APIS.shopProductList, param).then((value) {
      //print('ParamValue ${json.encode(value)}');
      setState(() {
        if (value.code == 1) {
          this.similarResult = value.shopProductList;
        } else {
         print(
              'Somethings goes wrong please try after sometimes');
        }
      });
    });
  }

  //Discount Calculator
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

  //Update Selected Products On Server
  _updateCartItemsOnServer() async
  {
    Requestmanager manager = Requestmanager();
    await db.getAllCartItems().then((value) async {
      value.forEach((element) {
        element.userId = SharedManager.shared.userID;
      });
      await manager.addtoCart(value);
    });
  }

}
