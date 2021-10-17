import 'package:canton_design_system/canton_design_system.dart';

class SearchAlbumsViewHeader extends StatelessWidget {
  const SearchAlbumsViewHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewHeaderTwo(
      title: 'Search Albums',
      backButton: true,
    );
  }
}
