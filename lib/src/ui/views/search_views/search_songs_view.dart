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
import 'package:sap/src/models/song.dart';
import 'package:sap/src/providers/music_service_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sap/src/ui/components/song_card.dart';
import 'package:sap/src/ui/views/search_views/components/search_songs_view_header.dart';
import 'package:sap/src/ui/views/search_views/components/songs_search_bar.dart';

class SearchSongsView extends StatefulWidget {
  const SearchSongsView();

  @override
  _SearchSongsViewState createState() => _SearchSongsViewState();
}

class _SearchSongsViewState extends State<SearchSongsView> {
  late List<Song> songs;
  var _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    songs = [];
  }

  @override
  Widget build(BuildContext context) {
    return CantonScaffold(
      backgroundColor: CantonMethods.alternateCanvasColor(context),
      resizeToAvoidBottomInset: true,
      body: _content(context),
    );
  }

  Widget _content(BuildContext context) {
    return Column(
      children: [
        SearchSongsViewHeader(),
        const SizedBox(height: 10),
        SongsSearchBar(_searchController, _searchAlbums),
        const SizedBox(height: 15),
        _body(context),
      ],
    );
  }

  Widget _body(BuildContext context) {
    if (_searchController.text.isEmpty && songs.length == 0) {
      return Center(
        child: Text(
          'Start Searching!',
          style: Theme.of(context).textTheme.headline4!.copyWith(
                color: Theme.of(context).colorScheme.secondaryVariant,
              ),
        ),
      );
    } else if (songs.length == 0) {
      return Center(
        child: Text(
          'No results :(',
          style: Theme.of(context).textTheme.headline4!.copyWith(
                color: Theme.of(context).colorScheme.secondaryVariant,
              ),
        ),
      );
    } else {
      return Expanded(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onPanDown: (_) {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: ListView.builder(
            itemCount: songs.length,
            itemBuilder: (context, index) {
              return SongCard(songs[index]);
            },
          ),
        ),
      );
    }
  }

  Future<void> _searchAlbums(String query) async {
    var newSongList = await context.read(musicServiceProvider).getSongs(path: query);

    setState(() {
      songs = newSongList;
    });
  }
}
