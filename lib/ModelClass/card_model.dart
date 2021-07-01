import 'package:flutter/material.dart';

class CardModel {
  List<CardResults> results;

  CardModel({this.results});

  CardModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      results = new List<CardResults>();
      json['result'].forEach((v) {
        results.add(new CardResults.fromJson(v));
      });
    }
  }
}

class CardResults {
  String cardHolderName;
  String cardNumber;
  String cardMonth;
  String cardYear;
  String cardCvv;
  Color cardColor;
  String cardType;
  int cardColorIndex;
  int cardId;

  CardResults(
      {this.cardHolderName,
      this.cardNumber,
      this.cardMonth,
      this.cardYear,
      this.cardCvv,
      this.cardColor,
      this.cardType,
      this.cardColorIndex,
      this.cardId});

  CardResults.fromJson(Map<String, dynamic> json) {
    cardHolderName = json['cardHolderName'];
    cardNumber = json['cardNumber'];
    cardMonth = json['cardMonth'];
    cardYear = json['cardYear'];
    cardCvv = json['cardCvv'];
    cardColor = json['cardColor'];
    cardType = json['cardType'];
    cardColorIndex = int.parse(json['cardColorIndex']);
    cardId = int.parse(json['id']);
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cardHolderName'] = this.cardHolderName;
    data['cardNumber'] = this.cardNumber;
    data['cardMonth'] = this.cardMonth;
    data['cardYear'] = this.cardYear;
    data['cardCvv'] = this.cardCvv;
    data['cardColor'] = this.cardColor;
    data['cardType'] = this.cardType;
    data['cardColorIndex'] = this.cardColorIndex;
    data['id'] = this.cardId;
    return data;
  }

}
