/*
Sap
Copyright (C) 2021  Carlton Aikins

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sap/src/models/album.dart';
import 'package:sap/src/models/song.dart';
import 'package:sap/src/services/music_service.dart';

class AudioPlayerRepository extends ChangeNotifier {
  final progressNotifier = ValueNotifier<ProgressBarState>(
    ProgressBarState(
      current: Duration.zero,
      buffered: Duration.zero,
      total: Duration.zero,
    ),
  );
  final buttonNotifier = ValueNotifier<ButtonState>(ButtonState.paused);

  var _audioPlayer = AudioPlayer();
  var _service = MusicService(Dio());
  Song _currentSong = Song(previewUrl: '', title: 'Not Playing', features: [], album: Album(coverUrl: ''));

  AudioPlayer get player => _audioPlayer;
  String get getCurrentSongUrl => _currentSong.previewUrl ?? '';
  Song get getCurrentSong => _currentSong;

  bool get isPlaying => _audioPlayer.playing;

  Future<void> changeSong(Song newSong) async {
    if (newSong.previewUrl != _currentSong.previewUrl) {
      if (newSong.album == null) {
        _currentSong = await _service.getSong(newSong.id);
      } else {
        _currentSong = newSong;
      }

      await _audioPlayer.setUrl(newSong.previewUrl!);
    }

    notifyListeners();
  }

  AudioPlayerRepository() {
    _init();
  }

  void _init() async {
    await changeSong(_currentSong);

    // listen for changes in player state
    _audioPlayer.playerStateStream.listen((playerState) {
      final isPlaying = playerState.playing;
      final processingState = playerState.processingState;
      if (processingState == ProcessingState.loading || processingState == ProcessingState.buffering) {
        buttonNotifier.value = ButtonState.loading;
      } else if (!isPlaying) {
        buttonNotifier.value = ButtonState.paused;
      } else if (processingState != ProcessingState.completed) {
        buttonNotifier.value = ButtonState.playing;
      } else {
        _audioPlayer.seek(Duration.zero);
        _audioPlayer.pause();
      }
    });

    // listen for changes in play position
    _audioPlayer.positionStream.listen((position) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: position,
        buffered: oldState.buffered,
        total: oldState.total,
      );
    });

    // listen for changes in the buffered position
    _audioPlayer.bufferedPositionStream.listen((bufferedPosition) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: bufferedPosition,
        total: oldState.total,
      );
    });

    // listen for changes in the total audio duration
    _audioPlayer.durationStream.listen((totalDuration) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: oldState.buffered,
        total: totalDuration ?? Duration.zero,
      );
    });
  }

  void play() async {
    _audioPlayer.play();
    notifyListeners();
  }

  void pause() {
    _audioPlayer.pause();
    notifyListeners();
  }

  void seek(Duration position) {
    _audioPlayer.seek(position);
    notifyListeners();
  }

  void seekForward() {
    if (_audioPlayer.position.inSeconds + 10 > 30) {
      seek(Duration(seconds: 30));
    } else {
      seek(Duration(seconds: _audioPlayer.position.inSeconds + 10));
    }
  }

  void seekBackward() {
    if (_audioPlayer.position.inSeconds - 10 < 30) {
      seek(Duration(seconds: 0));
    } else {
      seek(Duration(seconds: _audioPlayer.position.inSeconds - 10));
    }
  }

  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}

class ProgressBarState {
  ProgressBarState({
    required this.current,
    required this.buffered,
    required this.total,
  });
  final Duration current;
  final Duration buffered;
  final Duration total;
}

enum ButtonState { paused, playing, loading }
