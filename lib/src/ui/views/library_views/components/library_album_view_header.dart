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
import 'package:sap/src/ui/components/show_album_options_bottom_sheet.dart';

class LibraryAlbumViewHeader extends StatelessWidget {
  const LibraryAlbumViewHeader(this.album, this.setState, {this.setStateTwo});

  final Album album;
  final void Function(void Function()) setState;
  final void Function(void Function())? setStateTwo;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CantonBackButton(isClear: true),
        CantonHeaderButton(
          backgroundColor: CantonColors.transparent,
          icon: Container(
            height: 24,
            width: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
            child: Icon(
              FeatherIcons.moreHorizontal,
              color: Theme.of(context).primaryColor,
              size: 16,
            ),
          ),
          onPressed: () => showAlbumOptionsBottomSheet(context, setState, album, setStateTwo: setStateTwo),
        ),
      ],
    );
  }
}
