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

import 'package:sap/src/models/playlist.dart';
import 'package:sap/src/providers/music_service_provider.dart';
import 'package:riverpod/riverpod.dart';

final topPlaylistsFutureProvider = FutureProvider.autoDispose<List<Playlist>>((ref) async {
  ref.maintainState = true;
  final musicService = ref.read(musicServiceProvider);

  final playlists = musicService.getTopPlaylists();
  return playlists;
});
