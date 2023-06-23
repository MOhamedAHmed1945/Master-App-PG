class NeverSalesProduct {
  final String name;
  final dynamic price;
  final String image;
  final int stock;

  NeverSalesProduct({
    required this.name,
    required this.price,
    required this.image,
    required this.stock,
  });

  factory NeverSalesProduct.fromJson(Map<String, dynamic> json) {
    return NeverSalesProduct(
      name: json['pro_name'],
      price: json['price'].toInt(),
      image: json['image'],
      stock: json['stock'],
    );
  }
}