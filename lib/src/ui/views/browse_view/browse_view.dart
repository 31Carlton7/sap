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
import 'package:just_audio/just_audio.dart';
import 'package:sap/src/config/constants.dart';
import 'package:sap/src/ui/views/browse_view/components/browse_view_header.dart';
import 'package:sap/src/ui/views/browse_view/components/featured_playlists_list.dart';
import 'package:sap/src/ui/views/browse_view/components/top_albums_list.dart';
import 'package:sap/src/ui/views/browse_view/components/top_songs_list.dart';

class BrowseView extends StatefulWidget {
  @override
  _BrowseViewState createState() => _BrowseViewState();
}

class _BrowseViewState extends State<BrowseView> {
  final audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Container(padding: const EdgeInsets.symmetric(horizontal: 17), child: _content(context));
  }

  Widget _content(BuildContext context) {
    return CustomScrollView(
      slivers: [
        BrowseViewHeader(),

        // Top Albums List
        SliverToBoxAdapter(
          child: Container(
            height: 30,
            child: Text(
              'Top Albums',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
        ),
        TopAlbumsList(),

        // Top Playlists List
        SliverToBoxAdapter(
          child: Container(
            height: 30,
            child: Text(
              'Featured Playlists',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
        ),
        FeaturedPlaylistsList(),

        // Top Songs List
        SliverToBoxAdapter(
          child: Container(
            height: 30,
            child: Text(
              'Top Songs',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
        ),
        TopSongsList(),

        // Extra Space
        SliverToBoxAdapter(child: const SizedBox(height: kExtraSpace)),
      ],
    );
  }
}
