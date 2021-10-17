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

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      // Setup Variables
      var _currentSong = watch(audioPlayerRepositoryProvider).getCurrentSong;
      var _player = watch(audioPlayerRepositoryProvider);

      // UI Variables
      var _albumCover = _currentSong.album!.getAlbumCover;
      var _songName = _currentSong.title;

      if (_songName!.length > 27) {
        _songName = _songName.substring(0, 24) + '...';
      }

      return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
        ),
        child: Row(
          children: [
            (_albumCover == '' || _albumCover == null)
                ? Container(
                    height: 55,
                    width: 55,
                    margin: const EdgeInsets.only(left: 10),
                    decoration: ShapeDecoration(
                      shape: SquircleBorder(radius: BorderRadius.circular(12)),
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                    child: Center(
                      child: Icon(
                        Iconsax.music,
                        color: Theme.of(context).colorScheme.secondaryVariant,
                      ),
                    ),
                  )
                : Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: ClipSquircleBorder(
                      radius: BorderRadius.circular(12),
                      child: Image.network(_albumCover, height: 55, width: 55),
                    ),
                  ),
            const SizedBox(width: 10),
            Text(_songName, style: Theme.of(context).textTheme.headline6),
            Spacer(),
            (_player.isPlaying && _currentSong.previewUrl != '')
                ? CantonActionButton(
                    icon: Icon(
                      Iconsax.pause,
                      size: 24,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    onPressed: () => _player.pause(),
                  )
                : CantonActionButton(
                    icon: Icon(
                      Iconsax.play,
                      size: 24,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    onPressed: () => _player.play(),
                  ),
            const SizedBox(width: 10),
          ],
        ),
      );
    });
  }
}
