import 'package:canton_design_system/canton_design_system.dart';

class LibraryAlbumsSearchBar extends StatelessWidget {
  const LibraryAlbumsSearchBar(this.controller, this.onChanged);

  final TextEditingController controller;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: CantonTextInput(
        hintText: 'Search in Albums',
        isTextFormField: false,
        obscureText: false,
        prefixIcon: IconlyIcon(
          IconlyBold.Search,
          color: Theme.of(context).colorScheme.secondaryVariant,
        ),
      ),
    );
  }
}
