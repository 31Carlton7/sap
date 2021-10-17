import 'package:canton_design_system/canton_design_system.dart';

class LibraryViewHeader extends StatelessWidget {
  const LibraryViewHeader();

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      elevation: 0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      centerTitle: false,
      titleSpacing: 0,
      title: Text('Library', style: Theme.of(context).textTheme.headline2),
    );
  }
}
