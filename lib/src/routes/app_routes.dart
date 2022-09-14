import 'package:get/route_manager.dart';
import 'package:greengrocer/src/screens/base_screen.dart';
import 'package:greengrocer/src/screens/sign_in_screen.dart';
import 'package:greengrocer/src/screens/sign_up_screen.dart';
import 'package:greengrocer/src/screens/splash_screen.dart';

abstract class AppPages {
  static final pages = <GetPage>[
    GetPage(page: () => const SplashScreen(), name: PagesRoutes.splashRoute),
    GetPage(page: () => const BaseScreen(), name: PagesRoutes.baseRoute),
    GetPage(page: () => const SignInScreen(), name: PagesRoutes.signInRoute),
    GetPage(page: () => SignUpScreen(), name: PagesRoutes.signUpRoute),
  ];
}

abstract class PagesRoutes {
  static const String baseRoute = '/';
  static const String splashRoute = '/splash';
  static const String signInRoute = '/signin';
  static const String signUpRoute = '/signup';
}
