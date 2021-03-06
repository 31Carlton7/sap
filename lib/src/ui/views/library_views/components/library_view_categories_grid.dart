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
import 'package:flutter/cupertino.dart';
import 'package:sap/src/ui/views/library_views/all_albums_and_songs_view.dart';
import 'package:sap/src/ui/views/library_views/liked_songs_view.dart';

class LibraryViewCategories extends StatelessWidget {
  const LibraryViewCategories({this.setState});

  final void Function(void Function())? setState;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _likedSongsCard(context),
        const Divider(),
        _allAlbumsAndSongsCard(context),
      ],
    );
  }

  Widget _likedSongsCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CantonMethods.viewTransition(context, LikedSongsView());
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
          child: Container(
            padding: const EdgeInsets.all(15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(CupertinoIcons.heart_fill, color: Theme.of(context).primaryColor, size: 20),
                const SizedBox(width: 10),
                Text(
                  'Liked Songs',
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

  Widget _allAlbumsAndSongsCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CantonMethods.viewTransition(context, AllAlbumsAndSongsView(setState!));
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
          child: Container(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                Icon(CupertinoIcons.music_albums_fill, color: Theme.of(context).primaryColor, size: 20),
                const SizedBox(width: 10),
                Text(
                  'All Albums & Songs',
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
