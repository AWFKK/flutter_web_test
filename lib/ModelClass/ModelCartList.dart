

import 'package:flutter_web_test/BlocClass/CommonBlocClass/BaseMode.dart';

class ResCartList extends BaseModel {
  int code;
  String message;
  CardDetails result;

  ResCartList({this.code, this.message, this.result});

  ResCartList.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    result = json['result'] != null
        ? new CardDetails.fromJson(json['result'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    return data;
  }
}

class CardDetails {
  String shopName;
  String shopId;
  String shopImage;
  String shopAddress;
  String shopCountry;
  List<CartProduct> data;

  CardDetails(
      {this.shopName,
      this.shopId,
      this.shopImage,
      this.shopAddress,
      this.shopCountry,
      this.data});

  CardDetails.fromJson(Map<String, dynamic> json) {
    shopName = json['shop_name'];
    shopId = json['shop_id'];
    shopImage = json['shop_image'];
    shopAddress = json['shop_address'];
    shopCountry = json['shop_country'];
    if (json['data'] != null) {
      data = new List<CartProduct>();
      json['data'].forEach((v) {
        data.add(new CartProduct.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shop_name'] = this.shopName;
    data['shop_id'] = this.shopId;
    data['shop_image'] = this.shopImage;
    data['shop_address'] = this.shopAddress;
    data['shop_country'] = this.shopCountry;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CartProduct {
  String id;
  String productId;
  String name;
  String description;
  String totalQuantity;
  String image;
  String discount;
  String discountType;
  String unit;
  String unitPrice;

  CartProduct(
      {this.id,
      this.productId,
      this.name,
      this.description,
      this.totalQuantity,
      this.image,
      this.discount,
      this.discountType,
      this.unit,
      this.unitPrice});

  CartProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    name = json['name'];
    description = json['description'];
    totalQuantity = json['total_quantity'];
    image = json['image'];
    discount = json['discount'];
    discountType = json['discount_type'];
    unit = json['unit'];
    unitPrice = json['unit_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['total_quantity'] = this.totalQuantity;
    data['image'] = this.image;
    data['discount'] = this.discount;
    data['discount_type'] = this.discountType;
    data['unit'] = this.unit;
    data['unit_price'] = this.unitPrice;
    return data;
  }
}
//Cart Product
class CartItems {
  String id;
  String productId;
  String unitPrice;
  String discount;
  String unit;
  String userId;
  String shopId;
  String totalQuantity;

  CartItems(
      {this.id,
      this.productId,
      this.unitPrice,
      this.discount,
      this.unit,
      this.userId,
      this.shopId,
      this.totalQuantity});

  CartItems.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    productId = json['product_id'];
    unitPrice = json['unit_price'];
    discount = json['discount_price'];
    unit = json['unit'];
    userId = json['user_id'];
    shopId = json['shop_id'];
    totalQuantity = json['total_quantity'];
  }

  CartItems.fromMap(Map<String, dynamic> map) {
    id = map['id'].toString();
    productId = map['product_id'];
    unitPrice = map['unit_price'];
    discount = map['discount_price'];
    unit = map['unit'];
    userId = map['user_id'];
    shopId = map['shop_id'];
    totalQuantity = map['total_quantity'];
  }



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['unit_price'] = this.unitPrice;
    data['discount_price'] = this.discount;
    data['unit'] = this.unit;
    data['user_id'] = this.userId;
    data['shop_id'] = this.shopId;
    data['total_quantity'] = this.totalQuantity;

    return data;
  }

  Map<String, dynamic> toNewJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['unit_price'] = this.unitPrice;
    data['discount_price'] = this.discount;
    data['unit'] = this.unit;
    data['user_id'] = this.userId;
    data['shop_id'] = this.shopId;
    data['total_quantity'] = this.totalQuantity;

    return data;
  }
}
