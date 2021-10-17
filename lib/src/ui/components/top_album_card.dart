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
import 'package:sap/src/models/album.dart';
import 'package:sap/src/ui/views/album_view/album_view.dart';

class TopAlbumCard extends StatelessWidget {
  const TopAlbumCard(this.album);

  @required
  final Album album;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CantonMethods.viewTransition(context, AlbumView(album.id!));
      },
      child: Card(
        shape: const SquircleBorder(radius: BorderRadius.zero),
        color: CantonColors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipSquircleBorder(
              radius: BorderRadius.all(Radius.circular(10)),
              child: Image.network(
                album.getAlbumCover!,
                fit: BoxFit.cover,
                height: 85,
                width: 85,
              ),
            ),
            Text(
              _shortenTitle(album.title)!,
              maxLines: 2,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
    );
  }

  String? _shortenTitle(String? string) {
    if (album.explicit! && string!.length >= 20) {
      string = string.substring(0, 16) + '...';
    } else if (string!.length >= 19) {
      string = string.substring(0, 17) + '...';
    }

    return string;
  }
}
