import 'package:canton_design_system/canton_design_system.dart';

class SearchArtistsViewHeader extends StatelessWidget {
  const SearchArtistsViewHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewHeaderTwo(
      title: 'Search Artists',
      backButton: true,
    );
  }
}
