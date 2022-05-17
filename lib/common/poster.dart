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
    return TextButton(
      onPressed: () {
        context.read<FavoritesModel>().markOrUnmarkFavorite(this);
      },
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Image.network(
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
          Visibility(
            visible: context.select((FavoritesModel fm) =>
                fm.get().contains(this)), // Only updates on the this poster.
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
      ),
    );
  }
}
