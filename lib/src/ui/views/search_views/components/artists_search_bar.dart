/*
Sap
Copyright (C) 2021  Carlton Aikins

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

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
