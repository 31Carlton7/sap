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
import 'package:sap/src/ui/views/artist_view/artist_view.dart';

class ArtistCard extends StatelessWidget {
  const ArtistCard(this.artist);

  final Artist artist;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CantonMethods.viewTransition(context, ArtistView(artist));
      },
      child: Container(
        child: Card(
          shape: const SquircleBorder(radius: BorderRadius.zero),
          color: CantonColors.transparent,
          child: Container(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  foregroundImage: NetworkImage(
                    artist.pictureUrl!,
                    scale: 50,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  _artistNameText(artist.name!),
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _artistNameText(String source) {
    if (source.length > 28) {
      return source.substring(0, 25) + '...';
    }
    return source;
  }
}
