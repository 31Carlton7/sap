import 'package:sap/src/models/song.dart';
import 'package:sap/src/providers/music_service_provider.dart';
import 'package:riverpod/riverpod.dart';

final topSongsFutureProvider = FutureProvider.autoDispose<List<Song>>((ref) async {
  ref.maintainState = true;
  final musicService = ref.read(musicServiceProvider);

  final songs = musicService.getTopSongs();
  return songs;
});
