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
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:sap/src/config/bottom_navigation_bar.dart';
import 'package:sap/src/config/constants.dart';
import 'package:sap/src/providers/mini_player_controller_state_provider.dart';
import 'package:sap/src/providers/music_repository_provider.dart';
import 'package:sap/src/ui/mini_player/mini_player.dart';
import 'package:sap/src/ui/mini_player/player_view.dart';
import 'package:sap/src/ui/views/library_views/library_view.dart';
import 'package:sap/src/ui/views/browse_view/browse_view.dart';
import 'package:sap/src/ui/views/search_views/search_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _navigatorKey = GlobalKey<NavigatorState>();

class CurrentView extends StatefulWidget {
  @override
  _CurrentViewState createState() => _CurrentViewState();
}

class _CurrentViewState extends State<CurrentView> {
  int _currentIndex = 0;
  final List<Widget> _views = [
    LibraryView(),
    BrowseView(),
    SearchView(),
  ];

  @override
  void initState() {
    super.initState();
    _getLibrary();
  }

  Future<void> _getLibrary() async {
    await context.read(musicRepositoryProvider.notifier).loadData();
    setState(() {});
  }

  void _onTabTapped(int index) {
    context.read(miniPlayerControllerStateProvider).state.animateToHeight(state: PanelState.MIN);
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final _miniPlayerController = watch(miniPlayerControllerStateProvider).state;

        return MiniplayerWillPopScope(
          onWillPop: () async {
            final navigator = _navigatorKey.currentState!;
            if (!navigator.canPop()) return true;

            navigator.pop();

            return false;
          },
          child: CantonScaffold(
            resizeToAvoidBottomInset: true,
            safeArea: false,
            padding: EdgeInsets.zero,
            bottomNavBar: BottomNavBar(_currentIndex, _onTabTapped),
            backgroundColor: CantonMethods.alternateCanvasColor(context, index: _currentIndex, targetIndexes: [1]),
            body: Stack(
              children: [
                IndexedStack(
                  index: _currentIndex,
                  children: [
                    Navigator(
                      observers: [FirebaseAnalyticsObserver(analytics: FirebaseAnalytics())],
                      onGenerateRoute: (settings) {
                        return MaterialPageRoute(
                          settings: settings,
                          fullscreenDialog: true,
                          builder: (context) => SafeArea(child: _views[_currentIndex]),
                        );
                      },
                    ),
                    Navigator(
                      observers: [FirebaseAnalyticsObserver(analytics: FirebaseAnalytics())],
                      onGenerateRoute: (settings) {
                        return MaterialPageRoute(
                          settings: settings,
                          fullscreenDialog: true,
                          builder: (context) => SafeArea(child: _views[_currentIndex]),
                        );
                      },
                    ),
                    Navigator(
                      observers: [FirebaseAnalyticsObserver(analytics: FirebaseAnalytics())],
                      onGenerateRoute: (settings) {
                        return MaterialPageRoute(
                          settings: settings,
                          fullscreenDialog: true,
                          builder: (context) => SafeArea(child: _views[_currentIndex]),
                        );
                      },
                    ),
                  ],
                ),
                (MediaQuery.of(context).viewInsets.bottom == 0)
                    ? Miniplayer(
                        controller: _miniPlayerController,
                        minHeight: kPlayerMinHeight,
                        backgroundColor: CantonColors.transparent,
                        maxHeight: MediaQuery.of(context).size.height,
                        curve: Curves.easeOut,
                        builder: (height, percentage) {
                          // Full Size
                          if (percentage > 0.65) return PlayerView();

                          // Mini Size
                          return MiniPlayer();
                        },
                      )
                    : Container(),
              ],
            ),
          ),
        );
      },
    );
  }
}
