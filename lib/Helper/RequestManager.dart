import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:flutter_web_test/ModelClass/ModelCartList.dart';
import 'package:flutter_web_test/ModelClass/ModelShopProductList.dart';
import 'package:http/http.dart' as http;
import 'Constant.dart';


class Requestmanager {

  //Fetch products based on restaurant and subCategory
  Future<ResStoreProductList> fetchShopProducts(
      String url, dynamic param) async {
    print('$url $param');
    try {
      http.Response response = await _apiRequest(url, param);
      print('Response==>${response.body}');
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        print("Products:------>$result");
        final code = result['code'];
        if (code == 0) {
          final object = ResStoreProductList();
          object.code = 0;
          object.message = "error";
          object.shopProductList = [];
          return object;
        } else {
          return ResStoreProductList.fromJson(json.decode(response.body));
        }
      } else {
        throw Exception("Fetch to failed restaurant details");
      }
    } on Exception catch (e) {
      print('Exception==> ${}');
    }
  }


  //Fetch CartList Data
  Future<ResCartList> fetchCartData(String userId) async {
    final param = {"user_id": userId};
    http.Response response = await _apiRequest(APIS.cartList, param);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print("Cart List Details:------>$result");
      final code = result['code'];
      // List list = result['result'];
      if (code == 0) {
        final object = ResCartList();
        object.code = 0;
        object.result = CardDetails(
          shopAddress: "",
          shopCountry: "",
          shopImage: "",
          shopName: "",
          data: [],
        );
        return object;
      }
      else {
        return ResCartList.fromJson(json.decode(response.body));
      }
    } else {
      throw Exception("Fetch to failed restaurant details");
    }
  }

  //Add to Cart Item
  Future<bool> addtoCart(List<CartItems> cartitems) async {
    if(cartitems.length > 0){
      var param = jsonEncode(cartitems);
      //print('Request Param'+param);
      http.Response response = await _apiRequestJson(APIS.addtoCart, param);
      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        //print('ResponseData===>'+response.body);
        if (responseData['code'] == 1) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    }else{
      return true;
    }

  }


  Future<String> ShopProducts(
      String url) async {
    http.Response response = await _apiRequestWithGet(url);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print("Products:------>$result");
      final code = result['code'];
      if (code == 0) {
        return '1';

      } else {
        return '0';
      }
    } else {
      throw Exception("Fetch to failed restaurant details");
    }
  }


  //Common Method for request api
//POST
  Future<http.Response> _apiRequest(String strUrl, Map jsonMap) async {
    var body = jsonEncode(jsonMap);
    Uri url = new Uri(host: strUrl);
    var response = await http.post(
      url,
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
      },
      body: body,
    );
    // print(response.body);
    return response;
  }

  Future<http.Response> _apiRequestJson(String strUrl, String body) async {
    //var body = jsonEncode(jsonMap);
    Uri url = new Uri(host: strUrl);
    var response = await http.post(
      url,
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
      },
      body: body,
    );
    // print(response.body);
    return response;
  }
}

//GET
Future<http.Response> _apiRequestWithGet(String strUrl) async {
  Uri url = new Uri(host: strUrl);
  var response = await http.get(url);
  // print(response.body);
  return response;
}
