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
