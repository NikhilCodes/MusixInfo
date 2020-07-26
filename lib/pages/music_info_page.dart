import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musixinfo/constants.dart';
import 'package:musixinfo/helper_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MusicInfoPage extends StatefulWidget {
  MusicInfoPage({Key key, this.trackId}) : super(key: key);

  final trackId;

  @override
  State<StatefulWidget> createState() {
    return _MusicInfoPage();
  }
}

class _MusicInfoPage extends State<MusicInfoPage> {
  final TextStyle bodyTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 20,
  );

  final TextStyle headingTextStyle = TextStyle(
    color: Colors.white70,
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );

  var lyrics = "";
  var trackData;
  bool isBookmarked = false;
  SharedPreferences _preferences;

  @override
  void initState() {
    loadTrackData();
    super.initState();
    loadLyrics();
  }

  loadTrackData() async {
    var _trackData = await getTrackDataByTrackId(widget.trackId);
    _preferences = await SharedPreferences
        .getInstance(); // Getting instance once and for all
    var bookmarks = _preferences.getStringList(bookmarksPrefKey);
    setState(() {
      trackData = _trackData;
      isBookmarked = bookmarks != null && bookmarks.contains("${widget.trackId}");
    });
  }

  loadLyrics() async {
    var _lyrics = await getLyricsByTrackId(widget.trackId);
    setState(() {
      lyrics = _lyrics;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(40, 40, 40, 1),
        title: Text("Track Details"),
      ),
      backgroundColor: Colors.black,
      body: trackData == null
          ? Center(
              child: SizedBox(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(),
              ),
            )
          : ListView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(20),
              children: <Widget>[
                Text("${trackData["track_name"]}", style: bodyTextStyle),
                SizedBox(height: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Artist", style: headingTextStyle),
                    Text("${trackData["artist_name"]}", style: bodyTextStyle),
                  ],
                ),
                SizedBox(height: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Album Name", style: headingTextStyle),
                    Text("${trackData["album_name"]}", style: bodyTextStyle),
                  ],
                ),
                SizedBox(height: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Explicit", style: headingTextStyle),
                    Text(trackData["explicit"] == 1 ? "True" : "False",
                        style: bodyTextStyle),
                  ],
                ),
                SizedBox(height: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Rating", style: headingTextStyle),
                    Text("${trackData["track_rating"]}", style: bodyTextStyle),
                  ],
                ),
                SizedBox(height: 14),
                lyrics == ""
                    ? Center(
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Lyrics", style: headingTextStyle),
                          Text("${lyrics.split("\n...\n")[0]}",
                              style: bodyTextStyle),
                        ],
                      ),
                SizedBox(height: 24),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(isBookmarked ? Icons.bookmark : Icons.bookmark_border,
            color: Colors.black),
        onPressed: () {
          var bookmarks = _preferences.getStringList(bookmarksPrefKey);

          if (!isBookmarked) {
            var bookmarks = _preferences.getStringList(bookmarksPrefKey);
            if (bookmarks == null) {
              bookmarks = ["${widget.trackId}"];
            } else {
              bookmarks.add("${widget.trackId}");
            }
            _preferences.setStringList(bookmarksPrefKey, bookmarks);

            setState(() {
              isBookmarked = true;
            });
          }
        },
      ),
    );
  }
}
