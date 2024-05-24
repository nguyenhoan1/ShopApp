import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:shopp/Locator/locator.dart';
import 'package:shopp/screen/Home/EmptyCart.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import locator to get SharedPreferences

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;
  final Function()? onMenuPressed;
  final Function()? onCartPressed;
  final bool showStoreButton;
  final bool showShoppingBasketButton;

  CustomAppBar({
    required this.titleText,
    this.onMenuPressed,
    this.onCartPressed,
    this.showStoreButton = true,
    this.showShoppingBasketButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (showStoreButton)
            IconButton(
              icon: Icon(FontAwesomeIcons.store, color: Colors.pink),
              onPressed: onMenuPressed,
            )
          else
            SizedBox(width: 50), // Placeholder to keep title centered
          Text(
            titleText,
            style: TextStyle(color: Colors.pinkAccent, fontSize: 25),
          ),
          if (showShoppingBasketButton)
            IconButton(
              icon: Icon(FontAwesomeIcons.shoppingBasket, color: Colors.pink),
              onPressed: onCartPressed,
            )
          else
            SizedBox(width: 50), // Placeholder to keep title centered
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
  final SharedPreferences _prefs = locator<SharedPreferences>(); // Access SharedPreferences via locator

  Widget _buildDrawer(IconData icon, String title, String route) {
    return ListTile(
      leading: Icon(icon, color: Colors.pinkAccent),
      title: Text(title, style: const TextStyle(color: Colors.pinkAccent)),
      onTap: () => _navigateTo(route),
    );
  }

  Future<void> _navigateTo(String route) async {
    await widget.onClose();
    context.go(route);
  }

  @override
  void initState() {
    super.initState();
    // Example of using SharedPreferences
    String lastVisited = _prefs.getString('last_visited') ?? 'None';
    print('Last visited page: $lastVisited');
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: widget.drawerSlideAnimation,
      child: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(50),
          children: <Widget>[
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

class EmptyCartBody extends StatelessWidget {
  const EmptyCartBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.shopping_bag_outlined,
              color: Colors.grey[300],
              size: 100.0,
            ),
            SizedBox(height: 20),
            Text(
              "YOUR CART IS EMPTY",
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.pinkAccent,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: Text('Start Shopping', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderBody extends StatelessWidget {
  const OrderBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.indeterminate_check_box_outlined,
              color: Colors.grey[300],
              size: 100.0,
            ),
            SizedBox(height: 20),
            Text(
              "No Orders",
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.go('/home');
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.pinkAccent,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: Text('Start Shopping', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}



