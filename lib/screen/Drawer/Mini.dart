import 'package:flutter/material.dart';
import 'package:shopp/config/ingredient.dart';
import 'package:shopp/model/listItems.dart';
import 'package:shopp/screen/Home/EmptyCart.dart'; // Import CustomDrawer

class Minipage extends StatefulWidget {
  final List<ListItem> listitems;
  const Minipage({super.key, required this.listitems});
  @override
  // ignore: library_private_types_in_public_api
  _MinipageState createState() => _MinipageState();
}

final List<ListItem> listitems = [
  ListItem(
    name: '[Im From] Honey Mask 30g',
    price: 39.00,
    originalPrice: 44.00,
    imageURL: 'assets/images/Honey Mask Mini.jpg',
  ),
  ListItem(
    name: '[Im From] Honey Mask 30g',
    price: 35.00,
    originalPrice: 44.00,
    imageURL: 'assets/images/Honey Mask Mini.jpg',
  ),
  ListItem(
    name: '[Im From] Honey Mask 30g',
    price: 28.00,
    originalPrice: 33.00,
    imageURL: 'assets/images/Honey Mask Mini.jpg',
  ),
  ListItem(
    name: '[Im From] Honey Mask 30g',
    price: 20.00,
    originalPrice: 25.00,
    imageURL: 'assets/images/Honey Mask Mini.jpg',
  ),
  ListItem(
    name: '[Im From] Honey Mask 30g',
    price: 20.00,
    originalPrice: 25.00,
    imageURL: 'assets/images/Honey Mask Mini.jpg',
  ),
   ListItem(
    name: '[Im From] Honey Mask 30g',
    price: 20.00,
    originalPrice: 25.00,
    imageURL: 'assets/images/Honey Mask Mini.jpg',
  ),
  
];

class _MinipageState extends State<Minipage> with SingleTickerProviderStateMixin {
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

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 0.7,
        ),
        itemCount: widget.listitems.length,
        itemBuilder: (context, index) {
          return _buildProductCard(widget.listitems[index]);
        },
      ),
    );
  }

  Widget _buildProductCard(ListItem listitem) {
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
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                  image: AssetImage(listitem.imageURL),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 2), // changes position of shadow
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  listitem.name,
                  style: const TextStyle(fontSize: 14.0),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4.0),
                Row(
                  children: [
                    Text(
                      '\$${listitem.price}',
                      style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      '\$${listitem.originalPrice}',
                      style: const TextStyle(
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(Icons.favorite_border),
                    onPressed: () {
                      // Add to favorites functionality
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
        titleText: 'MINI',
        onMenuPressed: () {
          _scaffoldKey.currentState?.openDrawer();
        },
        onCartPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EmptyCart()),
          );
        },
        showStoreButton: true,
        showShoppingBasketButton: true,

      ),

      drawer: CustomDrawer(
        drawerSlideAnimation: _drawerSlideAnimation,
        onClose: _handleDrawerClose,
      ),

      body: _buildBody(),
    );
  }
}
