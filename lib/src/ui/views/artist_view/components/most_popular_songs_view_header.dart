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

class MostPopularSongsViewHeader extends StatelessWidget {
  const MostPopularSongsViewHeader();

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      elevation: 0,
      backgroundColor: CantonMethods.alternateCanvasColor(context),
      title: Text(
        'Most Popular Songs',
        style: Theme.of(context).textTheme.headline5,
      ),
      centerTitle: true,
      leading: CantonBackButton(isClear: true),
    );
  }
}
