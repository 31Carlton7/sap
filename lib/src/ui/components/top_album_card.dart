import 'package:canton_design_system/canton_design_system.dart';
import 'package:sap/src/models/album.dart';
import 'package:sap/src/ui/views/album_view/album_view.dart';

class TopAlbumCard extends StatelessWidget {
  const TopAlbumCard(this.album);

  @required
  final Album album;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CantonMethods.viewTransition(context, AlbumView(album.id!));
      },
      child: Card(
        shape: const SquircleBorder(radius: BorderRadius.zero),
        color: CantonColors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipSquircleBorder(
              radius: BorderRadius.all(Radius.circular(10)),
              child: Image.network(
                album.getAlbumCover!,
                fit: BoxFit.cover,
                height: 85,
                width: 85,
              ),
            ),
            Text(
              _shortenTitle(album.title)!,
              maxLines: 2,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
    );
  }

  String? _shortenTitle(String? string) {
    if (album.explicit! && string!.length >= 20) {
      string = string.substring(0, 16) + '...';
    } else if (string!.length >= 19) {
      string = string.substring(0, 17) + '...';
    }

    return string;
  }
}
