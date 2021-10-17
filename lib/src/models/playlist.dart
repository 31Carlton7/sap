import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:sap/src/models/song.dart';

class Playlist {
  int? id;
  String? title;
  String? description;
  int? duration;
  bool? public;
  int? rating;
  int? numTracks;
  String? url;
  String? pictureUrl;
  List<Song>? tracks;

  Playlist({
    this.id,
    this.title,
    this.description,
    this.duration,
    this.public,
    this.rating,
    this.numTracks,
    this.url,
    this.pictureUrl,
    this.tracks,
  });

  Playlist copyWith({
    int? id,
    String? title,
    String? description,
    int? duration,
    bool? public,
    int? rating,
    int? numTracks,
    String? url,
    String? pictureUrl,
    List<Song>? tracks,
  }) {
    return Playlist(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      duration: duration ?? this.duration,
      public: public ?? this.public,
      rating: rating ?? this.rating,
      numTracks: numTracks ?? this.numTracks,
      url: url ?? this.url,
      pictureUrl: pictureUrl ?? this.pictureUrl,
      tracks: tracks ?? this.tracks,
    );
  }

  String get getPlaylistCover => '$pictureUrl';

  Map<String, dynamic> toMap() {
    List<dynamic>? _tracks() {
      for (var item in tracks!) {
        if (item.album == null) {
          return tracks?.map((x) => x.toMapFromAlbum()).toList();
        }
      }

      return tracks?.map((x) => x.toMap()).toList();
    }

    return {
      'id': id,
      'title': title,
      'description': description,
      'duration': duration,
      'public': public,
      'rating': rating,
      'nb_tracks': numTracks,
      'link': url,
      'picture_xl': pictureUrl,
      'tracks': _tracks(),
    };
  }

  factory Playlist.fromMap(Map<String, dynamic> map) {
    return Playlist(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      duration: map['duration'],
      public: map['public'],
      rating: map['rating'],
      numTracks: map['nb_tracks'],
      url: map['link'],
      pictureUrl: map['picture_xl'],
      tracks: [],
    );
  }

  String toJson() => json.encode(toMap());

  factory Playlist.fromJson(String source) => Playlist.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Playlist(id: $id, title: $title, description: $description, duration: $duration, public: $public, rating: $rating, numTracks: $numTracks, url: $url, pictureUrl: $pictureUrl, tracks: $tracks)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Playlist &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.duration == duration &&
        other.public == public &&
        other.rating == rating &&
        other.numTracks == numTracks &&
        other.url == url &&
        other.pictureUrl == pictureUrl &&
        listEquals(other.tracks, tracks);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        duration.hashCode ^
        public.hashCode ^
        rating.hashCode ^
        numTracks.hashCode ^
        url.hashCode ^
        pictureUrl.hashCode ^
        tracks.hashCode;
  }
}
