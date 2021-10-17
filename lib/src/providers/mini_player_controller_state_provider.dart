import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miniplayer/miniplayer.dart';

final miniPlayerControllerStateProvider = StateProvider.autoDispose<MiniplayerController>((ref) {
  return MiniplayerController();
});
