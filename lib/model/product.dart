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
  
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      price: json['price'].toDouble(),
      imageUrl: json['imageUrl'],
    );
  }
}
class ProductCategory {
  final String title;
  final List<Product> products;

  ProductCategory({
    required this.title,
    required this.products,
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    var list = json['products'] as List;
    List<Product> productList = list.map((i) => Product.fromJson(i)).toList();

    return ProductCategory(
      title: json['title'],
      products: productList,
    );
  }
}
