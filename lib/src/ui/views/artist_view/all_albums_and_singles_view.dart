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
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sap/src/config/constants.dart';
import 'package:sap/src/config/exceptions.dart';
import 'package:sap/src/models/album.dart';
import 'package:sap/src/models/artist.dart';
import 'package:sap/src/providers/artist_all_albums_future_provider.dart';
import 'package:sap/src/ui/components/album_card.dart';
import 'package:sap/src/ui/components/error_body.dart';
import 'package:sap/src/ui/components/unexpected_error.dart';
import 'package:sap/src/ui/views/artist_view/components/all_albums_and_singles_view_header.dart';

class AllAlbumsAndSinglesView extends StatefulWidget {
  const AllAlbumsAndSinglesView(this.artist);

  final Artist artist;

  @override
  _AllAlbumsAndSinglesViewState createState() => _AllAlbumsAndSinglesViewState();
}

class _AllAlbumsAndSinglesViewState extends State<AllAlbumsAndSinglesView> {
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
        artistAllAlbumsId = widget.artist.id!;
        var allAlbumsRepo = watch(artistAllAlbumsFutureProvider);

        return allAlbumsRepo.when(
          error: (e, s) {
            if (e is Exceptions) {
              return ErrorBody(e.message, artistAllAlbumsFutureProvider);
            }
            return UnexpectedError(artistAllAlbumsFutureProvider);
          },
          loading: () {
            return CustomScrollView(
              physics: NeverScrollableScrollPhysics(),
              slivers: [
                AllAlbumsAndSinglesViewHeader(),
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
                AllAlbumsAndSinglesViewHeader(),
                _body(context, songs),
                SliverToBoxAdapter(child: const SizedBox(height: kExtraSpace)),
              ],
            );
          },
        );
      },
    );
  }

  Widget _body(BuildContext context, List<Album> albums) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return AlbumCard(
            albums[index],
            artist: widget.artist,
          );
        },
        childCount: albums.length,
      ),
    );
  }
}
