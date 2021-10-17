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
