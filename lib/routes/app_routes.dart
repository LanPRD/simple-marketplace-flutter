import 'package:get/route_manager.dart';
import 'package:greengrocer/screens/auth/views/sign_in_screen.dart';
import 'package:greengrocer/screens/auth/views/sign_up_screen.dart';
import 'package:greengrocer/screens/base/binding/navigation_binding.dart';
import 'package:greengrocer/screens/base/views/base_screen.dart';
import 'package:greengrocer/screens/cart/binding/cart_binding.dart';
import 'package:greengrocer/screens/product/product_screen.dart';
import 'package:greengrocer/screens/splash_screen.dart';
import 'package:greengrocer/screens/home/bindings/home_binding.dart';

abstract class AppPages {
  static final pages = <GetPage>[
    GetPage(page: () => ProductScreen(), name: PagesRoutes.productRoute),
    GetPage(page: () => const SplashScreen(), name: PagesRoutes.splashRoute),
    GetPage(
      page: () => const BaseScreen(),
      name: PagesRoutes.baseRoute,
      bindings: [
        NavigationBinding(),
        HomeBinding(),
        CartBinding(),
      ],
    ),
    GetPage(page: () => SignInScreen(), name: PagesRoutes.signInRoute),
    GetPage(page: () => SignUpScreen(), name: PagesRoutes.signUpRoute),
  ];
}

abstract class PagesRoutes {
  static const String productRoute = '/product';
  static const String baseRoute = '/';
  static const String splashRoute = '/splash';
  static const String signInRoute = '/signin';
  static const String signUpRoute = '/signup';
}
