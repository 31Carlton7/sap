import 'package:canton_design_system/canton_design_system.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:sap/src/config/constants.dart';
import 'package:sap/src/models/playlist.dart';
import 'package:sap/src/models/song.dart';
import 'package:sap/src/services/music_service.dart';
import 'package:sap/src/ui/components/song_card.dart';
import 'package:sap/src/ui/views/playlist_view/components/playlist_info.dart';
import 'package:sap/src/ui/views/playlist_view/components/playlist_view_header.dart';

class PlaylistView extends StatefulWidget {
  const PlaylistView(this.id);

  final int? id;

  @override
  _PlaylistViewState createState() => _PlaylistViewState();
}

class _PlaylistViewState extends State<PlaylistView> {
  @override
  Widget build(BuildContext context) {
    return CantonScaffold(
      backgroundColor: CantonMethods.alternateCanvasColor(context),
      body: _content(context),
    );
  }

  Widget _content(BuildContext context) {
    return FutureBuilder(
      future: MusicService(Dio()).getPlaylist(widget.id),
      builder: (context, AsyncSnapshot<Playlist> playlist) {
        if (playlist.connectionState == ConnectionState.waiting) {
          return Loading();
        }

        return FutureBuilder(
          future: MusicService(Dio()).getSongsFromPlaylist(widget.id),
          builder: (context, AsyncSnapshot<List<Song>> tracks) {
            if (tracks.connectionState == ConnectionState.waiting || playlist.data == null) {
              return Loading();
            }

            return Column(
              children: [
                PlaylistViewHeader(playlist.data!, tracks.data, setState),
                Expanded(
                  child: ListView(
                    children: _body(context, playlist, tracks),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  List<Widget> _body(BuildContext context, AsyncSnapshot<Playlist> playlist, AsyncSnapshot<List<Song>> tracks) {
    List<Widget> list = [];

    list.add(PlaylistInfo(playlist.data!));
    list.add(const SizedBox(height: 20));

    for (var song in tracks.data!) {
      list.add(SongCard(song));
    }

    list.add(const SizedBox(height: kExtraSpace));

    return list;
  }
}
