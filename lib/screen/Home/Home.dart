import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:shopp/Service/product_service.dart';
import 'package:shopp/config/colour.dart';
import 'package:shopp/model/product.dart';
import 'package:shopp/screen/Home/EmptyCart.dart';
import 'package:shopp/screen/Home/Search.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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

  void _handleDrawerClose() {
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
      key: _scaffoldKey,
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
            padding: const EdgeInsets.all(50),
            children: <Widget>[
              _buildDrawer(Icons.home, 'Home', () {
                _handleDrawerClose();
              }),
              _buildDrawer(Icons.shopping_bag, 'Sale', () {
                // Navigate to Sale
              }),
              _buildDrawer(Icons.category, 'Mini', () {
                // Navigate to Mini
              }),
              _buildDrawer(Icons.health_and_safety, 'Skin Concerns', () {
                // Navigate to Skin Concerns
              }),
              _buildDrawer(Icons.shopping_cart, 'Cart', () {
                // Navigate to Cart
              }),
              _buildDrawer(Icons.receipt, 'Orders', () {
                // Navigate to Orders
              }),
              _buildDrawer(Icons.account_circle, 'Account', () {
                // Navigate to Account
              }),
              _buildDrawer(Icons.favorite, 'Wishlist', () {
                // Navigate to Wishlist
              }),
              _buildDrawer(Icons.notifications, 'Notifications', () {
                // Navigate to Notifications
              }),
              _buildDrawer(Icons.article, 'Blog', () {
                // Navigate to Blog
              }),
              _buildDrawer(Icons.attach_money, 'BY', () {
                // Navigate to BY
              }),
            ],
          ),
        ),
      ),
      body: FutureBuilder<List<ProductCategory>>(
        future: fetchProductCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No categories found'));
          } else {
            final productCategories = snapshot.data!;
            return SingleChildScrollView(
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
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.pink[50],
                          borderRadius: BorderRadius.circular(200),
                        ),
                        child: const IgnorePointer(
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
                          children: productCategories.map((category) {
                            return _buildCategoryButton(category);
                          }).toList(),
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
            );
          }
        },
      ),
    );
  }

  Widget _buildCategoryButton(ProductCategory category) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductPage(
                title: category.title,
                products: category.products,
              ),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: Palette.cartoon,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: const BorderSide(color: Colors.grey),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        ),
        child: Text(category.title),
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
            side: const BorderSide(color: Colors.grey),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
        style: const TextStyle(color: Colors.pinkAccent),
      ),
      onTap: onTap,
    );
  }
}

class ProductPage extends StatelessWidget {
  final String title;
  final List<Product> products;

  ProductPage({required this.title, required this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: TextStyle(color: Colors.pink)),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.pink),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // TODO: Add sort functionality
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.pink, backgroundColor: Colors.pink[50],
                  ),
                  child: Text('SORT'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // TODO: Add filter functionality
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.pink, backgroundColor: Colors.pink[50],
                  ),
                  child: Text('FILTER'),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.7,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return _buildProductCard(products[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(Product product) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 4.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
                image: DecorationImage(
                  image: AssetImage(product.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(fontSize: 14.0),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4.0),
                Text(
                  '\$${product.price}',
                  style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(Icons.favorite_border),
                    onPressed: () {
                      // TODO: Add to favorites functionality
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
