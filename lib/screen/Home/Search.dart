import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:shopp/model/product.dart';
import 'package:shopp/screen/Home/EmptyCart.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Search Products",
          style: TextStyle(color: Colors.pinkAccent),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.0,
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.pinkAccent),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.pinkAccent),
            onPressed: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EmptyCart()),
              );
            },
          ),
        ],
      ),
      body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search_sharp, color: Colors.black12),
                  hintText: "Search Products",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide.none),
                  filled: true,
                  fillColor: Colors.pink[50],
                ),
              ),
              Divider(),
              SizedBox(height: 16.0),
              Wrap(spacing: 8, children: <Widget>[
                Chip(
                  label: Text('ISOI'),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: Colors.pinkAccent,
                      width: 1.0,
                    ),
                    )
                ),
                Chip(
                  label: Text('NEW'),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: Colors.pinkAccent,
                      width: 1.0,
                    ),
                    )
                ),
                Chip(
                  label: Text('SHOP THE RESTOCK'),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: Colors.pinkAccent,
                      width: 1.0,
                    ),
                    )
                ),
              ]),
              Divider(),
              SizedBox(height: 16.0),
              Text('Products',
                  style: TextStyle(
                    color: Colors.pinkAccent,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  )),
              Expanded(
                child: ListView(children: <Widget>[
                  ProductItem(
                      product: Product(
                    imageUrl: 'assets/images/product1.jpg',
                    name: '[ISOI] Blemish Care Up Cream ',
                    price: '\$70.00',
                  )),
                  ProductItem(
                      product: Product(
                    imageUrl: 'assets/images/product1.jpg',
                    name: '[ISOI] Blemish Care Up Cream 55ml',
                    price: '\$80.00',
                    oldPrice: '\$100.00',
                  )),
                  ProductItem(
                      product: Product(
                    imageUrl: 'assets/images/product1.jpg',
                    name: '[ISOI] Blemish Care Up Cream 130ml',
                    price: '\$120.00',
                    oldPrice: '\$150.00',
                  )),
                  ProductItem(
                      product: Product(
                    imageUrl: 'assets/images/product1.jpg',
                    name: '[ISOI] Blemish Care Up Cream 15ml',
                    price: '\$30.00',
                  )),
                ]),
              )
            ],
          )),
    );
  }
}

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: <Widget>[
          Image.asset(
            product.imageUrl,
            height: 60,
            width: 60,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 16),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                product.name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(product.price,
                  style: TextStyle(fontSize: 16, color: Colors.pinkAccent)),
              if (product.oldPrice != null && product.oldPrice!.isNotEmpty) ...[
              SizedBox(height: 4),
              Text(product.oldPrice!,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough)),]
            ],
          )),
        ],
      ),
    );
  }
}
