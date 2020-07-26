import 'dart:convert';

import 'package:http/http.dart' as http;

Future getMusicRecommendationsList() async {
  final response = await http.get(
      "https://api.musixmatch.com/ws/1.1/chart.tracks.get?apikey=2d782bc7a52a41ba2fc1ef05b9cf40d7");
  if (response.statusCode == 200) {
    if (json.decode(response.body)["message"]["header"]["status_code"] != 200){
      print(json.decode(response.body)["message"]);
      return [];
    }
    return json.decode(response.body)["message"]["body"]["track_list"];
  } else {
    print("Unable to fetch json data");
    return null;
  }
}

Future getTrackDataByTrackId(id) async {
  final response = await http.get(
      "https://api.musixmatch.com/ws/1.1/track.get?track_id=$id&apikey=2d782bc7a52a41ba2fc1ef05b9cf40d7");
  if (response.statusCode == 200) {
    return json.decode(response.body)["message"]["body"]["track"];
  } else {
    print("Unable to fetch json data for a Track.");
    return null;
  }
}

Future getLyricsByTrackId(id) async {
  final response = await http.get(
      "https://api.musixmatch.com/ws/1.1/track.lyrics.get?track_id=$id&apikey=2d782bc7a52a41ba2fc1ef05b9cf40d7");
  if (response.statusCode == 200) {
    return json.decode(response.body)["message"]["body"]["lyrics"]["lyrics_body"];
  } else {
    print("Unable to fetch json data for lyrics.");
    return null;
  }
}