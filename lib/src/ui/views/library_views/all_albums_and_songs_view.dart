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
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sap/src/config/constants.dart';
import 'package:sap/src/models/album.dart';
import 'package:sap/src/providers/music_repository_provider.dart';
import 'package:sap/src/ui/views/library_views/components/library_album_card.dart';
import 'package:sap/src/ui/views/library_views/components/library_albums_search_bar.dart';
import 'package:sap/src/ui/views/library_views/components/all_albums_and_songs_view_header.dart';

class AllAlbumsAndSongsView extends StatefulWidget {
  const AllAlbumsAndSongsView(this.setStateTwo);

  final void Function(void Function()) setStateTwo;

  @override
  _AllAlbumsAndSongsViewState createState() => _AllAlbumsAndSongsViewState();
}

class _AllAlbumsAndSongsViewState extends State<AllAlbumsAndSongsView> {
  List<Album>? albums;
  var _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CantonScaffold(
      backgroundColor: CantonMethods.alternateCanvasColor(context),
      body: _content(context),
    );
  }

  Widget _content(BuildContext context) {
    return CustomScrollView(
      slivers: [
        AllAlbumsAndSongsViewHeader(),
        SliverToBoxAdapter(child: const SizedBox(height: 10)),
        LibraryAlbumsSearchBar(_searchController, _searchAlbums),
        SliverToBoxAdapter(child: const SizedBox(height: 15)),
        _body(context),
        SliverToBoxAdapter(child: const SizedBox(height: kExtraSpace)),
      ],
    );
  }

  Widget _body(BuildContext context) {
    var albums = context.read(musicRepositoryProvider).albums!;

    albums.sort((a, b) => a.title!.compareTo(b.title!));

    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return LibraryAlbumCard(
            albums[index],
            setState: setState,
            setStateTwo: widget.setStateTwo,
          );
        },
        childCount: albums.length,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 235,
        crossAxisSpacing: 35,
      ),
    );
  }

  void _searchAlbums(String query) {
    // final newAlbumList =
  }
}
