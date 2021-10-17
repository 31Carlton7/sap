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
import 'package:sap/src/config/constants.dart';
import 'package:sap/src/config/exceptions.dart';
import 'package:sap/src/models/artist.dart';
import 'package:sap/src/models/song.dart';
import 'package:sap/src/providers/artist_most_popular_songs_future_provider.dart';
import 'package:sap/src/ui/components/error_body.dart';
import 'package:sap/src/ui/components/song_card.dart';
import 'package:sap/src/ui/components/unexpected_error.dart';
import 'package:sap/src/ui/views/artist_view/components/most_popular_songs_view_header.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MostPopularSongsView extends StatefulWidget {
  const MostPopularSongsView(this.artist);

  final Artist artist;

  @override
  _MostPopularSongsViewState createState() => _MostPopularSongsViewState();
}

class _MostPopularSongsViewState extends State<MostPopularSongsView> {
  @override
  Widget build(BuildContext context) {
    return CantonScaffold(
      backgroundColor: CantonMethods.alternateCanvasColor(context),
      body: _content(context),
    );
  }

  Widget _content(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        artistMostPopularSongsPath = widget.artist.name!;
        var mostPopularSongsRepo = watch(artistMostPopularSongsFutureProvider);

        return mostPopularSongsRepo.when(
          error: (e, s) {
            if (e is Exceptions) {
              return ErrorBody(e.message, artistMostPopularSongsFutureProvider);
            }
            return UnexpectedError(artistMostPopularSongsFutureProvider);
          },
          loading: () {
            return CustomScrollView(
              physics: NeverScrollableScrollPhysics(),
              slivers: [
                MostPopularSongsViewHeader(),
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.only(top: 250),
                    child: Loading(),
                  ),
                ),
              ],
            );
          },
          data: (songs) {
            return CustomScrollView(
              slivers: [
                MostPopularSongsViewHeader(),
                _body(context, songs),
                SliverToBoxAdapter(child: const SizedBox(height: kExtraSpace)),
              ],
            );
          },
        );
      },
    );
  }

  Widget _body(BuildContext context, List<Song> songs) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return SongCard(songs[index]);
        },
        childCount: songs.length,
      ),
    );
  }
}
