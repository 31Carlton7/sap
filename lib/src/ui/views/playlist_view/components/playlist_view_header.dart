import 'package:canton_design_system/canton_design_system.dart';
import 'package:sap/src/models/playlist.dart';
import 'package:sap/src/models/song.dart';
import 'package:sap/src/ui/components/show_playlist_options_bottom_sheet.dart';

class PlaylistViewHeader extends StatelessWidget {
  const PlaylistViewHeader(this.playlist, this.tracks, this.setState);

  final Playlist playlist;
  final void Function(void Function()) setState;
  final List<Song>? tracks;

  @override
  Widget build(BuildContext context) {
    var nPlaylist = playlist;
    nPlaylist = playlist.copyWith(tracks: tracks);
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
          onPressed: () => showPlaylistOptionsBottomSheet(context, setState, nPlaylist),
        ),
      ],
    );
  }
}
