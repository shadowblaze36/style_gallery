import 'package:flutter/material.dart';
import 'package:style_gallery/models/models.dart';
import 'package:style_gallery/screens/screens.dart';

class AppRoutes {
  static const initialRoute = 'sublimation';

  static final menuOptions = <MenuOption>[
    MenuOption(
        route: 'orders',
        name: 'Orders',
        screen: const OrdersScreen(),
        icon: Icons.search),
    MenuOption(
        route: 'sublimation',
        name: 'Sublimation',
        screen: const SublimationScreen(),
        icon: Icons.precision_manufacturing_rounded),
  ];

  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};
    appRoutes.addAll({'home': (BuildContext context) => const HomeScreen()});
    appRoutes.addAll({'login': (BuildContext context) => const LoginScreen()});
    appRoutes.addAll(
        {'checking': (BuildContext context) => const CheckAuthScreen()});
    for (final option in menuOptions) {
      appRoutes.addAll({option.route: (BuildContext context) => option.screen});
    }
    return appRoutes;
  }

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => const HomeScreen());
  }
}
