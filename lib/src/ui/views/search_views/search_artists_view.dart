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
import 'package:sap/src/providers/music_service_provider.dart';
import 'package:sap/src/ui/components/artist_card.dart';
import 'package:sap/src/ui/views/search_views/components/artists_search_bar.dart';
import 'package:sap/src/ui/views/search_views/components/search_artists_view_header.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchArtistsView extends StatefulWidget {
  const SearchArtistsView();

  @override
  _SearchArtistsViewState createState() => _SearchArtistsViewState();
}

class _SearchArtistsViewState extends State<SearchArtistsView> {
  late List<Artist> artists;
  var _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    artists = [];
  }

  @override
  Widget build(BuildContext context) {
    return CantonScaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: CantonMethods.alternateCanvasColor(context),
      body: _content(context),
    );
  }

  Widget _content(BuildContext context) {
    return Column(
      children: [
        SearchArtistsViewHeader(),
        const SizedBox(height: 10),
        ArtistsSearchBar(_searchController, _searchArtists),
        const SizedBox(height: 15),
        _body(context),
      ],
    );
  }

  Widget _body(BuildContext context) {
    if (_searchController.text.isEmpty && artists.length == 0) {
      return Center(
        child: Text(
          'Start Searching!',
          style: Theme.of(context).textTheme.headline4!.copyWith(
                color: Theme.of(context).colorScheme.secondaryVariant,
              ),
        ),
      );
    } else if (artists.length == 0) {
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
            itemBuilder: (context, index) {
              return ArtistCard(artists[index]);
            },
          ),
        ),
      );
    }
  }

  Future<void> _searchArtists(String query) async {
    var newArtistList = await context.read(musicServiceProvider).getArtists(path: query);

    setState(() {
      artists = newArtistList;
    });
  }
}
