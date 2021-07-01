

import 'package:flutter_web_test/BlocClass/CommonBlocClass/BaseMode.dart';

class ResStoreProductList extends BaseModel {
  int code;
  String message;
  List<ShopProduct> shopProductList;

  ResStoreProductList({this.code, this.message, this.shopProductList});

  ResStoreProductList.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['result'] != null) {
      shopProductList = new List<ShopProduct>();
      json['result'].forEach((v) {
        shopProductList.add(new ShopProduct.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.shopProductList != null) {
      data['result'] = this.shopProductList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShopProduct {
  String id;
  String name;
  String status;
  String shopName;
  String image;
  String price;
  String unit;
  String isAdded;
  String totalQuantity;
  String discount;
  String latitude;
  String longitude;
  String expDate;
  String cartId;
  String discountType;

  ShopProduct(
      {this.id,
      this.name,
      this.status,
      this.shopName,
      this.image,
      this.price,
      this.unit,
      this.isAdded,
      this.totalQuantity,
      this.discount,
      this.latitude,
      this.longitude,
      this.expDate,
      this.cartId,
      this.discountType});

  ShopProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    shopName = json['shop_name'];
    image = json['image'];
    price = json['price'];
    unit = json['unit'];
    isAdded = json['is_added'];
    totalQuantity = json['total_quantity'];
    discount = json['discount'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    expDate = json['expiry_date'];
    cartId = json['cart_id'];
    discountType = json['discount_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    data['shop_name'] = this.shopName;
    data['image'] = this.image;
    data['price'] = this.price;
    data['unit'] = this.unit;
    data['is_added'] = this.isAdded;
    data['total_quantity'] = this.totalQuantity;
    data['discount'] = this.discount;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['expiry_date'] = this.expDate;
    data['cart_id'] = this.cartId;
    data['discount_type'] = this.discountType;
    return data;
  }
}
