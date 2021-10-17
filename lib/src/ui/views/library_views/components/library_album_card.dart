import 'package:canton_design_system/canton_design_system.dart';
import 'package:sap/src/models/album.dart';
import 'package:sap/src/ui/views/library_views/library_album_view.dart';

class LibraryAlbumCard extends StatelessWidget {
  const LibraryAlbumCard(this.album, {this.setState, this.setStateTwo});

  final Album album;
  final void Function(void Function())? setState;
  final void Function(void Function())? setStateTwo;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CantonMethods.viewTransition(
            context,
            LibraryAlbumView(
              album.id,
              setState: setState,
              setStateTwo: setStateTwo,
            ));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipSquircleBorder(
            radius: BorderRadius.all(Radius.circular(14)),
            child: Image.network(
              album.getAlbumCover!,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            _shortenTitle(album.title)!,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            _shortenTitle(album.artist!.name)!,
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: Theme.of(context).colorScheme.secondaryVariant,
                ),
          ),
        ],
      ),
    );
  }

  String? _shortenTitle(String? string) {
    if (![null, false].contains(album.explicit) && string!.length >= 28) {
      string = string.substring(0, 18) + '...';
    } else if (string!.length >= 23) {
      string = string.substring(0, 21) + '...';
    }

    return string;
  }
}
