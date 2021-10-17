import 'package:canton_design_system/canton_design_system.dart';
import 'package:sap/src/models/playlist.dart';
import 'package:sap/src/providers/music_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> showPlaylistOptionsBottomSheet(
    BuildContext context, void Function(void Function()) setState, Playlist playlist) {
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
              !_playlistIsAlreadyInLibrary(context, playlist)
                  ? CantonPrimaryButton(
                      buttonText: 'Add to library',
                      color: Theme.of(context).colorScheme.onSecondary,
                      prefixIcon: Icon(
                        FeatherIcons.plus,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        _addPlaylistToLibraryFunction(context, setState, playlist);
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
                        _removePlaylistToLibraryFunction(context, setState, playlist);
                      },
                    ),
            ],
          ),
        ),
      );
    },
  );
}

bool _playlistIsAlreadyInLibrary(BuildContext context, Playlist playlist) {
  for (var libPlaylist in context.read(musicRepositoryProvider).playlists!) {
    if (libPlaylist.id == libPlaylist.id) {
      return true;
    }
  }

  return false;
}

Future<void> _addPlaylistToLibraryFunction(
  BuildContext context,
  void Function(void Function()) setState,
  Playlist playlist,
) async {
  setState(() {
    final repo = context.read(musicRepositoryProvider.notifier);
    repo.addPlaylistToLibrary(playlist);
  });
  Navigator.pop(context);
}

Future<void> _removePlaylistToLibraryFunction(
  BuildContext context,
  void Function(void Function()) setState,
  Playlist playlist,
) async {
  setState(() {
    final repo = context.read(musicRepositoryProvider.notifier);
    repo.removePlaylistFromLibrary(playlist);
  });
  Navigator.pop(context);
}
