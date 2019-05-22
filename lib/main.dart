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
          return _buildIndivGroupingList(groupings[i]);
        },
      ),
    );
  }

  Widget _buildIndivGroupingList(List<AuctionItem> itemList) {
    return ExpansionTile(
      title: new Text(itemList[0].itemGroup.groupName + "\nEnd Time: " + itemList[0].itemGroup.endTime,
        style: new TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black) ,),
      backgroundColor: itemList[0].itemGroup.groupColor,
      children: <Widget>[
        new Column(
          children: _buildExpandableContent(itemList),
        ),
      ],
      initiallyExpanded: true,
    );
  }

  List<Widget> _buildExpandableContent(List<AuctionItem> itemList) {
    List<Widget> columnContent = [];
    for (AuctionItem item in itemList) {
      bool alreadySaved = _saved.contains(item);
      columnContent.add(
        new ListTile(
          title: new Text(
            "Item " + item.itemNum.toString() + ": " + item.itemTitle + "\nTeacher: " + item.itemTeacher + "\nValue: \$" + item.itemValue.toString() + "\nDescription: " + item.itemDescription,
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

    return ListTile.divideTiles(context: context, tiles: columnContent).toList();
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          List<AuctionItem> _savedSorted = _saved.toList();
          _savedSorted.sort((a, b) => a.itemNum.compareTo(b.itemNum));
          /*
          final List<Container> contentsOfFavorites = _savedSorted.map((AuctionItem item) {
            return Container(color: item.itemGroup.groupColor, child: Text("Item " + item.itemNum.toString() + ": " + item.itemTitle + "\nTeacher: " + item.itemTeacher + "\nValue: \$" + item.itemValue.toString() + "\nDescription: " + item.itemDescription,),);
          },);
          */

          final Iterable<ListTile> tiles = _savedSorted.map((AuctionItem item) {
              return ListTile(
                title: Text(
                  "Item " + item.itemNum.toString() + ": " + item.itemTitle + "\nTeacher: " + item.itemTeacher + "\nValue: \$" + item.itemValue.toString() + "\nDescription: " + item.itemDescription,
                ),

              );
            },
          );

          final List<Widget> divided = ListTile
              .divideTiles(
            context: context,
            tiles: tiles,
          )
              .toList();

          return Scaffold(
            appBar: AppBar(
              title: Text("Saved Auction Items", style: new TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black),),
              backgroundColor: Colors.orange,
            ),
            //body: ListView(children: contentsOfFavorites),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }
}