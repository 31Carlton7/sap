import 'package:canton_design_system/canton_design_system.dart';
import 'package:flutter/cupertino.dart';
import 'package:sap/src/ui/views/search_views/search_albums_view.dart';

class AlbumsCatgeoryCard extends StatelessWidget {
  const AlbumsCatgeoryCard();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CantonMethods.viewTransition(context, SearchAlbumsView());
      },
      child: Card(
        shape: SquircleBorder(radius: BorderRadius.zero),
        child: Container(
          padding: EdgeInsets.all(17),
          child: Row(
            children: [
              Icon(
                CupertinoIcons.music_albums_fill,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 7),
              Text(
                'Albums',
                style: Theme.of(context).textTheme.headline5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
