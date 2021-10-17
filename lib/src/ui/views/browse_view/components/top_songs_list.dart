import 'package:canton_design_system/canton_design_system.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sap/src/config/exceptions.dart';
import 'package:sap/src/providers/top_songs_future_provider.dart';
import 'package:sap/src/ui/components/error_body.dart';
import 'package:sap/src/ui/components/song_card.dart';
import 'package:sap/src/ui/components/unexpected_error.dart';

class TopSongsList extends StatelessWidget {
  const TopSongsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        return watch(topSongsFutureProvider).when(
          error: (e, s) {
            if (e is Exceptions) {
              return SliverToBoxAdapter(child: ErrorBody(e.message, topSongsFutureProvider));
            }
            return SliverToBoxAdapter(
              child: UnexpectedError(topSongsFutureProvider),
            );
          },
          loading: () => SliverToBoxAdapter(child: Loading()),
          data: (songs) {
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return SongCard(songs[index]);
                },
                childCount: 10,
              ),
            );
          },
        );
      },
    );
  }
}
