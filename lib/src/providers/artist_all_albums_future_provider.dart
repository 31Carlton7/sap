import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sap/src/models/album.dart';
import 'package:sap/src/providers/music_service_provider.dart';

var artistAllAlbumsId = 0;

final artistAllAlbumsFutureProvider = FutureProvider.autoDispose<List<Album>>((ref) {
  return ref.read(musicServiceProvider).getAllArtistAlbums(artistAllAlbumsId);
});
