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
import 'package:sap/src/ui/views/artist_view/components/artist_categories_section.dart';
import 'package:sap/src/ui/views/artist_view/components/artist_info_card.dart';
import 'package:sap/src/ui/views/artist_view/components/artist_view_header.dart';

class ArtistView extends StatefulWidget {
  const ArtistView(this.artist);

  final Artist artist;

  @override
  _ArtistViewState createState() => _ArtistViewState();
}

class _ArtistViewState extends State<ArtistView> {
  @override
  Widget build(BuildContext context) {
    return CantonScaffold(
      backgroundColor: CantonMethods.alternateCanvasColor(context),
      body: _content(context),
    );
  }

  Widget _content(BuildContext context) {
    return Column(
      children: [
        ArtistViewHeader(),
        _artistInfo(context),
        const SizedBox(height: 20),
        ArtistInfoCard(widget.artist),
        const SizedBox(height: 20),
        ArtistCategoriesSection(widget.artist),
      ],
    );
  }

  Widget _artistInfo(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 75,
          foregroundImage: NetworkImage(
            widget.artist.pictureUrl!,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          _artistNameText(widget.artist.name!),
          style: Theme.of(context).textTheme.headline3,
        ),
      ],
    );
  }

  String _artistNameText(String source) {
    if (source.length > 21) {
      return source.substring(0, 19) + '...';
    }
    return source;
  }
}
