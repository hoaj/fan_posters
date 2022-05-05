import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fan_posters/common/poster.dart';

class PostersModel extends ChangeNotifier {
  static final List<Poster> _posters = [];
  static final FirebaseStorage _storage = FirebaseStorage.instance;

  List<Poster> get() => _posters;

  Future<bool> firstLaunch() async {
    await Firebase.initializeApp();
    await updatePostersURL();
    return true;
  }

  Future<bool> updatePostersURL() async {
    try {
      final ListResult postersOnFirebase =
          await _storage.ref("posters/").listAll();

      // Remove posters on device if poster is not on database.
      for (Poster poster in _posters) {
        if (postersOnFirebase.items.any(
            (posterOnFirebase) => posterOnFirebase.name == poster.filename)) {
          // if any matches with Firebase, then do nothing
        } else {
          _posters.remove(poster);
        }
      }

      // get new poster, except if they already exist on device
      for (Reference posterOnFirebase in postersOnFirebase.items) {
        if (_posters.any(
            (storedPoster) => storedPoster.filename == posterOnFirebase.name)) {
          // do nothing if any poster from Firebase is already stored
        } else {
          _posters.add(
            Poster(
              filename: posterOnFirebase.name,
              url: await posterOnFirebase.getDownloadURL(),
            ),
          );
        }
      }
    } catch (err) {
      return true; //Unhandled error
    }
    notifyListeners();
    return true;
  }
}
