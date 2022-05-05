import 'package:fan_posters/models/posters_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fan_posters/models/favorites_model.dart';

class PostersScreen extends StatelessWidget {
  const PostersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PostersModel _postersModelListener =
        Provider.of<PostersModel>(context, listen: true);
    final FavoritesModel _favoritesModelListener =
        Provider.of<FavoritesModel>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fan Posters'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/favorites");
            },
            icon: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                const Icon(Icons.favorite),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(_favoritesModelListener.get().length.toString()),
                )
              ],
            ),
          ),
          IconButton(
            onPressed: () async {
              await _postersModelListener.updatePostersURL();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
        ),
        itemCount: _postersModelListener.get().length,
        itemBuilder: (context, index) {
          return _postersModelListener.get()[index];
        },
      ),
    );
  }
}
