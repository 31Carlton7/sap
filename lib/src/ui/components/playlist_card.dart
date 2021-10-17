import 'package:canton_design_system/canton_design_system.dart';
import 'package:sap/src/models/playlist.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sap/src/providers/music_repository_provider.dart';

class PlaylistCard extends StatefulWidget {
  const PlaylistCard(this.playlist);

  @required
  final Playlist playlist;

  @override
  _PlaylistCardState createState() => _PlaylistCardState();
}

class _PlaylistCardState extends State<PlaylistCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        shape: const SquircleBorder(radius: BorderRadius.zero),
        color: CantonColors.transparent,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipSquircleBorder(
              radius: BorderRadius.all(Radius.circular(30)),
              child: Image.network(
                widget.playlist.getPlaylistCover,
                fit: BoxFit.cover,
                height: 70,
                width: 70,
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
                      _shortenTitle(widget.playlist.title!),
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ],
                ),
                // Text(
                //   _shortenArtistsNames(widget.playlist.),
                //   style: Theme.of(context).textTheme.bodyText1.copyWith(
                //         color: Theme.of(context).colorScheme.secondaryVariant,
                //       ),
                // ),
              ],
            ),
            Spacer(),
            Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
              GestureDetector(
                onTap: () {
                  showPlaylistOptionsBottomSheet(context, widget.playlist);
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
  }

  Future<void> showPlaylistOptionsBottomSheet(BuildContext context, Playlist playlist) {
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
                !context.read(musicRepositoryProvider.notifier).playlistIsAlreadyInLibrary(playlist)
                    ? CantonPrimaryButton(
                        buttonText: 'Add to library',
                        color: Theme.of(context).colorScheme.onSecondary,
                        prefixIcon: Icon(
                          FeatherIcons.plus,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () {
                          _addPlaylistToLibraryFunction(context, playlist);
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
                          _removePlaylistFromLibraryFunction(context, playlist);
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

  // ignore: unused_element
  String _shortenArtistsNames(String string) {
    if (string.length >= 30) {
      string = string.substring(0, 30) + '...';
    }

    return string;
  }

  String _shortenTitle(String string) {
    if (string.length >= 22) {
      string = string.substring(0, 22) + '...';
    }

    return string;
  }

  Future<void> _addPlaylistToLibraryFunction(
    BuildContext context,
    Playlist playlist,
  ) async {
    setState(() {
      final repo = context.read(musicRepositoryProvider.notifier);
      repo.addPlaylistToLibrary(playlist);
    });
  }

  Future<void> _removePlaylistFromLibraryFunction(
    BuildContext context,
    Playlist playlist,
  ) async {
    setState(() {
      final repo = context.read(musicRepositoryProvider.notifier);
      repo.removePlaylistFromLibrary(playlist);
    });
  }
}
