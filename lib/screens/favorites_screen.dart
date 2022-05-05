import 'package:fan_posters/models/favorites_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FavoritesModel _favoritesModelListener =
        Provider.of<FavoritesModel>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
        ),
        itemCount: _favoritesModelListener.get().length,
        itemBuilder: (context, index) {
          return _favoritesModelListener.get()[index];
        },
      ),
    );
  }
}
