import 'package:flutter/material.dart';
import 'package:musixinfo/models/music_recommends.dart';
import 'package:musixinfo/pages/bookmark_page.dart';
import 'package:musixinfo/special_widgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Musix Info',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Musix Info'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  RecommendedMusicList _musicListBloC = RecommendedMusicList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(40, 40, 40, 1),
        centerTitle: true,
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.collections_bookmark),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => BookmarkPage(),
                ),
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: StreamBuilder(
        stream: _musicListBloC.output,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none ||
              snapshot.connectionState == ConnectionState.waiting ||
              snapshot.data == true) {
            return Center(
              child: SizedBox(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (snapshot.data == null) {
            return Center(
              child: Text(
                "NO INTERNET CONNECTION",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            );
          }

          List<Widget> recommendedMusicWidgets = [];
          snapshot.data.forEach((track) {
            recommendedMusicWidgets.add(
              MusicInfoTile(
                trackData: track['track'],
                key: ValueKey(track['track']['track_id']),
              ),
            );
          });
          return ListView(
            physics: BouncingScrollPhysics(),
            children: recommendedMusicWidgets,
          );
        },
      ),
    );
  }
}
