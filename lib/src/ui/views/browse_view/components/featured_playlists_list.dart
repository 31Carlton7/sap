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
import 'package:sap/src/config/exceptions.dart';
import 'package:sap/src/providers/top_playlists_future_provider.dart';
import 'package:sap/src/ui/components/error_body.dart';
import 'package:sap/src/ui/components/top_playlist_card.dart';
import 'package:sap/src/ui/components/unexpected_error.dart';

class FeaturedPlaylistsList extends StatelessWidget {
  const FeaturedPlaylistsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        return watch(topPlaylistsFutureProvider).when(
          error: (e, s) {
            if (e is Exceptions) {
              return SliverToBoxAdapter(child: ErrorBody(e.message, topPlaylistsFutureProvider));
            }
            return SliverToBoxAdapter(
              child: UnexpectedError(topPlaylistsFutureProvider),
            );
          },
          loading: () => SliverToBoxAdapter(child: Loading()),
          data: (playlists) {
            return SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (playlists[index].id == null) return Container();
                  return TopPlaylistCard(playlists[index]);
                },
                childCount: 4,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisExtent: 140,
                crossAxisSpacing: 5,
              ),
            );
          },
        );
      },
    );
  }
}
