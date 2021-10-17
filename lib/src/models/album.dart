import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:sap/src/models/artist.dart';
import 'package:sap/src/models/song.dart';

class Album {
  int? id;
  String? title;
  String? url;
  String? coverUrl;
  String? labelName;
  int? numTracks;
  int? duration;
  int? rating;
  String? releaseDate;
  String? trackListUrl;
  bool? explicit;
  Artist? artist;
  String? trackList;
  List<Song>? tracks;

  Album({
    this.id,
    this.title,
    this.url,
    this.coverUrl,
    this.labelName,
    this.numTracks,
    this.duration,
    this.rating,
    this.releaseDate,
    this.trackListUrl,
    this.explicit,
    this.artist,
    this.trackList,
    this.tracks,
  });

  String? get getAlbumCover => coverUrl;

  Album copyWith({
    int? id,
    String? title,
    String? url,
    String? coverUrl,
    String? labelName,
    int? numTracks,
    int? duration,
    int? rating,
    String? releaseDate,
    String? trackListUrl,
    bool? explicit,
    Artist? artist,
    String? trackList,
    List<Song>? tracks,
  }) {
    return Album(
      id: id ?? this.id,
      title: title ?? this.title,
      url: url ?? this.url,
      coverUrl: coverUrl ?? this.coverUrl,
      labelName: labelName ?? this.labelName,
      numTracks: numTracks ?? this.numTracks,
      duration: duration ?? this.duration,
      rating: rating ?? this.rating,
      releaseDate: releaseDate ?? this.releaseDate,
      trackListUrl: trackListUrl ?? this.trackListUrl,
      explicit: explicit ?? this.explicit,
      artist: artist ?? this.artist,
      trackList: trackList ?? this.trackList,
      tracks: tracks ?? this.tracks,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'link': url,
      'cover_xl': coverUrl,
      'label': labelName,
      'nb_tracks': numTracks,
      'duration': duration,
      'rating': rating,
      'release_date': releaseDate,
      'tracklist': trackListUrl,
      'explicit_lyrics': explicit,
      'artist': artist!.toMap(),
      'trackList': trackList,
      'tracks': tracks?.map((x) => x.toMapFromAlbum()).toList(),
    };
  }

  Map<String, dynamic> toMapFromSong(Artist artist) {
    return {
      'id': id,
      'title': title,
      'link': url,
      'cover_xl': coverUrl,
      'release_date': releaseDate,
      'artist': artist.toMap(),
    };
  }

  factory Album.fromMap(Map<String, dynamic> map) {
    return Album(
      id: map['id'],
      title: map['title'],
      url: map['link'],
      coverUrl: map['cover_xl'],
      labelName: map['label'],
      numTracks: map['nb_tracks'],
      duration: map['duration'],
      rating: map['rating'],
      releaseDate: map['release_date'],
      trackListUrl: map['tracklist'],
      explicit: map['explicit_lyrics'],
      artist: Artist.fromMap(map['artist']),
      trackList: map['tracklist'],
    );
  }

  factory Album.fromMapFromDevice(Map<String, dynamic> map) {
    Artist? _artist() {
      if (map['artist'] == null) return Artist();
      return Artist.fromMapFromAlbum(map['artist']);
    }

    return Album(
      id: map['id'],
      title: map['title'],
      url: map['link'],
      coverUrl: map['cover_xl'],
      labelName: map['label'],
      numTracks: map['nb_tracks'],
      duration: map['duration'],
      rating: map['rating'],
      releaseDate: map['release_date'],
      trackListUrl: map['tracklist'],
      explicit: map['explicit_lyrics'],
      artist: _artist(),
      trackList: map['tracklist'],
      tracks: List<Song>.from((map['tracks'])?.map((x) => Song.fromMapFromDevice(x, Album.fromMapFromSong(map)))),
    );
  }

  factory Album.fromMapFromSong(Map<String, dynamic> map) {
    return Album(
      id: map['id'],
      title: map['title'],
      url: map['link'],
      coverUrl: map['cover_xl'],
      releaseDate: map['release_date'],
    );
  }

  factory Album.fromMapFromSearch(Map<String, dynamic> map) {
    return Album(
      id: map['id'],
      title: map['title'],
      coverUrl: map['cover_xl'],
    );
  }

  factory Album.fromMapFromArtist(Map<String, dynamic> map) {
    return Album(
      id: map['id'],
      title: map['title'],
      url: map['link'],
      coverUrl: map['cover_xl'],
      labelName: map['label'],
      numTracks: map['nb_tracks'],
      duration: map['duration'],
      rating: map['rating'],
      releaseDate: map['release_date'],
      trackListUrl: map['tracklist'],
      explicit: map['explicit_lyrics'],
      trackList: map['tracklist'],
    );
  }

  String toJson() => json.encode(toMap());

  String toJsonFromSong(Artist artist) => json.encode(toMapFromSong(artist));

  factory Album.fromJson(String source) => Album.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Album(id: $id, title: $title, url: $url, coverUrl: $coverUrl, labelName: $labelName, numTracks: $numTracks, duration: $duration, rating: $rating, releaseDate: $releaseDate, trackListUrl: $trackListUrl, explicit: $explicit, artist: $artist, trackList: $trackList, tracks: $tracks)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Album &&
        other.id == id &&
        other.title == title &&
        other.url == url &&
        other.coverUrl == coverUrl &&
        other.labelName == labelName &&
        other.numTracks == numTracks &&
        other.duration == duration &&
        other.rating == rating &&
        other.releaseDate == releaseDate &&
        other.trackListUrl == trackListUrl &&
        other.explicit == explicit &&
        other.artist == artist &&
        other.trackList == trackList &&
        listEquals(other.tracks, tracks);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        url.hashCode ^
        coverUrl.hashCode ^
        labelName.hashCode ^
        numTracks.hashCode ^
        duration.hashCode ^
        rating.hashCode ^
        releaseDate.hashCode ^
        trackListUrl.hashCode ^
        explicit.hashCode ^
        artist.hashCode ^
        trackList.hashCode ^
        tracks.hashCode;
  }
}
