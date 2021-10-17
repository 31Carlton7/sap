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
import 'package:sap/src/models/song.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sap/src/repositories/audio_player_repository.dart';
import 'package:sap/src/providers/audio_player_repository_provider.dart';
import 'package:sap/src/ui/components/show_song_options_bottom_sheet.dart';

class SongCard extends StatefulWidget {
  const SongCard(this.song, {this.setState});

  final Song song;
  final void Function(void Function())? setState;

  @override
  _SongCardState createState() => _SongCardState();
}

class _SongCardState extends State<SongCard> {
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
    return ValueListenableBuilder<ButtonState>(
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                (widget.song.getAlbumCover != null)
                    ? ClipSquircleBorder(
                        radius: BorderRadius.all(Radius.circular(10)),
                        child: Image.network(
                          widget.song.getAlbumCover!,
                          fit: BoxFit.cover,
                          height: 50,
                          width: 50,
                        ),
                      )
                    : Container(
                        height: 50,
                        width: 50,
                        decoration: ShapeDecoration(
                          color: Theme.of(context).colorScheme.onSecondary,
                          shape: SquircleBorder(
                            radius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            Iconsax.music,
                            color: Theme.of(context).colorScheme.secondaryVariant,
                          ),
                        ),
                      ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _shortenTitle(widget.song.title)!,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        const SizedBox(width: 7),
                        widget.song.explicit!
                            ? Icon(
                                Icons.explicit,
                                color: Theme.of(context).colorScheme.secondaryVariant,
                                size: 20,
                              )
                            : Container(),
                      ],
                    ),
                    Text(
                      _shortenArtistsNames(widget.song.artist!.name!),
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Theme.of(context).colorScheme.secondaryVariant,
                          ),
                    ),
                  ],
                ),
                Spacer(),
                Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  GestureDetector(
                    onTap: () {
                      showSongOptionsBottomSheet(
                        context,
                        (widget.setState != null ? widget.setState! : setState),
                        widget.song,
                      );
                    },
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
                ]),
              ],
            ),
          ),
        );
      },
    );
  }

  String _shortenArtistsNames(String string) {
    if (string.length >= 30) {
      string = string.substring(0, 30) + '...';
    }

    return string;
  }

  String? _shortenTitle(String? string) {
    if (widget.song.explicit! && string!.length >= 22) {
      string = string.substring(0, 22) + '...';
    } else if (string!.length >= 24) {
      string = string.substring(0, 22) + '...';
    }

    return string;
  }
}
