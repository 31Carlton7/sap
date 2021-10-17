import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sap/src/models/library.dart';
import 'package:sap/src/repositories/music_repository.dart';

final musicRepositoryProvider =
    StateNotifierProvider<MusicRepository, Library>((ref) {
  return MusicRepository();
});
