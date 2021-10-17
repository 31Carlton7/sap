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
import 'package:sap/src/models/artist.dart';
import 'package:sap/src/models/library.dart';
import 'package:sap/src/models/playlist.dart';
import 'package:sap/src/models/song.dart';
import 'package:sap/src/services/music_service.dart';

class MusicRepository extends StateNotifier<Library> {
  MusicRepository() : super(Library(albums: [], playlists: [], artists: [], songs: []));

  MusicService _service = MusicService(Dio());

  Future<void> addAlbumToLibrary(Album nAlbum) async {
    List<Song> albumSongs = [];
    var album = nAlbum;

    for (var song in album.tracks!) {
      albumSongs.add(await _service.getSong(song.id));
    }

    album.tracks = albumSongs;
    album.artist = await _service.getArtist(album.artist!.id);

    state.albums = [album, ...state.albums!];
    await _saveData();
  }

  Future<void> addPlaylistToLibrary(Playlist playlist) async {
    state.playlists = [playlist, ...state.playlists!];
    await _saveData();
  }

  Future<void> addArtistToLibrary(Artist artist) async {
    state.artists = [artist, ...state.artists!];
    await _saveData();
  }

  Future<void> addSongToLibrary(Song song) async {
    song = await _service.getSong(song.id);

    List<Song>? tracks() {
      if (state.albums!.where((e) => e.id == song.album!.id).toList().isEmpty) {
        return [];
      } else {
        return state.albums!.where((e) => e.id == song.album!.id).toList()[0].tracks;
      }
    }

    List<Album>? updateAlbumsState() {
      if (!albumIsAlreadyInLibrary(song.album)) {
        return [
          song.album!.copyWith(artist: song.artist, tracks: [song, ...tracks()!]),
          ...state.albums!
        ];
      } else {
        state.albums!.where((element) => element.id == song.album!.id).toList()[0].tracks = [song, ...tracks()!];
        return state.albums;
      }
    }

    state.albums = updateAlbumsState();
    await _saveData();
  }

  Future<void> removeAlbumFromLibrary(Album album) async {
    state.albums = [
      for (final nAlbum in state.albums!)
        if (album.id != nAlbum.id) nAlbum,
    ];
    _saveData();
  }

  Future<void> removeAlbumIdFromLibrary(int album) async {
    state.albums = [
      for (final nAlbum in state.albums!)
        if (album != nAlbum.id) nAlbum,
    ];
    _saveData();
  }

  Future<void> removePlaylistFromLibrary(Playlist playlist) async {
    state.playlists = [
      for (final nPlaylist in state.playlists!)
        if (playlist.id != nPlaylist.id) nPlaylist,
    ];
    _saveData();
  }

  Future<void> removeSongFromLibrary(Song song) async {
    var updatedAlbum = state.albums!.where((element) => element.id == song.album!.id).toList(growable: false)[0];

    updatedAlbum.tracks = [
      for (final nSong in updatedAlbum.tracks!)
        if (song.id != nSong.id) nSong,
    ];

    state.albums = [updatedAlbum, ...state.albums!];
    var newAlbumsList = state.albums!;
    var index = newAlbumsList.lastIndexWhere((element) => element.id == updatedAlbum.id);
    newAlbumsList.removeRange(index, index + 1);

    state.albums = [...newAlbumsList];
    await _saveData();
  }

  Future<void> addSongToLikedSongs(Song song) async {
    if (!songIsAlreadyInLibrary(song)) await addSongToLibrary(song);

    var updatedAlbum = state.albums!.where((element) => element.id == song.album!.id).toList(growable: false)[0];

    updatedAlbum.tracks!.where((element) => element.id == song.id).first.liked = true;

    state.albums = [updatedAlbum, ...state.albums!];
    var newAlbumsList = state.albums!;
    var index = newAlbumsList.lastIndexWhere((element) => element.id == updatedAlbum.id);
    newAlbumsList.removeRange(index, index + 1);

    state.albums = [...newAlbumsList];
    await _saveData();
  }

  Future<void> removeSongFromLikedSongs(Song song) async {
    var updatedAlbum = state.albums!.where((element) => element.id == song.album!.id).toList(growable: false)[0];

    updatedAlbum.tracks!.where((element) => element.id == song.id).first.liked = false;

    state.albums = [updatedAlbum, ...state.albums!];
    var newAlbumsList = state.albums!;
    var index = newAlbumsList.lastIndexWhere((element) => element.id == updatedAlbum.id);
    newAlbumsList.removeRange(index, index + 1);

    state.albums = [...newAlbumsList];
    await _saveData();
  }

  bool albumIsAlreadyInLibrary(Album? album) {
    for (var libAlbum in state.albums!) {
      if (libAlbum.id == album!.id) {
        return true;
      }
    }

    return false;
  }

  bool playlistIsAlreadyInLibrary(Playlist playlist) {
    for (var libPlaylist in state.playlists!) {
      if (libPlaylist.id == playlist.id) {
        return true;
      }
    }

    return false;
  }

  bool songIsAlreadyInLibrary(Song song) {
    for (var album in state.albums!) {
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

    await box.put('albums', state.albums!.map((album) => album.toJson()).toList());
    await box.put('artists', state.artists!.map((artist) => artist.toJson()).toList());
    await box.put('playlists', state.playlists!.map((playlist) => playlist.toJson()).toList());
  }

  Future<void> loadData() async {
    var box = Hive.box('sap');

    /// Removes the entire [Library] from device.
    // box.delete('albums');
    // box.delete('artists');
    // box.delete('playlists');

    state.albums = (box.get('albums', defaultValue: <String>[]) as List<String>)
        .map((album) => Album.fromMapFromDevice(json.decode(album)))
        .toList();

    state.artists = (box.get('artists', defaultValue: <String>[]) as List<String>)
        .map((artist) => Artist.fromMap(json.decode(artist)))
        .toList();

    state.playlists = (box.get('playlists', defaultValue: <String>[]) as List<String>)
        .map((playlist) => Playlist.fromMap(json.decode(playlist)))
        .toList();
  }
}
