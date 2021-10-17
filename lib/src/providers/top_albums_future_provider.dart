import 'package:sap/src/models/album.dart';
import 'package:sap/src/providers/music_service_provider.dart';
import 'package:riverpod/riverpod.dart';

final topAlbumsFutureProvider = FutureProvider.autoDispose<List<Album>>((ref) async {
  ref.maintainState = true;
  final musicService = ref.read(musicServiceProvider);

  final albums = musicService.getTopAlbums();
  return albums;
});
