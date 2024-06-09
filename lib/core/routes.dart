import 'package:flutter_application_2/screens/client/SplashScreen.dart';
import 'package:flutter_application_2/screens/static/preview.dart';
import 'package:flutter_application_2/urunler/fotograf.dart';
import 'package:flutter_application_2/urunler/gamepad.dart';
import 'package:flutter_application_2/urunler/kulakl%C4%B1k.dart';
import 'package:flutter_application_2/urunler/leptop.dart';
import 'package:flutter_application_2/urunler/monitor.dart';
import 'package:go_router/go_router.dart';

import '../screens/client/login.dart';
import '../screens/client/profile.dart';
import '../screens/client/register.dart';
import '../screens/core/error.dart';
import '../screens/core/loader.dart';
import '../screens/core/settings.dart';
import '../screens/home.dart';
import '../screens/payment/payment.dart';
import '../screens/product/cart.dart';
import '../screens/product/categories.dart';
import '../screens/product/favorites.dart';
import '../screens/product/products.dart';
import '../screens/product/search.dart';
import '../screens/static/about.dart';
import '../screens/static/boarding.dart';
import '../screens/static/contact.dart';
import '../urunler/17.dart';
import '../urunler/computer.dart';
import '../urunler/telephone.dart';

final routes = GoRouter(
  errorBuilder: (context, state) => const ErrorScreen(),
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoaderScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: '/boarding',
      builder: (context, state) => const BoardingScreen(),
    ),
    GoRoute(
      path: '/categories',
      builder: (context, state) => CategoriesScreen(),
    ),
    GoRoute(
      path: '/product/17',
      builder: (context, state) => deneme(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(email: '',),
    ),
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/leptop',
      builder: (context, state) => const LeptopScreen(),
    ),
    GoRoute(
      path: '/kulaklik',
      builder: (context, state) => const KulaklikScreen(),
    ),
    GoRoute(
      path: '/gamepad',
      builder: (context, state) => const GamepadScreen(),
    ),
    GoRoute(
      path: '/camera',
      builder: (context, state) => const FotografScreen(),
    ),
    GoRoute(
      path: '/monitor',
      builder: (context, state) => const MonitorScreen(),
    ),
    GoRoute(
      path: '/computer',
      builder: (context, state) => const ComputerScreen(),
    ),
    GoRoute(
      path: '/about',
      builder: (context, state) => const AboutScreen(),
    ),
    GoRoute(
      path: '/contact',
      builder: (context, state) => ContactScreen(),
    ),
    GoRoute(
      path: '/telephone',
      builder: (context, state) => const TelephoneScreen(),
    ),
    GoRoute(
      path: "/products",
      builder: (context, state) => const ProductsScreen(),
    ),
    GoRoute(
      path: '/search',
      builder: (context, state) => const SearchScreen(),
    ),
    GoRoute(
      path: '/favorites',
      builder: (context, state) => const FavoritesScreen(),
    ),
    GoRoute(
      path: '/cart',
      builder: (context, state) => const CartScreen(),
    ),
    GoRoute(
      path: '/preview',
      builder: (context, state) => const PreviewScreen(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginRegisterScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => RegisterScreen(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(email: '',),
    ),
    GoRoute(
      path: '/payment',
      builder: (context, state) => const PaymentScreen(),
    ),
  ],
);
