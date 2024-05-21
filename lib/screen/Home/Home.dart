import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:shopp/config/colour.dart';
import 'package:shopp/screen/Home/EmptyCart.dart';
import 'package:shopp/screen/Home/Search.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); // Đảm bảo khai báo biến này
  late AnimationController _controller;
  late Animation<Offset> _drawerSlideAnimation;

  @override
  void initState() {
    super.initState();
    print('Init state called');

    // Khởi tạo AnimationController
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    // Khởi tạo Tween và animate với CurvedAnimation
    _drawerSlideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(1.0, 0.0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    print('Controller and drawerSlideAnimation initialized');
  }

   void _handleDrawerClose()  {
     _controller.forward().then((_) {
      Navigator.pop(context);
       _controller.reverse();
     });
    
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateTo(String page) {
    print('Navigating to $page');
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => SecondPage(title: page)),
    // );
  }

  @override
  Widget build(BuildContext context) {
    print('Building widget tree');
    return Scaffold(
      key: _scaffoldKey, // Sử dụng _scaffoldKey trong Scaffold
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Palette.logo,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(FontAwesomeIcons.store, color: Colors.pink),
              onPressed: () {
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EmptyCart()),
                );
              },
            ),
          ],
        ),
        centerTitle: true,
      ),
      drawer: SlideTransition(
        position: _drawerSlideAnimation,
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.all(50),
            children: <Widget>[
              _buildDrawer(Icons.home, 'Home', () {
                _handleDrawerClose();
              }),
              _buildDrawer(Icons.shopping_bag, 'Sale', () {
                context.go('/sale');
              }),
              _buildDrawer(Icons.category, 'Mini', () {
                _navigateTo('Mini');
              }),
              _buildDrawer(Icons.health_and_safety, 'Skin Concerns', () {
                _navigateTo('Skin Concerns');
              }),
              _buildDrawer(Icons.shopping_cart, 'Cart', () {
                _navigateTo('Cart');
              }),
              _buildDrawer(Icons.receipt, 'Orders', () {
                _navigateTo('Orders');
              }),
              _buildDrawer(Icons.account_circle, 'Account', () {
                _navigateTo('Account');
              }),
              _buildDrawer(Icons.favorite, 'Wishlist', () {
                _navigateTo('Wishlist');
              }),
              _buildDrawer(Icons.notifications, 'Notifications', () {
                _navigateTo('Notifications');
              }),
              _buildDrawer(Icons.article, 'Blog', () {
                _navigateTo('Blog');
              }),
              _buildDrawer(Icons.attach_money, 'BY', () {
                _navigateTo('BY');
              }),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchPage()),
                  );
                },
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.pink[50],
                    borderRadius: BorderRadius.circular(200),
                  ),
                  child: IgnorePointer(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search Products',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        prefixIcon: Icon(Icons.search, color: Colors.grey),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text(
                      '15% OFF YOUR FIRST APP ORDER WITH CODE: HELLO15',
                      style: TextStyle(fontSize: 13.0, color: Colors.pink[600]),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'FREE UK DELIVERY ON ORDERS £35+',
                      style: TextStyle(fontSize: 13.0, color: Colors.pink[600]),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Image.asset('assets/images/cartoon.jpg'),
              Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildCategoryButton('cleansers'),
                      _buildCategoryButton('toners'),
                      _buildCategoryButton('serums'),
                      _buildCategoryButton('moisturizers'),
                      _buildCategoryButton('sunscreens'),
                      _buildCategoryButton('masks'),
                    ],
                  ),
                ),
              ),
              Image.asset('assets/images/cartoon2.jpg'),
              Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildCategory('lips'),
                      _buildCategory('eyes'),
                      _buildCategory('face'),
                      _buildCategory('cheeks'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryButton(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: Palette.cartoon,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide(color: Colors.grey),
          ),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        ),
        child: Text(text),
      ),
    );
  }

  Widget _buildCategory(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: Palette.cartoon2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide(color: Colors.grey),
          ),
          padding:const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        ),
        child: Text(text),
      ),
    );
  }

  Widget _buildDrawer(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.pinkAccent),
      title: Text(
        title,
        style: TextStyle(color: Colors.pinkAccent),
      ),
      onTap: onTap,
    );
  }
}
