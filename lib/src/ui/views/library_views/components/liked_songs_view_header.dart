import 'package:canton_design_system/canton_design_system.dart';

class LikedSongsViewHeader extends StatelessWidget {
  const LikedSongsViewHeader();

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      elevation: 0,
      backgroundColor: CantonMethods.alternateCanvasColor(context),
      title: Text(
        'Liked Songs',
        style: Theme.of(context).textTheme.headline5,
      ),
      centerTitle: true,
      leading: CantonBackButton(isClear: true),
    );
  }
}
