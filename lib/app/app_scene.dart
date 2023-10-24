import 'package:flutter/material.dart';
import 'package:flutter_shuji_app/app/root_scene.dart';
import 'package:provider/provider.dart';

import '../theme/theme_manager.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class AppPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '书旗小说',
      navigatorObservers: [routeObserver],
      debugShowCheckedModeBanner: false,
      showPerformanceOverlay: false,
      checkerboardOffscreenLayers: false,
      checkerboardRasterCacheImages: false,
      theme: ThemeData.light(),
      themeMode: ThemeMode.light,
      home: RootPage(),
    );
  }
}


class MaterialAppTheme extends StatelessWidget {
  final ThemeData lightTheme = ThemeData.light();
  final ThemeData darkTheme = ThemeData.dark();

  @override
  Widget build(BuildContext context) {
    bool isDark = Provider.of<ThemeManager>(context).darkMode;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDark ? darkTheme : lightTheme,
      home: RootPage(),
    );
  }

// buildLightView() {
//   return MaterialApp(
//     title: '书旗小说',
//     navigatorObservers: [routeObserver],
//     debugShowCheckedModeBanner: false,
//     theme: ThemeConfig().lightTheme,
//     themeMode: ThemeMode.light,
//     home: RootPage(),
//   );
// }
//
// buildDarkView() {
//   return SaturationWidget(
//     child: MaterialApp(
//       title: '书旗小说',
//       navigatorObservers: [routeObserver],
//       debugShowCheckedModeBanner: false,
//       theme: ThemeConfig().darkTheme,
//       themeMode: ThemeMode.dark,
//       home: RootPage(),
//     ),
//   );
// }
}
