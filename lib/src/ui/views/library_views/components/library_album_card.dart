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
import 'package:sap/src/ui/views/library_views/library_album_view.dart';

class LibraryAlbumCard extends StatelessWidget {
  const LibraryAlbumCard(this.album, {this.setState, this.setStateTwo});

  final Album album;
  final void Function(void Function())? setState;
  final void Function(void Function())? setStateTwo;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CantonMethods.viewTransition(
            context,
            LibraryAlbumView(
              album.id,
              setState: setState,
              setStateTwo: setStateTwo,
            ));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipSquircleBorder(
            radius: BorderRadius.all(Radius.circular(14)),
            child: Image.network(
              album.getAlbumCover!,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            _shortenTitle(album.title)!,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            _shortenTitle(album.artist!.name)!,
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: Theme.of(context).colorScheme.secondaryVariant,
                ),
          ),
        ],
      ),
    );
  }

  String? _shortenTitle(String? string) {
    if (![null, false].contains(album.explicit) && string!.length >= 28) {
      string = string.substring(0, 18) + '...';
    } else if (string!.length >= 23) {
      string = string.substring(0, 21) + '...';
    }

    return string;
  }
}
