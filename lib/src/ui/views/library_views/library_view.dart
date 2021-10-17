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
    var albums = context.read(musicRepositoryProvider).albums!;

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
  }
}
