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
import 'package:sap/src/models/artist.dart';
import 'package:sap/src/models/song.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sap/src/providers/music_repository_provider.dart';
import 'package:just_audio/just_audio.dart';

class PlaylistSongCard extends StatefulWidget {
  const PlaylistSongCard(this.song);

  final Song song;

  @override
  _PlaylistSongCardState createState() => _PlaylistSongCardState();
}

class _PlaylistSongCardState extends State<PlaylistSongCard> {
  @override
  Widget build(BuildContext context) {
    var audioPlayer = AudioPlayer();
    return GestureDetector(
      onTap: () async {
        await audioPlayer.setUrl(widget.song.previewUrl!);

        audioPlayer.playerStateStream.listen((state) async {
          if (state.playing) {
            await audioPlayer.pause();
          } else {
            audioPlayer.play();
          }
        });
      },
      child: Card(
        shape: const SquircleBorder(radius: BorderRadius.zero),
        color: CantonColors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  Row(
                    children: [
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
                    ],
                  ),
                  Text(
                    _songFeaturesString(widget.song.features ?? [widget.song.artist]),
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Theme.of(context).colorScheme.secondaryVariant,
                        ),
                  ),
                ],
              ),
              Spacer(),
              GestureDetector(
                onTap: () => showSongOptionsBottomSheet(context, widget.song),
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
  }

  Future<void> showSongOptionsBottomSheet(BuildContext context, Song song) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      elevation: 0,
      useRootNavigator: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 27),
          child: FractionallySizedBox(
            heightFactor: 0.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 5,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                const SizedBox(height: 15),
                !context.read(musicRepositoryProvider.notifier).songIsAlreadyInLibrary(song)
                    ? CantonPrimaryButton(
                        buttonText: 'Add to library',
                        color: Theme.of(context).colorScheme.onSecondary,
                        prefixIcon: Icon(
                          FeatherIcons.plus,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () {
                          _addSongToLibraryFunction(context, song);
                          Navigator.pop(context);
                        },
                      )
                    : CantonPrimaryButton(
                        buttonText: 'Remove from library',
                        color: Theme.of(context).colorScheme.onSecondary,
                        prefixIcon: Icon(
                          FeatherIcons.minus,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () {
                          _removeSongFromLibraryFunction(context, song);
                          Navigator.pop(context);
                        },
                      ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _addSongToLibraryFunction(
    BuildContext context,
    Song song,
  ) async {
    setState(() {
      final repo = context.read(musicRepositoryProvider.notifier);
      repo.addSongToLibrary(song);
    });
  }

  Future<void> _removeSongFromLibraryFunction(
    BuildContext context,
    Song song,
  ) async {
    setState(() {
      final repo = context.read(musicRepositoryProvider.notifier);
      repo.removeSongFromLibrary(song);
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

  String _songFeaturesString(List<Artist?> artists) {
    String newString;
    List<String?> artistNames = [];
    for (var item in artists) {
      artistNames.add(item!.name);
    }

    newString = artistNames.join(', ');

    if (newString.length > 40) {
      return newString.substring(0, 37);
    }

    return newString;
  }
}
