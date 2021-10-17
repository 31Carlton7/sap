import 'package:canton_design_system/canton_design_system.dart';

class ArtistsSearchBar extends StatelessWidget {
  const ArtistsSearchBar(this.controller, this.onChanged);

  final TextEditingController controller;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return CantonTextInput(
      hintText: 'Search for Artists',
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
