import 'package:flutter/material.dart';
import 'package:shopp/config/ingredient.dart';
 // Import CustomDrawer

class CartPage extends StatefulWidget {

  @override
  // ignore: library_private_types_in_public_api
  _CartPageState createState() => _CartPageState();
}


class _CartPageState extends State<CartPage> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late AnimationController _controller;
  late Animation<Offset> _drawerSlideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _drawerSlideAnimation = Tween<Offset>(
       begin: Offset.zero,
      end: Offset(1.0, 0.0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  void _handleDrawerClose() {
    _controller.forward().then((_) {
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
      _controller.reverse();
    });
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        titleText: 'MY CART',
        onMenuPressed: () {
          _scaffoldKey.currentState?.openDrawer();
        },
        showStoreButton: true,
        showShoppingBasketButton: false,
      ),
      drawer: CustomDrawer(
        drawerSlideAnimation: _drawerSlideAnimation,
        onClose: _handleDrawerClose,
      ),
      body: EmptyCartBody(),
    );
  }
}
