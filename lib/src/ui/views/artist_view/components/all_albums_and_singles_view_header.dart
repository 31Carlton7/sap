import 'package:canton_design_system/canton_design_system.dart';

class AllAlbumsAndSinglesViewHeader extends StatelessWidget {
  const AllAlbumsAndSinglesViewHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      elevation: 0,
      backgroundColor: CantonMethods.alternateCanvasColor(context),
      title: Text(
        'All Albums & Singles',
        style: Theme.of(context).textTheme.headline5,
      ),
      centerTitle: true,
      leading: CantonBackButton(isClear: true),
    );
  }
}
