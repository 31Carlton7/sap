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
    var album = context.read(musicRepositoryProvider).where((element) => element.id == widget.id).toList()[0];

    var trackList = album.tracks ?? [];
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
