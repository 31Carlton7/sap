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

class AlbumInfo extends StatelessWidget {
  const AlbumInfo(this.album);

  final Album album;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.center,
          child: (album.getAlbumCover != null)
              ? ClipSquircleBorder(
                  radius: BorderRadius.all(Radius.circular(30)),
                  child: Image.network(
                    album.getAlbumCover!,
                    fit: BoxFit.cover,
                    height: 250,
                    width: 250,
                  ),
                )
              : Container(
                  height: 250,
                  width: 250,
                  decoration: ShapeDecoration(
                    color: Theme.of(context).colorScheme.onSecondary,
                    shape: SquircleBorder(
                      radius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Iconsax.music,
                      size: 75,
                      color: Theme.of(context).colorScheme.secondaryVariant,
                    ),
                  ),
                ),
        ),
        const SizedBox(height: 15),
        Text(
          album.releaseDate!.substring(0, 4),
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Theme.of(context).colorScheme.secondaryVariant,
              ),
        ),
        const SizedBox(height: 7),
        Align(
          alignment: Alignment.center,
          child: Text(
            album.title!,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        const SizedBox(height: 7),
        Text(
          album.artist!.name!,
          style: Theme.of(context).textTheme.headline6!.copyWith(
                color: Theme.of(context).colorScheme.secondaryVariant,
              ),
        ),
      ],
    );
  }
}
