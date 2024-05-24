import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shopp/main.dart';
import 'package:shopp/screen/Drawer/Account.dart';
import 'package:shopp/screen/Drawer/Cart.dart';
import 'package:shopp/screen/Drawer/Mini.dart' as mini;
import 'package:shopp/screen/Drawer/Order.dart';
import 'package:shopp/screen/Drawer/Sale.dart' as sale;
import 'package:shopp/screen/Drawer/SkinConcerns.dart';
import 'package:shopp/screen/Home/Home.dart';

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
      builder: (context, state) => sale.SalePage(listitems: sale.listitems),
    ),
    GoRoute(
      path: '/mini',
      builder: (context, state) => mini.Minipage(listitems: mini.listitems),
    ),
    GoRoute(
      path: '/skin-concerns',
      builder: (context, state) => SkinConcernsPage(),
    ),
     GoRoute(
      path: '/cart',
      builder: (context, state) => CartPage(),
    ),
    GoRoute(
      path: '/orders',
      builder: (context, state) => OrderPage(),
    ),
    GoRoute(
      path: '/account',
      builder: (context, state) => AccountScreen(),
    ),
    
  ],
);
