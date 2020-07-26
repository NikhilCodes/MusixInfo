import 'package:flutter/material.dart';
import 'package:musixinfo/constants.dart';
import 'package:musixinfo/pages/music_info_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarkPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BookmarkPageState();
  }
}

class _BookmarkPageState extends State<BookmarkPage> {
  List idNameBookmarkList;

  loadSharedPref() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    setState(() {
      idNameBookmarkList = _preferences.getStringList(bookmarksPrefKey);
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
          final idNameList = idNameBookmarkList[index].split(idNameSeparator);
          final id = idNameList[0];
          final trackName = idNameList[1];
          return ListTile(
            title: Text(
              trackName,
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MusicInfoPage(
                    trackId: id,
                    key: ValueKey(id),
                  ),
                ),
              );
            },
          );
        },
        separatorBuilder: (context, index) => Divider(
          color: idNameBookmarkList != null ? Colors.grey : Colors.transparent,
        ),
        itemCount: idNameBookmarkList != null ? idNameBookmarkList.length : 0,
      ),
    );
  }
}
