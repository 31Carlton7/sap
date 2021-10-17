/*
Sap
Copyright (C) 2021  Carlton Aikins

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

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
                Icon(
                  Iconsax.arrow_right_2,
                  color: Theme.of(context).colorScheme.secondaryVariant,
                  size: 20,
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
                Icon(
                  Iconsax.arrow_right_2,
                  color: Theme.of(context).colorScheme.secondaryVariant,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
