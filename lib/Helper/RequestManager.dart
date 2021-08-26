import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:flutter_web_test/ModelClass/ModelCartList.dart';
import 'package:flutter_web_test/ModelClass/ModelShopProductList.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'Constant.dart';


class Requestmanager {

  //Fetch products based on restaurant and subCategory
  Future<ResStoreProductList> fetchShopProducts(
      String url, dynamic param) async {
    print('$url $param');
    http.Response response = await _apiRequest(APIS.baseurl,APIS.shopProductList, param);
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
  }


  //Fetch CartList Data
  Future<ResCartList> fetchCartData(String userId) async {
    final param = {"user_id": userId};
    http.Response response = await _apiRequest(APIS.baseurl,APIS.cartList, param);
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

  //Add Selected Items Into Cart
  Future<bool> addtoCart(List<CartItems> cartitems) async {
    if(cartitems.length > 0){
      dynamic param = json.encode(cartitems);
      print('Request Param'+param);
      http.Response response = await _apiRequestJson('www.instadoor.com','/webservices/addToCart', param);
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


                //  <######Common Method for request api#######>

  //POST
  Future<http.Response> _apiRequest(String strUrl,String method, Map jsonMap) async {
    var body = jsonEncode(jsonMap);
    Uri url = new Uri.https(strUrl, method);
    var response = await http.post(
      url,
      headers: {
        "Access-Control-Allow-Origin": "*", // Required for CORS support to work
        //"Access-Control-Allow-Credentials": true, // Required for cookies, authorization headers with HTTPS
        "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
        "Access-Control-Allow-Methods": "POST, OPTIONS"
      },
      body: body,
    );
    // print(response.body);
    return response;
  }

  Future<http.Response> _apiRequestJson(String strUrl, String method, String body) async {
    //var body = jsonEncode(jsonMap);
    Uri url = new Uri.https(strUrl, method);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
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


