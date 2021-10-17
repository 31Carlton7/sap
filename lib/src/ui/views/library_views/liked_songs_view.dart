import 'package:canton_design_system/canton_design_system.dart';
import 'package:flutter/cupertino.dart';
import 'package:sap/src/config/constants.dart';
import 'package:sap/src/models/song.dart';
import 'package:sap/src/providers/music_repository_provider.dart';
import 'package:sap/src/ui/components/song_card.dart';
import 'package:sap/src/ui/views/library_views/components/liked_songs_info.dart';
import 'package:sap/src/ui/views/library_views/components/liked_songs_view_header.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LikedSongsView extends StatefulWidget {
  const LikedSongsView();

  @override
  _LikedSongsViewState createState() => _LikedSongsViewState();
}

class _LikedSongsViewState extends State<LikedSongsView> {
  @override
  Widget build(BuildContext context) {
    return CantonScaffold(
      backgroundColor: CantonMethods.alternateCanvasColor(context),
      body: _content(context),
    );
  }

  Widget _content(BuildContext context) {
    var albums = context.read(musicRepositoryProvider).albums!;
    List<Song> likedSongs = [];

    for (var album in albums) {
      for (var song in album.tracks!) {
        if (context.read(musicRepositoryProvider.notifier).songIsAlreadyLiked(song)) {
          likedSongs.add(song.copyWith(album: album));
        }
      }
    }

    return CustomScrollView(
      slivers: [
        LikedSongsViewHeader(),
        _body(context, likedSongs),
        SliverToBoxAdapter(child: const SizedBox(height: kExtraSpace)),
      ],
    );
  }

  Widget _body(BuildContext context, List<Song> songs) {
    songs = songs.reversed.toList();
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index == 0) return LikedSongsInfoCard();
          if (songs.isNotEmpty) {
            if (index == 1) return const SizedBox(height: 20);

            return SongCard(
              songs[index - 2],
              setState: setState,
            );
          }

          return Center(
            heightFactor: 15,
            child: Text(
              'No liked Songs :(',
              style: Theme.of(context).textTheme.headline5?.copyWith(
                    color: Theme.of(context).colorScheme.secondaryVariant,
                  ),
            ),
          );
        },
        childCount: songs.isNotEmpty ? songs.length + 2 : 2,
      ),
    );
  }
}
