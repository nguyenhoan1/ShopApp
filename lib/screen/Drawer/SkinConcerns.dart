import 'package:flutter/material.dart';
import 'package:shopp/config/ingredient.dart';
import 'package:shopp/screen/Home/EmptyCart.dart';
import 'package:shopp/screen/Home/Search.dart'; 

class SkinConcernsPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _SkinConcernsPageState createState() => _SkinConcernsPageState();
}

 final List<String> items = [
    "acne prone",
    "blackheads",
    "redness",
    "combination",
    "dry",
    "oily",
    "sensitive",
  ];

class _SkinConcernsPageState extends State<SkinConcernsPage> with SingleTickerProviderStateMixin {
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
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        gradient: LinearGradient(
                          colors: [Colors.pink[100]!, Colors.pink[50]!],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: ListTile(
                        title: Center(
                          child: Text(
                            items[index],
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
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
        titleText: 'Skin Concerns',
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
