class BestSellingProduct {
  String proName;
  String image;
  int sales;
  dynamic price;

  BestSellingProduct({
    required this.proName,
    required this.price,
    required this.sales,
    required this.image,
  });

  factory BestSellingProduct.fromJson(Map<String, dynamic> json) {
    return BestSellingProduct(
      proName: json['pro_name'],
      sales: json['sales'],
      image: 'http://185.132.55.54:8000/${json['image']}',
      price: json['price'].toInt(),
    );
  }
}