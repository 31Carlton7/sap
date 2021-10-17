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
