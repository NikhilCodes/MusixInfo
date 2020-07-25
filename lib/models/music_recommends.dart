import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:musixinfo/helper_functions.dart';

// BLoC model for recommended musics
class RecommendedMusicList {
  StreamSubscription subscription;

  final _controller = StreamController();

  Stream get output => _controller.stream;

  Sink get input => _controller.sink;

  // For sending initial value (Empty List)
  RecommendedMusicList() {
    subscription = Connectivity().onConnectivityChanged.listen((status)async {
      if (status == ConnectivityResult.mobile ||
          status == ConnectivityResult.wifi) {
        input.add(true);  // This will tell the StreamBuilder to display a CircularProgressIndicator.
        input.add(await getMusicRecommendationsList());
      } else {
        input.add(null);
      }
    });
  }

  void dispose() {
    _controller.close();
    subscription.cancel();
  }
}
