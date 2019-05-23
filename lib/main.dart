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
}

AuctionGrouping blueGrouping = new AuctionGrouping("Blue Section", Colors.lightBlue, "7:00 PM");
AuctionGrouping greenGrouping = new AuctionGrouping("Green Section", Colors.green, "7:30 PM");

List<AuctionItem> blueGroupList = [
  new AuctionItem(1, "Learn Basket", "Smith", 150, "Learn some stuff", blueGrouping),
  new AuctionItem(2, "Play Basket", "Jones", 100, "Play around", blueGrouping),
];

List<AuctionItem> greenGroupList = [
  new AuctionItem(3, "Food Basket", "Thompson", 125, "Eat stuff", greenGrouping),
  new AuctionItem(4, "Lego Basket", "Adams", 200, "Legos to build", greenGrouping),
];

List<List<AuctionItem>> groupings = [
  blueGroupList,
  greenGroupList,
];

void main() => runApp(new MaterialApp(home: new MyApp(), debugShowCheckedModeBanner: false, title: 'ChinookTrailPTA Silent Auction Companion',),);

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Set<AuctionItem> _saved = Set<AuctionItem>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("CTE PTA Silent Auction Companion", style: new TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black),),
        backgroundColor: Colors.orange,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.favorite), color: Colors.red, onPressed: _pushSaved),
        ],
      ),
      body: new ListView.builder(
        itemCount: groupings.length,
        itemBuilder: (context, i) {
          return _buildIndivGroupingList(groupings[i], false);
        },
      ),
    );
  }

  Widget _buildIndivGroupingList(List<AuctionItem> itemList,  bool fromFavorites) {
    return ExpansionTile(
      title: new Text(itemList[0].itemGroup.groupName + "\nEnd Time: " + itemList[0].itemGroup.endTime,
        style: new TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black) ,),
      backgroundColor: itemList[0].itemGroup.groupColor,
      children: <Widget>[
        new Column(
          children: _buildExpandableContent(itemList, fromFavorites),
        ),
      ],
      initiallyExpanded: true,
    );
  }

  List<Widget> _buildExpandableContent(List<AuctionItem> itemList, bool fromFavorites) {
    List<Widget> columnContent = [];
    for (AuctionItem item in itemList) {
      bool alreadySaved = _saved.contains(item);
      if(fromFavorites) {
        columnContent.add(
          new ListTile(
            title: new Text(
              "Item " + item.itemNum.toString() + ": " + item.itemTitle +
                  "\nTeacher: " + item.itemTeacher + "\nValue: \$" +
                  item.itemValue.toString() + "\nDescription: " +
                  item.itemDescription,
              style: new TextStyle(fontSize: 14.0, color: Colors.black),),
          ),
        );
      }
      else {
        columnContent.add(
          new ListTile(
            title: new Text(
              "Item " + item.itemNum.toString() + ": " + item.itemTitle +
                  "\nTeacher: " + item.itemTeacher + "\nValue: \$" +
                  item.itemValue.toString() + "\nDescription: " +
                  item.itemDescription,
              style: new TextStyle(fontSize: 14.0, color: Colors.black),),
            trailing: Icon(
              alreadySaved ? Icons.favorite : Icons.favorite_border,
              color: alreadySaved ? Colors.red : null,
            ),
            onTap: () {
              setState(() {
                if (alreadySaved) {
                  _saved.remove(item);
                } else {
                  _saved.add(item);
                }
              });
            },
          ),
        );
      }
    }

    return ListTile.divideTiles(context: context, tiles: columnContent).toList();
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          List<AuctionItem> _savedSorted = _saved.toList();
          _savedSorted.sort((a, b) => a.itemNum.compareTo(b.itemNum));

          final List<List<AuctionItem>> favList = buildFavoritesList(_savedSorted);

          return Scaffold(
            appBar: AppBar(
              title: Text("Saved Auction Items", style: new TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black),),
              backgroundColor: Colors.orange,
            ),
            body: new ListView.builder(
              itemCount: favList.length,
              itemBuilder: (context, i) {
                return _buildIndivGroupingList(favList[i], true);
              },
            ),
          );
        },
      ),
    );
  }

  List<List<AuctionItem>> buildFavoritesList(List<AuctionItem> inList) {
    List<List<AuctionItem>> favoritesListSplit = [];
    for(List<AuctionItem> indivList in groupings) {
          favoritesListSplit.add(splitFavoriteList(inList, indivList[0].itemGroup));
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
}