
import 'package:flutter/material.dart';

class EmptyCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink[50],
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back, color: Colors.pinkAccent)),
          title: Text(
            "My Cart",
            style: TextStyle(color: Colors.pinkAccent),
          ),
          centerTitle: true,
        ),
        body: Center(
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
              // SizedBox(height: 20),
              // Text(
              //   "You have no items in your cart at the moment",
              //   textAlign: TextAlign.center,
              //   style: TextStyle(
              //     color: Colors.red,
              //     fontSize: 16,
              //   ),
              // ),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.pinkAccent,
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15)),
                  child: Text('Start Shopping', style: TextStyle(fontSize: 16)))
            ],
          ),
        )));
  }
}
