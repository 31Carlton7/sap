import 'package:canton_design_system/canton_design_system.dart';

class SearchSongsViewHeader extends StatelessWidget {
  const SearchSongsViewHeader();

  @override
  Widget build(BuildContext context) {
    return ViewHeaderTwo(
      title: 'Search Songs',
      backButton: true,
    );
  }
}
