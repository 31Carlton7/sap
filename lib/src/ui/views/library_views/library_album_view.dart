import 'package:canton_design_system/canton_design_system.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sap/src/config/constants.dart';
import 'package:sap/src/models/album.dart';
import 'package:sap/src/models/song.dart';
import 'package:sap/src/providers/music_repository_provider.dart';
import 'package:sap/src/ui/components/album_info.dart';
import 'package:sap/src/ui/components/album_song_card.dart';
import 'package:sap/src/ui/views/library_views/components/library_album_view_header.dart';

class LibraryAlbumView extends StatefulWidget {
  const LibraryAlbumView(this.id, {this.setState, this.setStateTwo});

  final int? id;
  final void Function(void Function())? setState;
  final void Function(void Function())? setStateTwo;

  @override
  _LibraryAlbumViewState createState() => _LibraryAlbumViewState();
}

class _LibraryAlbumViewState extends State<LibraryAlbumView> {
  @override
  Widget build(BuildContext context) {
    return CantonScaffold(
      backgroundColor: CantonMethods.alternateCanvasColor(context),
      body: _content(context),
    );
  }

  Widget _content(BuildContext context) {
    var album = context.read(musicRepositoryProvider).albums!.where((element) => element.id == widget.id).toList()[0];
    List<Song> song = album.tracks!.isEmpty
        ? context.read(musicRepositoryProvider).songs!.where((element) => element.id == widget.id).toList()
        : [Song()];

    var trackList = song[0].id == null ? album.tracks! : song;
    return Column(
      children: [
        LibraryAlbumViewHeader(
          album,
          widget.setState != null ? widget.setState! : setState,
          setStateTwo: widget.setStateTwo,
        ),
        Expanded(
          child: ListView(
            children: _body(context, album, trackList),
          ),
        ),
      ],
    );
  }

  List<Widget> _body(BuildContext context, Album album, List<Song> trackList) {
    List<Widget> list = [];

    trackList.sort((a, b) => a.trackPosition!.compareTo(b.trackPosition!));

    list.add(AlbumInfo(album));
    list.add(const SizedBox(height: 15));

    for (var song in trackList) {
      list.add(AlbumSongCard(
        song,
        setState: (widget.setState != null ? widget.setState! : setState),
      ));
    }

    list.add(const SizedBox(height: kExtraSpace));

    return list;
  }
}
