import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:graduation/models/reports/safety_limit_product_model.dart';
import 'package:http/http.dart' as http;
import '../../../../../components/appBar/reusableAppBar.dart';
import '../../../../../components/items/custom_item_report_show_data.dart';

class ApiService {
  static const String apiUrl = 'http://185.132.55.54:8000/stockreportact/';

  static Future<List<SafetyLimitProduct>> getSafetyLimitProduct() async {
    var response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<dynamic> productsJson = data['low_stock_products'];
      return productsJson
          .map((productJson) => SafetyLimitProduct.fromJson(productJson))
          .toList();
    } else {
      throw Exception('Failed to load expired products');
    }
  }
}

class SafetyLimitReportScreen extends StatefulWidget {
  static String saftyLimitReportScreenRoute = 'safty Limit report screen';

  @override
  _SafetyLimitReportScreenState createState() => _SafetyLimitReportScreenState();
}

class _SafetyLimitReportScreenState extends State<SafetyLimitReportScreen> {
  late Future<List<SafetyLimitProduct>> _expiredProductsFuture;

  @override
  void initState() {
    super.initState();
    _expiredProductsFuture = ApiService.getSafetyLimitProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableAppBar(
        leadingFunction: () {
          // Navigator.pushNamedAndRemoveUntil(context,
          //     MainReportsScreen.mainReportsScreenRoute, (route) => false);
          Navigator.pop(context);

        },
        title: 'Safety Limit',
      ),
      body: FutureBuilder<List<SafetyLimitProduct>>(
        future: _expiredProductsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<SafetyLimitProduct> expiredProducts = snapshot.data!;
            return ListView.builder(
              itemCount: expiredProducts.length,
              itemBuilder: (context, index) {
                SafetyLimitProduct product = expiredProducts[index];
                return CustomItemReportShowData(
                  leading: product.image,
                  subtitle:
                      'Expired In ${product.expDate}       Product Code ${product.productCode}',
                  title: product.proName,
                  valueData: '${product.stock} In Stock',
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error loading expired products'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
