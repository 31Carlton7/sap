import 'package:canton_design_system/canton_design_system.dart';
import 'package:sap/src/models/artist.dart';
import 'package:sap/src/ui/views/artist_view/artist_view.dart';

class ArtistCard extends StatelessWidget {
  const ArtistCard(this.artist);

  final Artist artist;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CantonMethods.viewTransition(context, ArtistView(artist));
      },
      child: Container(
        child: Card(
          shape: const SquircleBorder(radius: BorderRadius.zero),
          color: CantonColors.transparent,
          child: Container(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  foregroundImage: NetworkImage(
                    artist.pictureUrl!,
                    scale: 50,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  _artistNameText(artist.name!),
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _artistNameText(String source) {
    if (source.length > 28) {
      return source.substring(0, 25) + '...';
    }
    return source;
  }
}
