import 'package:canton_design_system/canton_design_system.dart';
import 'package:flutter/cupertino.dart';
import 'package:sap/src/ui/views/search_views/search_songs_view.dart';

class SongsCatgeoryCard extends StatelessWidget {
  const SongsCatgeoryCard();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CantonMethods.viewTransition(context, SearchSongsView());
      },
      child: Card(
        shape: SmoothRectangleBorder(
          borderRadius: SmoothBorderRadius.vertical(
            top: SmoothRadius(
              cornerRadius: 15,
              cornerSmoothing: 1,
            ),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(17),
          child: Row(
            children: [
              Icon(
                CupertinoIcons.music_note,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 7),
              Text(
                'Songs',
                style: Theme.of(context).textTheme.headline5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
