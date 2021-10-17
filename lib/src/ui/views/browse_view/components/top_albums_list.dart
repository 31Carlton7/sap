import 'package:canton_design_system/canton_design_system.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sap/src/config/exceptions.dart';
import 'package:sap/src/providers/top_albums_future_provider.dart';
import 'package:sap/src/ui/components/error_body.dart';
import 'package:sap/src/ui/components/top_album_card.dart';
import 'package:sap/src/ui/components/unexpected_error.dart';

class TopAlbumsList extends StatelessWidget {
  const TopAlbumsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        return watch(topAlbumsFutureProvider).when(
          error: (e, s) {
            if (e is Exceptions) {
              return SliverToBoxAdapter(child: ErrorBody(e.message, topAlbumsFutureProvider));
            }
            return SliverToBoxAdapter(
              child: UnexpectedError(topAlbumsFutureProvider),
            );
          },
          loading: () => SliverToBoxAdapter(child: Loading()),
          data: (albums) {
            return SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return TopAlbumCard(albums[index]);
                },
                childCount: 8,
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
