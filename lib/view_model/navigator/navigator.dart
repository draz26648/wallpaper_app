import 'package:flutter/material.dart';
import 'package:wallpaper/view/screens/wallpaper_details/photo_details.dart';
import 'package:wallpaper/view_model/navigator/routes.dart';

import '../../view/screens/home/home_screen.dart';
import '../../view/screens/search/search_screen.dart';
import '../../view/screens/splash/splash_screen.dart';

abstract class CustomNavigator {
  static final GlobalKey<NavigatorState> navigatorState =
      GlobalKey<NavigatorState>();
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case Routes.home:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(
            index: 0,
          ),
        );
      case Routes.search:
        return MaterialPageRoute(
          builder: (context) => const SearchScreen(),
        );
    }
    return MaterialPageRoute(builder: (_) => Container());
  }

  static pop({dynamic result}) {
    if (navigatorState.currentState!.canPop()) {
      navigatorState.currentState!.pop(result);
    }
  }

  static push(String routeName,
      {arguments, bool replace = false, bool clean = false}) {
    if (clean) {
      return navigatorState.currentState!.pushNamedAndRemoveUntil(
          routeName, (_) => false,
          arguments: arguments);
    } else if (replace) {
      return navigatorState.currentState!
          .pushReplacementNamed(routeName, arguments: arguments);
    } else {
      return navigatorState.currentState!
          .pushNamed(routeName, arguments: arguments);
    }
  }
}
