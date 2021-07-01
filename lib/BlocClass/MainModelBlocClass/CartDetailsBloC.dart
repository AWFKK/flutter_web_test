

import 'package:flutter_web_test/BlocClass/CommonBlocClass/BaseBloc.dart';
import 'package:flutter_web_test/Helper/DatabaseHelper.dart';
import 'package:flutter_web_test/Helper/RequestManager.dart';
import 'package:flutter_web_test/ModelClass/ModelCartList.dart';

class CartDetailsBloC extends BaseBloc<ResCartList>{
  Stream<ResCartList> get cartDetails => fetcher.stream;
  fetchCartDetails(String userId) async {

    DatabaseHelper db = new DatabaseHelper();
    Requestmanager req  = new Requestmanager();

    await db.getAllCartItems().then((value) async {
      value.forEach((element) {
        element.userId = userId;
      });
      await req.addtoCart(value);
    });

    ResCartList restaurantList = await repository.fetchCartDetails(userId);
    fetcher.sink.add(restaurantList);
  }

  refreshCartDetails(String userId) async {

    Requestmanager req  = new Requestmanager();

    ResCartList restaurantList = await repository.fetchCartDetails(userId);
    fetcher.sink.add(restaurantList);
  }
}

final cartDetailsBloC = CartDetailsBloC();