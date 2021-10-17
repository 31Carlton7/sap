import 'package:dio/dio.dart';
import 'package:sap/src/config/exceptions.dart';
import 'package:sap/src/models/album.dart';
import 'package:sap/src/models/artist.dart';
import 'package:sap/src/models/playlist.dart';
import 'package:sap/src/models/song.dart';

class MusicService {
  MusicService(this._dio);
  final Dio _dio;

  /// Default
  Future<Song> getSong(int? id) async {
    try {
      final response = await _dio.get(
        'https://api.deezer.com/track/$id',
      );

      final result = Map<String, dynamic>.from(response.data);

      final song = Song.fromMap(result);

      return song;
    } on DioError catch (e) {
      throw Exceptions.fromDioError(e);
    }
  }

  Future<Album> getAlbum(int? id) async {
    try {
      final response = await _dio.get(
        'https://api.deezer.com/album/$id',
      );

      final result = Map<String, dynamic>.from(response.data);

      final album = Album.fromMap(result);

      return album;
    } on DioError catch (e) {
      throw Exceptions.fromDioError(e);
    }
  }

  Future<Artist> getArtist(int? id) async {
    try {
      final response = await _dio.get(
        'https://api.deezer.com/artist/$id',
      );

      final result = Map<String, dynamic>.from(response.data);

      final Artist artist = Artist.fromMap(result);

      return artist;
    } on DioError catch (e) {
      throw Exceptions.fromDioError(e);
    }
  }

  Future<Playlist> getPlaylist(int? id) async {
    try {
      final response = await _dio.get(
        'https://api.deezer.com/playlist/$id',
      );

      final result = Map<String, dynamic>.from(response.data);

      final Playlist playlist = Playlist.fromMap(result);

      return playlist;
    } on DioError catch (e) {
      throw Exceptions.fromDioError(e);
    }
  }

  /// Search Functionality
  Future<List<Song>> getSongs({String? path}) async {
    try {
      final response = await _dio.get(
        'https://api.deezer.com/search/track?q=$path',
      );

      final results = List<Map<String, dynamic>>.from(
        response.data['data'] ?? [],
      );

      final songs = results.map((songData) => Song.fromMap(songData)).toList(growable: false);

      return songs;
    } on DioError catch (e) {
      throw Exceptions.fromDioError(e);
    }
  }

  Future<List<Album>> getAlbums({String? path}) async {
    try {
      final response = await _dio.get(
        'https://api.deezer.com/search/album?q=$path',
      );

      final results = List<Map<String, dynamic>>.from(
        response.data['data'] ?? [],
      );

      List<Album> albums = results.map((songData) => Album.fromMap(songData)).toList(growable: false);

      return albums;
    } on DioError catch (e) {
      throw Exceptions.fromDioError(e);
    }
  }

  Future<List<Artist>> getArtists({String? path}) async {
    try {
      final response = await _dio.get(
        'https://api.deezer.com/search/artist?q=$path',
      );

      final results = List<Map<String, dynamic>>.from(
        response.data['data'],
      );

      final List<Artist> artists = results.map((songData) => Artist.fromMap(songData)).toList(growable: false);

      return artists;
    } on DioError catch (e) {
      throw Exceptions.fromDioError(e);
    }
  }

  Future<List<Playlist>> getPlaylists({String? path}) async {
    try {
      final response = await _dio.get(
        'https://api.deezer.com/search/playlist?q=$path',
      );

      final results = List<Map<String, dynamic>>.from(
        response.data['data'] ?? [],
      );

      final List<Playlist> playlists =
          results.map((playlistData) => Playlist.fromMap(playlistData)).toList(growable: false);

      return playlists;
    } on DioError catch (e) {
      throw Exceptions.fromDioError(e);
    }
  }

  /// Static Functionality
  Future<List<Song>> getTopSongs() async {
    try {
      final response = await _dio.get(
        'https://api.deezer.com/chart/0/tracks',
      );

      final results = List<Map<String, dynamic>>.from(
        response.data['data'],
      );

      final List<Song> songs = results.map((songData) => Song.fromMap(songData)).toList(growable: false);

      return songs;
    } on DioError catch (e) {
      throw Exceptions.fromDioError(e);
    }
  }

  Future<List<Album>> getTopAlbums() async {
    try {
      final response = await _dio.get(
        'https://api.deezer.com/chart/0/albums',
      );

      final results = List<Map<String, dynamic>>.from(
        response.data['data'],
      );

      final List<Album> albums = results.map((albumData) => Album.fromMap(albumData)).toList(growable: false);

      return albums;
    } on DioError catch (e) {
      throw Exceptions.fromDioError(e);
    }
  }

  Future<List<Playlist>> getTopPlaylists() async {
    try {
      final response = await _dio.get(
        'https://api.deezer.com/chart/0/playlists',
      );

      final results = List<Map<String, dynamic>>.from(
        response.data['data'],
      );

      final List<Playlist> playlists = results.map((songData) => Playlist.fromMap(songData)).toList(growable: false);

      return playlists;
    } on DioError catch (e) {
      throw Exceptions.fromDioError(e);
    }
  }

  /// Other
  Future<List<Song>> getSongsFromAlbum(int? id) async {
    try {
      final response = await _dio.get(
        'https://api.deezer.com/album/$id/tracks',
      );

      final results = List<Map<String, dynamic>>.from(
        response.data['data'],
      );

      final List<Song> songs = results.map((songData) => Song.fromMapFromAlbum(songData)).toList(growable: false);

      return songs;
    } on DioError catch (e) {
      throw Exceptions.fromDioError(e);
    }
  }

  Future<List<Song>> getArtistMostPopularSongs(String? path) async {
    try {
      final response = await _dio.get(
        'https://api.deezer.com/search/track?q=$path',
      );

      final results = List<Map<String, dynamic>>.from(
        response.data['data'],
      );

      final List<Song> songs = results.map((songData) => Song.fromMapFromSearch(songData)).toList(growable: false);

      return songs;
    } on DioError catch (e) {
      throw Exceptions.fromDioError(e);
    }
  }

  Future<List<Album>> getAllArtistAlbums(int? id) async {
    try {
      final response = await _dio.get(
        'https://api.deezer.com/artist/$id/albums',
      );

      final results = List<Map<String, dynamic>>.from(
        response.data['data'],
      );

      final List<Album> albums = results.map((albumData) => Album.fromMapFromArtist(albumData)).toList(growable: false);

      return albums;
    } on DioError catch (e) {
      throw Exceptions.fromDioError(e);
    }
  }

  Future<List<Song>> getSongsFromPlaylist(int? id) async {
    try {
      final response = await _dio.get(
        'https://api.deezer.com/playlist/$id/tracks',
      );

      final results = List<Map<String, dynamic>>.from(
        response.data['data'],
      );

      final List<Song> songs = results.map((songData) => Song.fromMap(songData)).toList(growable: false);

      return songs;
    } on DioError catch (e) {
      throw Exceptions.fromDioError(e);
    }
  }
}
