import 'package:flutter_web_test/ModelClass/ModelCartList.dart';
import 'package:flutter_web_test/ModelClass/ModelShopProductList.dart';
import './../../Helper/RequestManager.dart';


class Repository {
  final reqManager = Requestmanager();

  //Fetch Shop Products
  Future<ResStoreProductList> fetchShopProducts(String url, dynamic param) =>
      reqManager.fetchShopProducts(url, param);

  //Fetch Cart Details
  Future<ResCartList> fetchCartDetails(String userId) =>
      reqManager.fetchCartData(userId);

}
