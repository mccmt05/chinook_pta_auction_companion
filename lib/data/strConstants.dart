library str_constants;

import 'dataObjects.dart';

String itemInfoStr(AuctionItem item) {
  return "Item " + item.itemNum.toString() + ": " + item.itemTitle + "\nTeacher: " + item.itemTeacher + "\nValue: \$" + item.itemValue.toString() + "\nDescription: " + item.itemDescription;
}