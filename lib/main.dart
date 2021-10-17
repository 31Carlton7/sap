import 'dart:async';

import 'package:canton_design_system/canton_design_system.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:sap/src/config/constants.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sap/src/ui/views/current_view.dart';

void main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp();

    await Hive.initFlutter();
    await Hive.openBox('sap');

    if (kDebugMode) {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
    } else {
      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    }

    /// Lock screen orientation to vertical
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
        .then((_) {
      runApp(ProviderScope(child: MyApp()));
    });
  }, (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack);
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        return CantonApp(
          title: kAppTitle,
          primaryLightColor: CantonColors.yellow,
          primaryDarkColor: CantonDarkColors.yellow,
          primaryLightVariantColor: CantonColors.yellow[400]!,
          primaryDarkVariantColor: CantonDarkColors.yellow[400]!,
          navigatorObservers: [FirebaseAnalyticsObserver(analytics: FirebaseAnalytics())],
          home: CurrentView(),
        );
      },
    );
  }
}
