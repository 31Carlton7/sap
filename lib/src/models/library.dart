import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:sap/src/models/album.dart';
import 'package:sap/src/models/artist.dart';
import 'package:sap/src/models/playlist.dart';
import 'package:sap/src/models/song.dart';

class Library {
  List<Album>? albums;
  List<Artist>? artists;
  List<Playlist>? playlists;
  List<Song>? songs;

  Library({
    this.albums,
    this.artists,
    this.playlists,
    this.songs,
  });

  Library copyWith({
    List<Album>? albums,
    List<Artist>? artists,
    List<Playlist>? playlists,
    List<Song>? songs,
  }) {
    return Library(
      albums: albums ?? this.albums,
      artists: artists ?? this.artists,
      playlists: playlists ?? this.playlists,
      songs: songs ?? this.songs,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'albums': albums?.map((x) => x.toMap()).toList(),
      'artists': artists?.map((x) => x.toMap()).toList(),
      'playlists': playlists?.map((x) => x.toMap()).toList(),
      'songs': songs?.map((x) => x.toMap()).toList(),
    };
  }

  factory Library.fromMap(Map<String, dynamic> map) {
    return Library(
      albums: List<Album>.from(
          map['albums']?.map((x) => Album.fromMapFromDevice(x))),
      artists: List<Artist>.from(map['artists']?.map((x) => Artist.fromMap(x))),
      playlists: List<Playlist>.from(
          map['playlists']?.map((x) => Playlist.fromMap(x))),
      songs: List<Song>.from(map['songs']?.map((x) => Song.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Library.fromJson(String source) =>
      Library.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Library(albums: $albums, artists: $artists, playlists: $playlists, songs: $songs)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Library &&
        listEquals(other.albums, albums) &&
        listEquals(other.artists, artists) &&
        listEquals(other.playlists, playlists) &&
        listEquals(other.songs, songs);
  }

  @override
  int get hashCode {
    return albums.hashCode ^
        artists.hashCode ^
        playlists.hashCode ^
        songs.hashCode;
  }
}
