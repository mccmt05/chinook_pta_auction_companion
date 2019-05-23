library data_objects;

import 'package:flutter/material.dart';

class AuctionGrouping {
  final String groupName;
  final MaterialColor groupColor;
  final String endTime;

  AuctionGrouping(this.groupName, this.groupColor, this.endTime);
}

class AuctionItem {
  final int itemNum;
  final String itemTitle;
  final String itemTeacher;
  final int itemValue;
  final String itemDescription;
  final AuctionGrouping itemGroup;

  AuctionItem(this.itemNum, this.itemTitle, this.itemTeacher, this.itemValue, this.itemDescription, this.itemGroup);

  String itemInfoStr() {
    return "Item " + this.itemNum.toString() + ": " + this.itemTitle + "\nTeacher: " + this.itemTeacher + "\nValue: \$" + this.itemValue.toString() + "\nDescription: " + this.itemDescription;
  }
}

AuctionGrouping blueGrouping = new AuctionGrouping("Blue Section", Colors.lightBlue, "7:00 PM");
AuctionGrouping greenGrouping = new AuctionGrouping("Green Section", Colors.green, "7:30 PM");
AuctionGrouping yellowGrouping = new AuctionGrouping("Yellow Section", Colors.yellow, "8:00 PM");

List<AuctionItem> blueGroupList = [
  new AuctionItem(1, "Learn Basket", "Smith", 150, "Learn some stuff", blueGrouping),
  new AuctionItem(2, "Play Basket", "Jones", 100, "Play around", blueGrouping),
];

List<AuctionItem> greenGroupList = [
  new AuctionItem(3, "Food Basket", "Thompson", 125, "Eat stuff", greenGrouping),
  new AuctionItem(4, "Lego Basket", "Adams", 200, "Legos to build", greenGrouping),
];

List<AuctionItem> yellowGroupList = [
  new AuctionItem(5, "A Basket", "Thompson", 325, "Do stuff", yellowGrouping),
  new AuctionItem(6, "Another Basket", "Adams", 400, "Even more stuff", yellowGrouping),
  new AuctionItem(7, "One More Basket", "Adams", 50, "Really...more stuff", yellowGrouping),
];

List<List<AuctionItem>> groupings = [
  blueGroupList,
  greenGroupList,
  yellowGroupList,
];