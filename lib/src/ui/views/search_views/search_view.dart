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
import 'package:sap/src/ui/views/search_views/components/albums_category_card.dart';
import 'package:sap/src/ui/views/search_views/components/artists_category_card.dart';
import 'package:sap/src/ui/views/search_views/components/songs_category_card.dart';

class SearchView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(padding: const EdgeInsets.symmetric(horizontal: 17), child: _content(context));
  }

  Widget _content(BuildContext context) {
    return Column(
      children: [
        _header(context),
        const SizedBox(height: 10),
        _body(context),
      ],
    );
  }

  Widget _header(BuildContext context) {
    return ViewHeaderOne(title: 'Search');
  }

  Widget _body(BuildContext context) {
    return Expanded(
      child: _categoriesSection(context),
    );
  }

  Widget _categoriesSection(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SongsCatgeoryCard(),
          Divider(),
          AlbumsCatgeoryCard(),
          Divider(),
          ArtistsCatgeoryCard(),
        ],
      ),
    );
  }
}
