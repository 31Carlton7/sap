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
import 'package:flutter/cupertino.dart';
import 'package:sap/src/models/song.dart';
import 'package:sap/src/providers/music_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sap/src/providers/music_service_provider.dart';

Future<void> showSongOptionsBottomSheet(
  BuildContext context,
  void Function(void Function()) setState,
  Song nSong,
) async {
  var song = await context.read(musicServiceProvider).getSong(nSong.id);
  song = song.copyWith(liked: nSong.liked);
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
                        Navigator.pop(context);
                        setState(() {
                          _addSongToLibraryFunction(context, song);
                        });
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
                        Navigator.pop(context);
                        Navigator.pop(context);
                        setState(() {
                          _removeSongFromLibraryFunction(context, song);
                        });
                      },
                    ),
              const SizedBox(height: 15),
              !context.read(musicRepositoryProvider.notifier).songIsAlreadyLiked(song)
                  ? CantonPrimaryButton(
                      buttonText: 'Add to Liked Songs',
                      color: Theme.of(context).colorScheme.onSecondary,
                      prefixIcon: Icon(
                        CupertinoIcons.heart_fill,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        setState(() {
                          _addSongToLikedSongsFunction(context, song);
                        });
                      },
                    )
                  : CantonPrimaryButton(
                      buttonText: 'Remove song from Liked Songs',
                      color: Theme.of(context).colorScheme.onSecondary,
                      prefixIcon: Icon(
                        CupertinoIcons.heart_slash_fill,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        setState(() {
                          _removeSongFromLikedSongsFunction(context, song);
                        });
                      },
                    ),
            ],
          ),
        ),
      );
    },
  );
}

Future<void> _addSongToLibraryFunction(BuildContext context, Song song) async {
  final repo = context.read(musicRepositoryProvider.notifier);
  repo.addSongToLibrary(song);
}

Future<void> _removeSongFromLibraryFunction(BuildContext context, Song song) async {
  final repo = context.read(musicRepositoryProvider.notifier);
  repo.removeSongFromLibrary(song);
}

Future<void> _addSongToLikedSongsFunction(BuildContext context, Song song) async {
  final repo = context.read(musicRepositoryProvider.notifier);
  repo.addSongToLikedSongs(song);
}

Future<void> _removeSongFromLikedSongsFunction(BuildContext context, Song song) async {
  final repo = context.read(musicRepositoryProvider.notifier);
  repo.removeSongFromLikedSongs(song);
}
