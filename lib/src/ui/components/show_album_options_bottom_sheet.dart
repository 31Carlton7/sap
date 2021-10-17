import 'package:canton_design_system/canton_design_system.dart';
import 'package:sap/src/models/album.dart';
import 'package:sap/src/providers/music_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> showAlbumOptionsBottomSheet(BuildContext context, void Function(void Function()) setState, Album album,
    {void Function(void Function())? setStateTwo}) {
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
              !context.read(musicRepositoryProvider.notifier).albumIsAlreadyInLibrary(album)
                  ? CantonPrimaryButton(
                      buttonText: 'Add to library',
                      textColor: Theme.of(context).colorScheme.primary,
                      color: Theme.of(context).colorScheme.onSecondary,
                      prefixIcon: Icon(
                        FeatherIcons.plus,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        setState(() {
                          _addAlbumToLibraryFunction(context, album);
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
                          _removeAlbumFromLibraryFunction(context, album);
                        });
                        if (setStateTwo != null) {
                          setStateTwo(() {});
                        }
                      },
                    ),
            ],
          ),
        ),
      );
    },
  );
}

Future<void> _addAlbumToLibraryFunction(
  BuildContext context,
  Album album,
) async {
  final repo = context.read(musicRepositoryProvider.notifier);
  repo.addAlbumToLibrary(album);
}

Future<void> _removeAlbumFromLibraryFunction(
  BuildContext context,
  Album album,
) async {
  final repo = context.read(musicRepositoryProvider.notifier);
  repo.removeAlbumFromLibrary(album);
}
