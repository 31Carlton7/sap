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

import 'package:flutter/foundation.dart';

import 'package:sap/src/models/album.dart';
import 'package:sap/src/models/artist.dart';

class Song {
  int? id;
  String? title;
  String? url;
  int? duration;
  int? trackPosition;
  int? diskNumber;
  int? rank;
  String? releaseDate;
  bool? explicit;
  bool? liked;
  String? previewUrl;
  List<Artist>? features;
  Artist? artist;
  Album? album;

  Song({
    this.id,
    this.title,
    this.url,
    this.duration,
    this.trackPosition,
    this.diskNumber,
    this.rank,
    this.releaseDate,
    this.liked,
    this.explicit,
    this.previewUrl,
    this.features,
    this.artist,
    this.album,
  });

  String? get getAlbumCover => album!.coverUrl;

  Song copyWith({
    int? id,
    String? title,
    String? url,
    int? duration,
    int? trackPosition,
    int? diskNumber,
    int? rank,
    String? releaseDate,
    bool? liked,
    bool? explicit,
    String? previewUrl,
    List<Artist>? features,
    Artist? artist,
    Album? album,
  }) {
    return Song(
      id: id ?? this.id,
      title: title ?? this.title,
      url: url ?? this.url,
      duration: duration ?? this.duration,
      trackPosition: trackPosition ?? this.trackPosition,
      diskNumber: diskNumber ?? this.diskNumber,
      rank: rank ?? this.rank,
      releaseDate: releaseDate ?? this.releaseDate,
      liked: liked ?? this.liked,
      explicit: explicit ?? this.explicit,
      previewUrl: previewUrl ?? this.previewUrl,
      features: features ?? this.features,
      artist: artist ?? this.artist,
      album: album ?? this.album,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'link': url,
      'duration': duration,
      'track_position': trackPosition,
      'disk_number': diskNumber,
      'rank': rank,
      'release_date': releaseDate,
      'liked': liked,
      'explicit_lyrics': explicit,
      'preview': previewUrl,
      'contributors': features,
      'artist': artist!.toMap(),
      'album': album!.toMapFromSong(artist!),
    };
  }

  Map<String, dynamic> toMapFromAlbum() {
    return {
      'id': id,
      'title': title,
      'link': url,
      'duration': duration,
      'track_position': trackPosition,
      'disk_number': diskNumber,
      'rank': rank,
      'release_date': releaseDate,
      'liked': liked ?? false,
      'explicit_lyrics': explicit,
      'preview': previewUrl,
      'contributors': features,
      'artist': artist!.toMap(),
    };
  }

  factory Song.fromMap(Map<String, dynamic> map) {
    return Song(
      id: map['id'] as int?,
      title: map['title'] as String?,
      url: map['link'] as String?,
      duration: map['duration'] as int?,
      trackPosition: map['track_position'] as int?,
      diskNumber: map['disk_number'] as int?,
      rank: map['rank'] as int?,
      releaseDate: map['release_date'] as String?,
      explicit: map['explicit_lyrics'] as bool?,
      liked: map['liked'] as bool?,
      previewUrl: map['preview'] as String?,
      features: List<Artist>.from((map['contributors'] ?? [])?.map((x) => Artist.fromMapFromSong(x))),
      artist: Artist.fromMap(map['artist']),
      album: Album.fromMapFromSong(map['album']),
    );
  }

  factory Song.fromMapFromDevice(Map<String, dynamic> map, Album album) {
    return Song(
      id: map['id'] as int?,
      title: map['title'] as String?,
      url: map['link'] as String?,
      duration: map['duration'] as int?,
      trackPosition: map['track_position'] as int?,
      diskNumber: map['disk_number'] as int?,
      rank: map['rank'] as int?,
      releaseDate: map['release_date'] as String?,
      explicit: map['explicit_lyrics'] as bool?,
      liked: map['liked'] as bool?,
      previewUrl: map['preview'] as String?,
      features: List<Artist>.from((map['contributors'])?.map((x) => Artist.fromMapFromSong(json.decode(x)))),
      artist: Artist.fromMap(map['artist']),
      album: album,
    );
  }

  factory Song.fromMapFromSearch(Map<String, dynamic> map) {
    return Song(
      id: map['id'] as int?,
      title: map['title'] as String?,
      url: map['link'] as String?,
      duration: map['duration'] as int?,
      rank: map['rank'] as int?,
      explicit: map['explicit_lyrics'] as bool?,
      previewUrl: map['preview'] as String?,
      artist: Artist.fromMapFromSong(map['artist']),
      album: Album.fromMapFromSearch(map['album']),
    );
  }

  factory Song.fromMapFromAlbum(Map<String, dynamic> map) {
    Artist? _artist() {
      if (map['artist'] == null) return Artist();
      return Artist.fromMap(map['artist']);
    }

    return Song(
      id: map['id'] as int?,
      title: map['title'] as String?,
      url: map['link'] as String?,
      duration: map['duration'] as int?,
      trackPosition: map['track_position'] as int?,
      diskNumber: map['disk_number'] as int?,
      rank: map['rank'] as int?,
      releaseDate: map['release_date'] as String?,
      liked: map['liked'] as bool? ?? false,
      explicit: map['explicit_lyrics'] as bool?,
      previewUrl: map['preview'] as String?,
      features: map['contributors'] as List<Artist>?,
      artist: _artist(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Song.fromJson(String source) => Song.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Song(id: $id, title: $title, url: $url, duration: $duration, trackPosition: $trackPosition, diskNumber: $diskNumber, rank: $rank, releaseDate: $releaseDate, liked: $liked, explicit: $explicit, previewUrl: $previewUrl, features: $features, artist: $artist, album: $album)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Song &&
        other.id == id &&
        other.title == title &&
        other.url == url &&
        other.duration == duration &&
        other.trackPosition == trackPosition &&
        other.diskNumber == diskNumber &&
        other.rank == rank &&
        other.releaseDate == releaseDate &&
        other.liked == liked &&
        other.explicit == explicit &&
        other.previewUrl == previewUrl &&
        listEquals(other.features, features) &&
        other.artist == artist &&
        other.album == album;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        url.hashCode ^
        duration.hashCode ^
        trackPosition.hashCode ^
        diskNumber.hashCode ^
        rank.hashCode ^
        releaseDate.hashCode ^
        liked.hashCode ^
        explicit.hashCode ^
        previewUrl.hashCode ^
        features.hashCode ^
        artist.hashCode ^
        album.hashCode;
  }
}
