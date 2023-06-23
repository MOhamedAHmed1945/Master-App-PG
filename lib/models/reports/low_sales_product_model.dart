class LowSalesProduct {
  final String name;
  final dynamic price;
  final String image;
  final int totalSales;

  LowSalesProduct({
    required this.name,
    required this.price,
    required this.image,
    required this.totalSales,
  });

  factory LowSalesProduct.fromJson(Map<String, dynamic> json) {
    return LowSalesProduct(
      name: json['pro_name'],
      price: json['price'].toInt(),
      image: json['image'],
      totalSales: json['total_sales'],
    );
  }
}
