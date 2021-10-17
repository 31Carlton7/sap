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
import 'package:sap/src/models/artist.dart';
import 'package:sap/src/ui/views/album_view/album_view.dart';

class AlbumCard extends StatefulWidget {
  const AlbumCard(this.album, {this.artist});

  final Album album;
  final Artist? artist;

  @override
  _AlbumCardState createState() => _AlbumCardState();
}

class _AlbumCardState extends State<AlbumCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CantonMethods.viewTransition(context, AlbumView(widget.album.id!));
      },
      child: Card(
        shape: const SquircleBorder(radius: BorderRadius.zero),
        margin: const EdgeInsets.symmetric(vertical: 5),
        color: CantonColors.transparent,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            (widget.album.getAlbumCover != null)
                ? ClipSquircleBorder(
                    radius: BorderRadius.all(Radius.circular(10)),
                    child: Image.network(
                      widget.album.getAlbumCover!,
                      fit: BoxFit.cover,
                      height: 70,
                      width: 70,
                    ),
                  )
                : Container(
                    height: 70,
                    width: 70,
                    decoration: ShapeDecoration(
                      color: Theme.of(context).colorScheme.onSecondary,
                      shape: SquircleBorder(
                        radius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Iconsax.music,
                        color: Theme.of(context).colorScheme.secondaryVariant,
                      ),
                    ),
                  ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _shortenTitle(widget.album.title!),
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ],
                ),
                Text(
                  _shortenArtistsNames(widget.artist != null ? widget.artist!.name! : widget.album.artist!.name!),
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: Theme.of(context).colorScheme.secondaryVariant,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _shortenTitle(String string) {
    if (string.length >= 30) {
      string = string.substring(0, 24) + '...';
    }

    return string;
  }

  String _shortenArtistsNames(String string) {
    if (string.length >= 30) {
      string = string.substring(0, 30) + '...';
    }

    return string;
  }
}
