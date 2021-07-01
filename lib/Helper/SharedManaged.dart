import 'package:flutter/material.dart';
import 'package:flutter_web_test/Helper/CommonWidgets.dart';
import 'package:flutter_web_test/generated/i18n.dart';
import 'dart:math' show cos, sqrt, asin;
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Constant.dart';


class SharedManager {
  static final SharedManager shared = SharedManager._internal();

  factory SharedManager() {
    return shared;
  }

  SharedManager._internal();

  var fontFamilyName = "Quicksand";
  bool isRTL = false;
  var direction = TextDirection.ltr;
  var address = "Select Address";
  double latitude = 0.0;
  double longitude = 0.0;
  var addressId = '';
  var deliveryAddressName = "";
  var deliveryAddressNumber = "";
  var restaurantID = "";
  var userID = "2";
  var oldResID = "";
  var resName = "";
  var resAddress = "";
  var resImage = "";
  bool isFromTab = false;
  bool isFromCart = false;
  String isFrom = 'dashboard';
  int currentIndex = 0;
  var isLoggedIN = "no";
  var token = "";
  String resLatitude = "0";
  String resLongitude = "0";
  String orderId = "";

  //Set Distance Radius.
  //Order is only applicable between 15kms.
  double distanceFilter = 15.0;
  var displayName;
  var addressType;

  //We have set 3 second for updating driver location every time.
  //during order tracking.
  //you can set according to your requirements.
  int updateDriver = 300;

  //Couponcode Functionality
  //Make sure after order complete it should be clear

  bool isCouponApplied = false;
  var discountType = "";
  var discount = "0";
  var discountPice = "0";
  double tempTotalPrice = 0.0;
  var couponCode = '';
  var couponCodeImage = '';

  //Driver Details
  var driverName = '';
  var driverImage = '';
  var driverReview = '';
  var driverPhone = '';

  int cartCount = 0;

  //This is the temp veriable which stores the shop id.
  String shopId = '0';

  ValueNotifier<Locale> locale = new ValueNotifier(Locale('en', ''));
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();


  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  String validateMobile(String value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }


  //Calculate Distance between two location.
  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

}

