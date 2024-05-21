import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:shopp/config/colour.dart';
import 'package:shopp/screen/Home/EmptyCart.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
   final String title;
   final Function()? onMenuPressed;
   final Function()? onCartPressed;

   CustomAppBar({
    required this.title, 
    this.onMenuPressed, 
    this.onCartPressed});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); // Đảm bảo khai báo biến này
    @override
    Widget build(BuildContext context) {
      return AppBar(
        key: _scaffoldKey,
        automaticallyImplyLeading: false,
        backgroundColor: Palette.logo,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(FontAwesomeIcons.store, color: Colors.pink),
              onPressed: onMenuPressed ?? () {
              _scaffoldKey.currentState?.openDrawer();
              },
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Image.asset(
                'assets/images/Logo.png',
                height: 130,
              ),
            ),
            IconButton(
              icon: Icon(FontAwesomeIcons.shoppingBasket, color: Colors.pink),
              onPressed: onCartPressed ?? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EmptyCart()),
                );
              },
            ),
          ],
        ),
        centerTitle: true,
      );
  }
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class CustomDrawer extends StatefulWidget {
  final Animation<Offset> drawerSlideAnimation;
  final Function onClose;

  CustomDrawer({
    required this.drawerSlideAnimation,
    required this.onClose,
  });

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  Widget _buildDrawer(IconData icon, String title, String route) {
    return ListTile(
      leading: Icon(icon, color: Colors.pinkAccent),
      title: Text(title, style: TextStyle(color: Colors.pinkAccent)),
      onTap: () => _navigateTo(route),
    );
  }

  Future<void> _navigateTo(String route) async {
    await widget.onClose();
    context.go(route);
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: widget.drawerSlideAnimation,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            _buildDrawer(Icons.home, 'Home', '/home'),
            _buildDrawer(Icons.shopping_bag, 'Sale', '/sale'),
            _buildDrawer(Icons.category, 'Mini', '/mini'),
            _buildDrawer(Icons.health_and_safety, 'Skin Concerns', '/skin-concerns'),
            _buildDrawer(Icons.shopping_cart, 'Cart', '/cart'),
            _buildDrawer(Icons.receipt, 'Orders', '/orders'),
            _buildDrawer(Icons.account_circle, 'Account', '/account'),
            _buildDrawer(Icons.favorite, 'Wishlist', '/wishlist'),
            _buildDrawer(Icons.notifications, 'Notifications', '/notifications'),
            _buildDrawer(Icons.article, 'Blog', '/blog'),
            _buildDrawer(Icons.attach_money, 'BY', '/by'),
          ],
        ),
      ),
    );
  }
}