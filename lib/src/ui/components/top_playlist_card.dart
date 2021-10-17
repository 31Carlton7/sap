import 'package:canton_design_system/canton_design_system.dart';
import 'package:sap/src/models/playlist.dart';
import 'package:sap/src/ui/views/playlist_view/playlist_view.dart';

class TopPlaylistCard extends StatelessWidget {
  @required
  final Playlist playlist;

  const TopPlaylistCard(this.playlist);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CantonMethods.viewTransition(context, PlaylistView(playlist.id));
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
                playlist.getPlaylistCover,
                fit: BoxFit.cover,
                height: 85,
                width: 85,
              ),
            ),
            Text(
              _shortenTitle(playlist.title!),
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
    );
  }

  String _shortenTitle(String string) {
    if (string.length >= 19) {
      string = string.substring(0, 17) + '...';
    }

    return string;
  }
}
