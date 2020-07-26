import 'package:flutter/material.dart';
import 'package:musixinfo/constants.dart';
import 'package:musixinfo/helper_functions.dart';
import 'package:musixinfo/pages/music_info_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarkPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BookmarkPageState();
  }
}

class _BookmarkPageState extends State<BookmarkPage> {
  List idBookmarkList;

  loadSharedPref() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    setState(() {
      idBookmarkList = _preferences.getStringList(bookmarksPrefKey);
    });
  }

  @override
  void initState() {
    loadSharedPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(40, 40, 40, 1),
        title: Text("Bookmarks"),
      ),
      backgroundColor: Colors.black,
      body: ListView.separated(
        itemBuilder: (context, index) {
          return FutureBuilder(
            future: getTrackDataByTrackId(idBookmarkList[index]),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: Container(
                    height: 20,
                    width: 20,
                    padding: EdgeInsets.all(5),
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return ListTile(
                title: Text(
                  snapshot.data["track_name"],
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MusicInfoPage(
                        trackId: idBookmarkList[index],
                        key: ValueKey(idBookmarkList[index]),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
        separatorBuilder: (context, index) => Divider(
          color: idBookmarkList != null ? Colors.grey : Colors.transparent,
        ),
        itemCount: idBookmarkList != null ? idBookmarkList.length : 0,
      ),
    );
  }
}
