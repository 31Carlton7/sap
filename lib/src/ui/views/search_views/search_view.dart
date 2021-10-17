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
