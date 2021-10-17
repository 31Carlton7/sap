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
