import 'package:canton_design_system/canton_design_system.dart';
import 'package:sap/src/models/song.dart';
import 'package:sap/src/providers/music_service_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sap/src/ui/components/song_card.dart';
import 'package:sap/src/ui/views/search_views/components/search_songs_view_header.dart';
import 'package:sap/src/ui/views/search_views/components/songs_search_bar.dart';

class SearchSongsView extends StatefulWidget {
  const SearchSongsView();

  @override
  _SearchSongsViewState createState() => _SearchSongsViewState();
}

class _SearchSongsViewState extends State<SearchSongsView> {
  late List<Song> songs;
  var _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    songs = [];
  }

  @override
  Widget build(BuildContext context) {
    return CantonScaffold(
      backgroundColor: CantonMethods.alternateCanvasColor(context),
      resizeToAvoidBottomInset: true,
      body: _content(context),
    );
  }

  Widget _content(BuildContext context) {
    return Column(
      children: [
        SearchSongsViewHeader(),
        const SizedBox(height: 10),
        SongsSearchBar(_searchController, _searchAlbums),
        const SizedBox(height: 15),
        _body(context),
      ],
    );
  }

  Widget _body(BuildContext context) {
    if (_searchController.text.isEmpty && songs.length == 0) {
      return Center(
        child: Text(
          'Start Searching!',
          style: Theme.of(context).textTheme.headline4!.copyWith(
                color: Theme.of(context).colorScheme.secondaryVariant,
              ),
        ),
      );
    } else if (songs.length == 0) {
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
            itemCount: songs.length,
            itemBuilder: (context, index) {
              return SongCard(songs[index]);
            },
          ),
        ),
      );
    }
  }

  Future<void> _searchAlbums(String query) async {
    var newSongList = await context.read(musicServiceProvider).getSongs(path: query);

    setState(() {
      songs = newSongList;
    });
  }
}
