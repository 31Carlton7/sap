/*
Sap
Copyright (C) 2021  Carlton Aikins

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

import 'package:canton_design_system/canton_design_system.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:sap/src/config/constants.dart';
import 'package:sap/src/models/album.dart';
import 'package:sap/src/models/song.dart';
import 'package:sap/src/services/music_service.dart';
import 'package:sap/src/ui/components/album_song_card.dart';
import 'package:sap/src/ui/components/album_info.dart';
import 'package:sap/src/ui/views/album_view/components/album_view_header.dart';

class AlbumView extends StatefulWidget {
  const AlbumView(this.id);

  final int id;

  @override
  _AlbumViewState createState() => _AlbumViewState();
}

class _AlbumViewState extends State<AlbumView> {
  @override
  Widget build(BuildContext context) {
    return CantonScaffold(
      backgroundColor: CantonMethods.alternateCanvasColor(context),
      body: _content(context),
    );
  }

  Widget _content(BuildContext context) {
    return FutureBuilder(
      future: MusicService(Dio()).getAlbum(widget.id),
      builder: (context, AsyncSnapshot<Album> album) {
        if (album.connectionState == ConnectionState.waiting) {
          return Loading();
        }
        return FutureBuilder(
          future: MusicService(Dio()).getSongsFromAlbum(widget.id),
          builder: (context, AsyncSnapshot<List<Song>> tracks) {
            if (tracks.connectionState == ConnectionState.waiting || album.data == null) {
              return Loading();
            }

            return Column(
              children: [
                AlbumViewHeader(album.data!, setState, tracks.data!),
                Expanded(
                  child: ListView(
                    children: _body(context, album, tracks),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  List<Widget> _body(BuildContext context, AsyncSnapshot<Album> album, AsyncSnapshot<List<Song>> tracks) {
    List<Widget> list = [];

    list.add(AlbumInfo(album.data!));
    list.add(const SizedBox(height: 15));

    for (var song in tracks.data!) {
      list.add(
        AlbumSongCard(
          song,
          setState: setState,
        ),
      );
    }

    list.add(const SizedBox(height: kExtraSpace));

    return list;
  }
}
