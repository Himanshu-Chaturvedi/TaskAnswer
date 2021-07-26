import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "GridView Ad",
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  Future<List> fetchAds() async {
    try {
      final response = await http.get('https://picsum.photos/v2/list');
      if (response.statusCode == 200) return json.decode(response.body);
    } catch (e) {}
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GridView Card"),
        centerTitle: true,
      ),
      body: FutureBuilder<List>(
          future: fetchAds(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return new Padding(
                padding: const EdgeInsets.all(4.0),
                child: new StaggeredGridView.count(
                  crossAxisCount: 4,
                  padding: const EdgeInsets.all(2.0),
                  children: snapshot.data.map<Widget>((item) {
                    return new CardView(item);
                  }).toList(),

                  //Here is the place that we are getting flexible/ dynamic card for various images
                  staggeredTiles: snapshot.data
                      .map<StaggeredTile>((_) => StaggeredTile.fit(2))
                      .toList(),
                  mainAxisSpacing: 3.0,
                  crossAxisSpacing: 4.0, // add some space
                ),
              );
            } else {
              return Center(child: new CircularProgressIndicator());
            }
          }),
    );
  }
}

//This is actually not need to be a StatefulWidget but in case, I have it
class CardView extends StatefulWidget {
  CardView(this.ad);

  final ad;

  _CardViewState createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  var _ad;
  String download_url;
  String author;
  int _width;
  int _height;
  String dummyImage =
      'https://thumbs.dreamstime.com/b/environment-earth-day-hands-trees-growing-seedlings-bokeh-green-background-female-hand-holding-tree-nature-field-gra-130247647.jpg';

  void initState() {
    setState(() {
      _ad = widget.ad;
      download_url =
          (_ad['download_url'] != '') ? _ad['download_url'] : dummyImage;
      author = (_ad['author'] != '') ? _ad['author'] : '';
      _width = (_ad['width'] != '') ? _ad['width'] : '';
      _height = (_ad['height'] != '') ? _ad['height'] : '';
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      semanticContainer: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: CachedNetworkImage(
              fit: BoxFit.fill,
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.height * 0.3,
              // width: _width.toDouble(),
              // height: _height.toDouble(),
              imageUrl: download_url,
              placeholder: (context, url) => new Center(
                child: Container(
                  height: 20,
                  width: 20,
                  margin: EdgeInsets.all(5),
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                    valueColor: AlwaysStoppedAnimation(Colors.green),
                  ),
                ),
              ),
              errorWidget: (context, url, error) => new Icon(Icons.error),
            ),
          ),
          Center(
              child: Text(
            author,
            style: TextStyle(fontSize: 14),
          )),
        ],
      ),
    );
  }
}
