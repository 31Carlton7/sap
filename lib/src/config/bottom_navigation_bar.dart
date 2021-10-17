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
import 'package:flutter/cupertino.dart';

class BottomNavBar extends StatefulWidget {
  final int currentIndex;
  final void Function(int) onTabTapped;

  const BottomNavBar(this.currentIndex, this.onTabTapped);
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      onTap: widget.onTabTapped,
      backgroundColor: Theme.of(context).colorScheme.onSecondary,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      unselectedItemColor: Theme.of(context).colorScheme.secondaryVariant,
      selectedIconTheme: IconThemeData(color: Theme.of(context).primaryColor, size: 24),
      items: [
        BottomNavigationBarItem(
          label: 'Library',
          tooltip: '',
          activeIcon: Icon(Iconsax.folder, size: 24),
          icon: Icon(Iconsax.folder, size: 24),
        ),
        BottomNavigationBarItem(
          label: 'Browse',
          tooltip: '',
          activeIcon: Icon(Iconsax.category, size: 24),
          icon: Icon(Iconsax.category, size: 24),
        ),
        BottomNavigationBarItem(
          label: 'Search',
          tooltip: '',
          activeIcon: Icon(Iconsax.search_normal, size: 24),
          icon: Icon(Iconsax.search_normal, size: 24),
        ),
      ],
    );
  }
}
