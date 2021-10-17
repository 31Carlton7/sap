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

import 'package:canton_design_system/canton_design_system.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sap/src/providers/audio_player_repository_provider.dart';
import 'package:sap/src/providers/duration_stream_provider.dart';

class PlayerView extends StatefulWidget {
  const PlayerView({Key? key});

  @override
  _PlayerViewState createState() => _PlayerViewState();
}

class _PlayerViewState extends State<PlayerView> {
  @override
  Widget build(BuildContext context) {
    return CantonScaffold(
      backgroundColor: CantonMethods.alternateCanvasColor(context),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        // Setup Variables
        var _currentSong = watch(audioPlayerRepositoryProvider).getCurrentSong;
        var _player = watch(audioPlayerRepositoryProvider);
        var _songFeatures = <String>[];

        for (var item in _currentSong.features!) {
          _songFeatures.add(item.name!);
        }

        // UI Variables
        var _albumCover = _currentSong.album!.getAlbumCover;
        var _songName = _currentSong.title;
        var _features = _songFeatures.join(', ');
        var _duration = watch(durationStreamProvider);
        var _albumCoverSize = MediaQuery.of(context).size.width * 0.6;

        if (_features == '' && _currentSong.artist != null) {
          _features = _currentSong.artist!.name!;
        }

        if (_features.length > 45) {
          _features = _features.substring(0, 42) + '...';
        }

        return _duration.when(
          error: (e, s) {
            return Container();
          },
          loading: () => Loading(),
          data: (duration) {
            return Column(
              children: [
                _header(context),
                const SizedBox(height: 50),
                (!['', null].contains(_albumCover))
                    ? ClipSquircleBorder(
                        radius: BorderRadius.circular(12),
                        child: Image.network(_albumCover!, height: _albumCoverSize, width: _albumCoverSize),
                      )
                    : Container(
                        height: _albumCoverSize,
                        width: _albumCoverSize,
                        decoration: ShapeDecoration(
                          shape: SquircleBorder(radius: BorderRadius.circular(12)),
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                        child: Center(
                          child: Icon(
                            Iconsax.music,
                            color: Theme.of(context).colorScheme.secondaryVariant,
                            size: 55,
                          ),
                        ),
                      ),
                const SizedBox(height: 45),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _songName!,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    const SizedBox(height: 7),
                    Text(
                      _features,
                      style: Theme.of(context).textTheme.headline6?.copyWith(
                            color: Theme.of(context).colorScheme.secondaryVariant,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Slider(
                  activeColor: Theme.of(context).primaryColor,
                  inactiveColor: Theme.of(context).colorScheme.secondary,
                  min: 0.0,
                  max: 30.0,
                  value: duration!.inSeconds.toDouble(),
                  onChanged: (value) {
                    _player.seek(Duration(seconds: value.toInt()));
                    value = value;
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CantonActionButton(
                      icon: Icon(
                        Iconsax.backward_10_seconds,
                        size: 32,
                      ),
                      onPressed: () => _player.seekBackward(),
                    ),
                    const SizedBox(width: 27),
                    (_player.isPlaying && _currentSong.previewUrl != '')
                        ? CantonActionButton(
                            icon: Icon(
                              Iconsax.pause,
                              size: 32,
                            ),
                            onPressed: () => _player.pause(),
                          )
                        : CantonActionButton(
                            icon: Icon(
                              Iconsax.play,
                              size: 32,
                            ),
                            onPressed: () => _player.play(),
                          ),
                    const SizedBox(width: 27),
                    CantonActionButton(
                      icon: Icon(
                        Iconsax.forward_10_seconds,
                        size: 32,
                      ),
                      onPressed: () => _player.seekForward(),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _header(BuildContext context) {
    return Container(
      height: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 5,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ),
    );
  }
}
