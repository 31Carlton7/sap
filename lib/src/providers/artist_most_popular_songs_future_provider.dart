import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sap/src/models/song.dart';
import 'package:sap/src/providers/music_service_provider.dart';

var artistMostPopularSongsPath = '';

final artistMostPopularSongsFutureProvider = FutureProvider.autoDispose<List<Song>>((ref) {
  ref.maintainState = true;
  return ref.read(musicServiceProvider).getArtistMostPopularSongs(artistMostPopularSongsPath);
});
