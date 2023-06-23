class SafetyLimitProduct {
  String proName;
  String productCode;
  String image;
  int stock;
  String expDate;

  SafetyLimitProduct({
    required this.proName,
    required this.productCode,
    required this.image,
    required this.stock,
    required this.expDate,
  });

  factory SafetyLimitProduct.fromJson(Map<String, dynamic> json) {
    return SafetyLimitProduct(
      proName: json['pro_name'],
      productCode: json['product_code'],
      image: 'http://185.132.55.54:8000/${json['image']}',
      stock: json['stock'],
      expDate: json['exp_date'],
    );
  }
}
