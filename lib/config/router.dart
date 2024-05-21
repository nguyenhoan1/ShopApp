
import 'package:go_router/go_router.dart';
import 'package:shopp/main.dart';
import 'package:shopp/screen/Drawer/Sale.dart';
import 'package:shopp/screen/Home/Home.dart';

// Định nghĩa GoRouter
final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => MyHomePage(title: '',),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
      path: '/sale',
      builder: (context, state) => SalePage(),
    ),
  ],
);
