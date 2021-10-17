import 'package:canton_design_system/canton_design_system.dart';

class BrowseViewHeader extends StatelessWidget {
  const BrowseViewHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      elevation: 0,
      snap: true,
      backgroundColor: CantonMethods.alternateCanvasColor(context),
      centerTitle: false,
      titleSpacing: 0,
      title: Text('Browse', style: Theme.of(context).textTheme.headline2),
    );
  }
}
