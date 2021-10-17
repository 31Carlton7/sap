import 'package:canton_design_system/canton_design_system.dart';
import 'package:sap/src/models/album.dart';
import 'package:sap/src/ui/components/show_album_options_bottom_sheet.dart';

class LibraryAlbumViewHeader extends StatelessWidget {
  const LibraryAlbumViewHeader(this.album, this.setState, {this.setStateTwo});

  final Album album;
  final void Function(void Function()) setState;
  final void Function(void Function())? setStateTwo;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CantonBackButton(isClear: true),
        CantonHeaderButton(
          backgroundColor: CantonColors.transparent,
          icon: Container(
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
          onPressed: () => showAlbumOptionsBottomSheet(context, setState, album, setStateTwo: setStateTwo),
        ),
      ],
    );
  }
}
