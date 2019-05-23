import 'package:flutter/material.dart';
import 'data/dataObjects.dart';
import 'data/strConstants.dart';
import 'util/favoritesUtils.dart';

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
        title: Text("CTE PTA Silent Auction Companion",
          style: new TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black),),
        backgroundColor: Colors.orange,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.favorite), color: Colors.red, onPressed: pushSaved),
        ],
      ),
      body: new ListView.builder(
        itemCount: groupings.length,
        itemBuilder: (context, i) {
          return buildIndivGroupingList(groupings[i], false);
        },
      ),
    );
  }

  Widget buildIndivGroupingList(List<AuctionItem> itemList,  bool fromFavorites) {
    return ExpansionTile(
      title: new Text(itemList[0].itemGroup.groupName + "\nEnd Time: " + itemList[0].itemGroup.endTime,
        style: new TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black),),
      backgroundColor: itemList[0].itemGroup.groupColor,
      children: <Widget>[
        new Column(
          children: buildExpandableContent(itemList, fromFavorites),
        ),
      ],
      initiallyExpanded: true,
    );
  }

  List<Widget> buildExpandableContent(List<AuctionItem> itemList, bool fromFavorites) {
    List<Widget> columnContent = [];
    for (AuctionItem item in itemList) {
      bool alreadySaved = _saved.contains(item);
      if(fromFavorites) {
        columnContent.add(
          new ListTile(
            title: new Text(itemInfoStr(item),
              style: new TextStyle(fontSize: 14.0, color: Colors.black),),
          ),
        );
      }
      else {
        columnContent.add(
          new ListTile(
            title: new Text(itemInfoStr(item),
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

  void pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
          builder: (BuildContext context) {
            if (_saved.length != 0) {
              List<AuctionItem> _savedSorted = _saved.toList();
              _savedSorted.sort((a, b) => a.itemNum.compareTo(b.itemNum));

              final List<List<AuctionItem>> favList = buildFavoritesList(
                  _savedSorted);

              return Scaffold(
                appBar: AppBar(
                  title: Text("Saved Auction Items", style: new TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),),
                  backgroundColor: Colors.orange,
                ),
                body: new ListView.builder(
                  itemCount: favList.length,
                  itemBuilder: (context, i) {
                    return buildIndivGroupingList(favList[i], true);
                  },
                ),
              );
            }
            else {
              return Scaffold(
                  appBar: AppBar(
                    title: Text("Saved Auction Items", style: new TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),),
                    backgroundColor: Colors.orange,
                  ),
                  body: new ListTile(title: new Text("You currently have not selected any favorites",
                    style: new TextStyle(fontSize: 14.0, color: Colors.black),))
              );
            }
          }
      ),
    );
  }
}