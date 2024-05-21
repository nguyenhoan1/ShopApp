import 'package:flutter/material.dart';
import 'package:shopp/config/ingredient.dart';
import 'package:shopp/screen/Home/EmptyCart.dart'; // Import CustomDrawer

class SalePage extends StatefulWidget {
  @override
  _SalePageState createState() => _SalePageState();
}

class _SalePageState extends State<SalePage> with SingleTickerProviderStateMixin {
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
      Navigator.pop(context);
      _controller.reverse();
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose AnimationController when widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        title: 'SALE',
        onMenuPressed: () {
          _scaffoldKey.currentState?.openDrawer();
        },
        onCartPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EmptyCart()),
          );
        },
      ),
      drawer: CustomDrawer(
        drawerSlideAnimation: _drawerSlideAnimation,
        onClose: _handleDrawerClose,
      ),
      body: Center(
        child: Text('Sale'),
      ),
    );
  }
}
