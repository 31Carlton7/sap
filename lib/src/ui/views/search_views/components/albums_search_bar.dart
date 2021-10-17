import 'package:canton_design_system/canton_design_system.dart';

class AlbumsSearchBar extends StatelessWidget {
  const AlbumsSearchBar(this.controller, this.onChanged);

  final TextEditingController controller;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return CantonTextInput(
      hintText: 'Search for Albums',
      isTextFormField: true,
      obscureText: false,
      controller: controller,
      onChanged: (query) => onChanged(query),
      prefixIcon: IconlyIcon(
        IconlyBold.Search,
        color: Theme.of(context).colorScheme.secondaryVariant,
      ),
    );
  }
}
