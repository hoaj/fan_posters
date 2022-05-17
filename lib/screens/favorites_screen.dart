import 'package:fan_posters/models/favorites_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
        ),
        itemCount: context.select((FavoritesModel fm) => fm.get().length),
        itemBuilder: (context, index) {
          return context.watch<FavoritesModel>().get()[index];
        },
      ),
    );
  }
}
