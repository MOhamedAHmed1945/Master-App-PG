import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../../../components/appBar/reusableAppBar.dart';
import '../../../../../components/items/custom_item_report_show_data.dart';
import '../../../../../models/reports/never_sales_product_model.dart';

Future<Map<String, dynamic>> fetchData() async {
  final response = await http
      .get(Uri.parse('http://185.132.55.54:8000/lowestsellingproduts/'));
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load data');
  }
}

List<NeverSalesProduct> parseProducts(dynamic responseBody) {
  final parsed =
      responseBody['data']['products_not_sold'].cast<Map<String, dynamic>>();
  return parsed
      .map<NeverSalesProduct>((json) => NeverSalesProduct.fromJson(json))
      .toList();
}

class NeverSellingReportScreen extends StatefulWidget {
  static String neverSellingReportScreenRoute = 'never selling report screen';
  @override
  _NeverSellingReportScreenState createState() =>
      _NeverSellingReportScreenState();
}

class _NeverSellingReportScreenState extends State<NeverSellingReportScreen> {
  late Future<Map<String, dynamic>> _futureData;

  @override
  void initState() {
    super.initState();
    _futureData = fetchData();
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
        title: 'Never Selling',
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _futureData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final neverSalesProducts = parseProducts(snapshot.data!);
            //final lowSalesProducts = parseLowSalesProducts(snapshot.data!);
            return ListView.builder(
                shrinkWrap: true,
                itemCount: neverSalesProducts.length,
                itemBuilder: (BuildContext context, int index) {
                  return CustomItemReportShowData(
                    leading: neverSalesProducts[index].image,
                    subtitle:
                        '\$ ${neverSalesProducts[index].price}'.toString(),
                    title: neverSalesProducts[index].name,
                    valueData: '${neverSalesProducts[index].stock} In Stock'
                        .toString(),
                  );
                });
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error loading low selling products'),
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
