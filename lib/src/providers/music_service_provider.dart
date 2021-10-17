import 'package:dio/dio.dart';
import 'package:sap/src/services/music_service.dart';
import 'package:riverpod/riverpod.dart';

final musicServiceProvider = Provider<MusicService>((ref) {
  return MusicService(Dio());
});
