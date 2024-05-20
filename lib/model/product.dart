class Product {
  final String imageUrl;
  final String name;
  final String price;
  final String? oldPrice;

  Product({
    required this.imageUrl,
    required this.name,
    required this.price,
    this.oldPrice,
     
  });
}
