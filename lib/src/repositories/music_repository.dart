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

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:sap/src/models/album.dart';
import 'package:sap/src/models/song.dart';
import 'package:sap/src/services/music_service.dart';

class MusicRepository extends StateNotifier<List<Album>> {
  MusicRepository() : super([]);

  MusicService _service = MusicService(Dio());

  Future<void> addAlbumToLibrary(Album nAlbum) async {
    List<Song> albumSongs = [];
    var album = nAlbum;

    for (var song in album.tracks!) {
      albumSongs.add(await _service.getSong(song.id));
    }

    album.tracks = albumSongs;
    album.artist = await _service.getArtist(album.artist!.id);

    state = [album, ...state];
    state = state;
    await _saveData();
  }

  Future<void> addSongToLibrary(Song song) async {
    song = await _service.getSong(song.id);

    List<Song>? tracks() {
      if (state.where((e) => e.id == song.album!.id).toList().isEmpty) {
        return [];
      } else {
        return state.where((e) => e.id == song.album!.id).toList()[0].tracks;
      }
    }

    List<Album>? updateAlbumsState() {
      if (!albumIsAlreadyInLibrary(song.album)) {
        return [
          song.album!.copyWith(artist: song.artist, tracks: [song, ...tracks()!]),
          ...state
        ];
      } else {
        state.where((element) => element.id == song.album!.id).toList()[0].tracks = [song, ...tracks()!];
        return state;
      }
    }

    state = updateAlbumsState()!;
    await _saveData();
  }

  Future<void> removeAlbumFromLibrary(Album album) async {
    state = [
      for (final nAlbum in state)
        if (album.id != nAlbum.id) nAlbum,
    ];
    await _saveData();
  }

  Future<void> removeAlbumIdFromLibrary(int album) async {
    state = [
      for (final nAlbum in state)
        if (album != nAlbum.id) nAlbum,
    ];
    await _saveData();
  }

  Future<void> removeSongFromLibrary(Song song) async {
    var updatedAlbum = state.where((element) => element.id == song.album!.id).toList(growable: false)[0];

    updatedAlbum.tracks = [
      for (final nSong in updatedAlbum.tracks!)
        if (song.id != nSong.id) nSong,
    ];

    state = [updatedAlbum, ...state];
    var newAlbumsList = state;
    var index = newAlbumsList.lastIndexWhere((element) => element.id == updatedAlbum.id);
    newAlbumsList.removeRange(index, index + 1);

    state = [...newAlbumsList];
    await _saveData();
  }

  Future<void> addSongToLikedSongs(Song song) async {
    if (!songIsAlreadyInLibrary(song)) await addSongToLibrary(song);

    var updatedAlbum = state.where((element) => element.id == song.album!.id).toList(growable: false)[0];

    updatedAlbum.tracks!.where((element) => element.id == song.id).first.liked = true;

    state = [updatedAlbum, ...state];
    var newAlbumsList = state;
    var index = newAlbumsList.lastIndexWhere((element) => element.id == updatedAlbum.id);
    newAlbumsList.removeRange(index, index + 1);

    state = [...newAlbumsList];
    await _saveData();
  }

  Future<void> removeSongFromLikedSongs(Song song) async {
    var updatedAlbum = state.where((element) => element.id == song.album!.id).toList(growable: false)[0];

    updatedAlbum.tracks!.where((element) => element.id == song.id).first.liked = false;

    state = [updatedAlbum, ...state];
    var newAlbumsList = state;
    var index = newAlbumsList.lastIndexWhere((element) => element.id == updatedAlbum.id);
    newAlbumsList.removeRange(index, index + 1);

    state = [...newAlbumsList];
    await _saveData();
  }

  bool albumIsAlreadyInLibrary(Album? album) {
    for (var libAlbum in state) {
      if (libAlbum.id == album!.id) {
        return true;
      }
    }

    return false;
  }

  bool songIsAlreadyInLibrary(Song song) {
    for (var album in state) {
      for (var libSong in album.tracks!) {
        if (libSong.id == song.id) {
          return true;
        }
      }
    }

    return false;
  }

  bool songIsAlreadyLiked(Song song) {
    if (songIsAlreadyInLibrary(song) && ![null, false].contains(song.liked)) {
      return true;
    }

    return false;
  }

  Future<void> _saveData() async {
    var box = Hive.box('sap');

    await box.put('music', state.map((album) => album.toJson()).toList());
  }

  Future<void> loadData() async {
    var box = Hive.box('sap');

    /// Removes the entire library from device.
    // box.delete('music');

    state = (box.get('music', defaultValue: <String>[]) as List<String>)
        .map((album) => Album.fromMapFromDevice(json.decode(album)))
        .toList();
  }
}
