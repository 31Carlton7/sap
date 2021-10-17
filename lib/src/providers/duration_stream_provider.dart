import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sap/src/providers/audio_player_repository_provider.dart';

final durationStreamProvider = StreamProvider.autoDispose<Duration?>((ref) {
  return ref.read(audioPlayerRepositoryProvider).player.positionStream;
});
