import 'package:flutter/material.dart';
import 'package:fan_posters/models/favorites_model.dart';
import 'package:provider/provider.dart';

class Poster extends StatelessWidget {
  final String url;
  final String filename;
  const Poster({Key? key, required this.url, required this.filename})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FavoritesModel _favoritesModelListener =
        Provider.of<FavoritesModel>(context, listen: true);
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        TextButton(
          onPressed: () {
            _favoritesModelListener.markOrUnmarkFavorite(this);
          },
          child: Image.network(
            url,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              } else {
                return CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null);
              }
            },
          ),
        ),
        Visibility(
          visible: _favoritesModelListener.get().contains(this),
          child: const Align(
            alignment: Alignment.bottomRight,
            child: Icon(
              Icons.favorite,
              color: Colors.red,
              size: 40.0,
            ),
          ),
        ),
      ],
    );
  }
}
