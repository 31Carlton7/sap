import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sap/src/repositories/audio_player_repository.dart';

final audioPlayerRepositoryProvider = ChangeNotifierProvider<AudioPlayerRepository>((ref) {
  return AudioPlayerRepository();
});
