import 'package:canton_design_system/canton_design_system.dart';
import 'package:sap/src/models/album.dart';

class AlbumInfo extends StatelessWidget {
  const AlbumInfo(this.album);

  final Album album;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.center,
          child: (album.getAlbumCover != null)
              ? ClipSquircleBorder(
                  radius: BorderRadius.all(Radius.circular(30)),
                  child: Image.network(
                    album.getAlbumCover!,
                    fit: BoxFit.cover,
                    height: 250,
                    width: 250,
                  ),
                )
              : Container(
                  height: 250,
                  width: 250,
                  decoration: ShapeDecoration(
                    color: Theme.of(context).colorScheme.onSecondary,
                    shape: SquircleBorder(
                      radius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Iconsax.music,
                      size: 75,
                      color: Theme.of(context).colorScheme.secondaryVariant,
                    ),
                  ),
                ),
        ),
        const SizedBox(height: 15),
        Text(
          album.releaseDate!.substring(0, 4),
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Theme.of(context).colorScheme.secondaryVariant,
              ),
        ),
        const SizedBox(height: 7),
        Align(
          alignment: Alignment.center,
          child: Text(
            album.title!,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        const SizedBox(height: 7),
        Text(
          album.artist!.name!,
          style: Theme.of(context).textTheme.headline6!.copyWith(
                color: Theme.of(context).colorScheme.secondaryVariant,
              ),
        ),
      ],
    );
  }
}
