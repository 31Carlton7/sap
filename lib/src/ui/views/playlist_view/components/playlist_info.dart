import 'package:canton_design_system/canton_design_system.dart';
import 'package:sap/src/models/playlist.dart';

class PlaylistInfo extends StatelessWidget {
  const PlaylistInfo(this.playlist);

  final Playlist playlist;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.center,
          child: ClipSquircleBorder(
            radius: BorderRadius.all(Radius.circular(30)),
            child: Image.network(
              playlist.getPlaylistCover,
              fit: BoxFit.cover,
              height: 250,
              width: 250,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Align(
          alignment: Alignment.center,
          child: Text(
            playlist.title!,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        const SizedBox(height: 7),
        Text(
          playlist.description!,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Theme.of(context).colorScheme.secondaryVariant,
              ),
        ),
      ],
    );
  }
}
