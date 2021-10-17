import 'package:canton_design_system/canton_design_system.dart';

class AllAlbumsAndSongsViewHeader extends StatelessWidget {
  const AllAlbumsAndSongsViewHeader();

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      elevation: 0,
      backgroundColor: CantonMethods.alternateCanvasColor(context),
      title: Text(
        'All Albums & Songs',
        style: Theme.of(context).textTheme.headline5,
      ),
      centerTitle: true,
      leading: CantonBackButton(isClear: true),
    );
  }
}
