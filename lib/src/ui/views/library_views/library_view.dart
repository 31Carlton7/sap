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
import 'package:sap/src/providers/music_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sap/src/ui/views/library_views/components/library_album_card.dart';
import 'package:sap/src/ui/views/library_views/components/library_view_categories_grid.dart';
import 'package:sap/src/ui/views/library_views/components/library_view_header.dart';

class LibraryView extends StatefulWidget {
  const LibraryView();

  @override
  _LibraryViewState createState() => _LibraryViewState();
}

class _LibraryViewState extends State<LibraryView> {
  @override
  Widget build(BuildContext context) {
    return Container(padding: const EdgeInsets.symmetric(horizontal: 17), child: _content(context));
  }

  Widget _content(BuildContext context) {
    return CustomScrollView(
      slivers: [
        LibraryViewHeader(),
        SliverToBoxAdapter(child: Divider()),
        SliverToBoxAdapter(child: const SizedBox(height: 10)),
        SliverToBoxAdapter(child: LibraryViewCategories(setState: setState)),
        SliverToBoxAdapter(child: const SizedBox(height: 10)),
        SliverToBoxAdapter(
          child: Text(
            'Recently Added',
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        SliverToBoxAdapter(child: const SizedBox(height: 10)),
        _body(context),
        SliverToBoxAdapter(child: const SizedBox(height: kExtraSpace)),
      ],
    );
  }

  Widget _body(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      var albums = watch(musicRepositoryProvider);

      return SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return LibraryAlbumCard(albums[index], setState: setState);
          },
          childCount: albums.length,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 235,
          crossAxisSpacing: 35,
        ),
      );
    });
  }
}
