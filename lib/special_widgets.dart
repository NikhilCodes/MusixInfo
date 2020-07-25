import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musixinfo/pages/music_info_page.dart';

class MusicInfoTile extends StatelessWidget {
  MusicInfoTile({Key key, this.trackData}) : super(key: key);

  final trackData;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: key,
      title: Text(
        trackData['track_name'],
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      subtitle: Text(
        trackData['album_name'],
        style: TextStyle(
          color: Colors.grey,
        ),
      ),
      leading: Icon(
        Icons.library_music,
        color: Colors.white70,
      ),
      trailing: SizedBox(
        width: MediaQuery.of(context).size.width * 0.18,
        child: Text(
          trackData['artist_name'],
          style: TextStyle(
            color: Colors.white,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
        ),
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MusicInfoPage(
              key: ValueKey(key),
              trackId: trackData["track_id"],
            ),
          ),
        );
      },
    );
  }
}
