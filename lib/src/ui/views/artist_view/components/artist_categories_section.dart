import 'package:canton_design_system/canton_design_system.dart';
import 'package:sap/src/models/artist.dart';
import 'package:sap/src/ui/views/artist_view/all_albums_and_singles_view.dart';
import 'package:sap/src/ui/views/artist_view/most_popular_songs_view.dart';

class ArtistCategoriesSection extends StatelessWidget {
  const ArtistCategoriesSection(this.artist);

  final Artist artist;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _mostPopularSongsCard(context),
        const Divider(),
        _allAlbumsAndSinglesCard(context),
      ],
    );
  }

  Widget _mostPopularSongsCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CantonMethods.viewTransition(context, MostPopularSongsView(artist));
      },
      child: Container(
        child: Card(
          shape: SmoothRectangleBorder(
            borderRadius: SmoothBorderRadius.vertical(
              top: SmoothRadius(
                cornerRadius: 15,
                cornerSmoothing: 1,
              ),
            ),
          ),
          color: Theme.of(context).colorScheme.onSecondary,
          child: Container(
            padding: const EdgeInsets.all(17),
            child: Row(
              children: [
                Text(
                  'Most Popular Songs',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Spacer(),
                IconlyIcon(
                  IconlyBold.ArrowRight2,
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _allAlbumsAndSinglesCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CantonMethods.viewTransition(context, AllAlbumsAndSinglesView(artist));
      },
      child: Container(
        child: Card(
          shape: SmoothRectangleBorder(
            borderRadius: SmoothBorderRadius.vertical(
              bottom: SmoothRadius(
                cornerRadius: 15,
                cornerSmoothing: 1,
              ),
            ),
          ),
          color: Theme.of(context).colorScheme.onSecondary,
          child: Container(
            padding: const EdgeInsets.all(17),
            child: Row(
              children: [
                Text(
                  'All Albums & Singles',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Spacer(),
                IconlyIcon(
                  IconlyBold.ArrowRight2,
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
