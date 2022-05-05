import 'package:fan_posters/common/poster.dart';
import 'package:flutter/material.dart';

class FavoritesModel extends ChangeNotifier {
  final List<Poster> _favoritePosters = [];

  void markOrUnmarkFavorite(Poster poster) {
    if (_favoritePosters.contains(poster)) {
      _favoritePosters.remove(poster);
    } else {
      _favoritePosters.add(poster);
    }
    notifyListeners();
  }

  List<Poster> get() {
    return _favoritePosters;
  }
}
