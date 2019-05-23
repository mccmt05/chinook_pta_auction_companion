library favorites_utils;

import '../data/dataObjects.dart';

List<List<AuctionItem>> buildFavoritesList(List<AuctionItem> inList) {
  List<List<AuctionItem>> favoritesListSplit = [];
  List<AuctionItem> tempList = [];
  for(List<AuctionItem> indivList in groupings) {
    tempList = splitFavoriteList(inList, indivList[0].itemGroup);
    if(tempList.isNotEmpty) {
      favoritesListSplit.add(tempList);
    }
  }

  return favoritesListSplit;
}

List<AuctionItem> splitFavoriteList(List<AuctionItem> inList, AuctionGrouping inGroup) {
  List<AuctionItem> rtnList = [];
  for(AuctionItem item in inList) {
    if(item.itemGroup == inGroup) {
      rtnList.add(item);
    }
  }
  return rtnList;
}