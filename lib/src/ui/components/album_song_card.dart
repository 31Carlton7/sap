import 'package:canton_design_system/canton_design_system.dart';
import 'package:sap/src/models/song.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sap/src/providers/audio_player_repository_provider.dart';
import 'package:sap/src/repositories/audio_player_repository.dart';
import 'package:sap/src/ui/components/show_song_options_bottom_sheet.dart';

class AlbumSongCard extends StatefulWidget {
  const AlbumSongCard(this.song, {this.setState});

  final Song song;
  final void Function(void Function())? setState;

  @override
  _AlbumSongCardState createState() => _AlbumSongCardState();
}

class _AlbumSongCardState extends State<AlbumSongCard> {
  late AudioPlayerRepository _audioPlayerRepo;

  @override
  void initState() {
    super.initState();
    _initAudioPlayer();
  }

  void _initAudioPlayer() async {
    _audioPlayerRepo = context.read(audioPlayerRepositoryProvider);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _audioPlayerRepo.buttonNotifier,
        builder: (context, value, child) {
          return GestureDetector(
            onTap: () async {
              if (value == ButtonState.paused) {
                if (widget.song.previewUrl != _audioPlayerRepo.getCurrentSongUrl)
                  await _audioPlayerRepo.changeSong(widget.song);
                _audioPlayerRepo.play();
              } else if (widget.song.previewUrl != _audioPlayerRepo.getCurrentSongUrl) {
                await _audioPlayerRepo.changeSong(widget.song);
                _audioPlayerRepo.play();
              } else {
                _audioPlayerRepo.pause();
              }
            },
            child: Card(
              shape: const SquircleBorder(radius: BorderRadius.zero),
              margin: const EdgeInsets.symmetric(vertical: 5),
              color: CantonColors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      widget.song.trackPosition.toString(),
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    const SizedBox(width: 20),
                    Text(
                      _songTitleString(widget.song.title!),
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    const SizedBox(width: 7),
                    widget.song.explicit!
                        ? Icon(
                            Icons.explicit,
                            color: Theme.of(context).colorScheme.secondaryVariant,
                            size: 16,
                          )
                        : Container(),
                    Spacer(),
                    GestureDetector(
                      onTap: () => showSongOptionsBottomSheet(
                        context,
                        (widget.setState != null ? widget.setState! : setState),
                        widget.song,
                      ),
                      child: Container(
                        height: 24,
                        width: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                        child: Icon(
                          FeatherIcons.moreHorizontal,
                          color: Theme.of(context).primaryColor,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  String _songTitleString(String string) {
    if (string.length > 30) {
      if (string.contains(' (feat. ')) {
        return string.substring(0, 24) + '...';
      } else {
        return string.substring(0, 26) + '...';
      }
    } else {
      return string;
    }
  }
}
