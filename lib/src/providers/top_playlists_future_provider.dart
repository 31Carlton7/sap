import 'package:sap/src/models/playlist.dart';
import 'package:sap/src/providers/music_service_provider.dart';
import 'package:riverpod/riverpod.dart';

final topPlaylistsFutureProvider = FutureProvider.autoDispose<List<Playlist>>((ref) async {
  ref.maintainState = true;
  final musicService = ref.read(musicServiceProvider);

  final playlists = musicService.getTopPlaylists();
  return playlists;
});
