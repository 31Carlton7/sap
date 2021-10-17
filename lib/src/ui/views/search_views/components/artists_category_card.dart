import 'package:canton_design_system/canton_design_system.dart';
import 'package:flutter/cupertino.dart';
import 'package:sap/src/ui/views/search_views/search_artists_view.dart';

class ArtistsCatgeoryCard extends StatelessWidget {
  const ArtistsCatgeoryCard();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CantonMethods.viewTransition(context, SearchArtistsView());
      },
      child: Card(
        shape: SmoothRectangleBorder(
          borderRadius: SmoothBorderRadius.vertical(
            bottom: SmoothRadius(
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
                CupertinoIcons.mic_fill,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 7),
              Text(
                'Artists',
                style: Theme.of(context).textTheme.headline5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
