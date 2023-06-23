import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:graduation/models/model_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../components/appBar/reusableAppBar.dart';

class RateScreen extends StatefulWidget {
  static String rateScreenRoute = 'rate screen';

  @override
  _RateScreenState createState() => _RateScreenState();
}

class _RateScreenState extends State<RateScreen> {
  int rating = 0;

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<ModelProvider>(context).getUserData();
    int userId = userData!['user_id'];
    final rateApi = 'http://185.132.55.54:8000/rateapp/';
    // final String rateApi = 'http://185.132.55.54:8000/rateapp/';

    Future<void> sendRateMethod() async {
      Map<String, dynamic> data = {
        'rate': rating,
        'user_id': userId,
      };
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
      var response = await http.post(Uri.parse(rateApi),
          headers: headers, body: jsonEncode(data));
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        print(responseBody);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('The rate has arrived')),
        );
        print('${response.statusCode}');
      } else {
        print('Error: ${response.reasonPhrase}');
      }
    }

    return Scaffold(
      appBar: ReusableAppBar(
        leadingFunction: () {
          Navigator.pop(context);
        },
        title: 'Rate screen',
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  height: 300.0,
                  child: Image.asset('assets/rate_images/rate.png'),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Text(
                  'Rating: ${rating.toString()}',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                RatingBar.builder(
                  minRating: 1,
                  itemSize: 46,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4),
                  itemBuilder: (context, _) {
                    return Icon(
                      Icons.star,
                      color: Colors.amber,
                    );
                  },
                  onRatingUpdate: (rating) {
                    setState(() {
                      this.rating = rating.round();
                    });
                  },
                  updateOnDrag: true,
                ),
                SizedBox(
                  height: 30.0,
                ),
                Text(
                  'Please rate the app.',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  width: 165,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 5),
                        color: Colors.grey,
                        blurRadius: 3.0,
                      ),
                    ],
                    gradient: LinearGradient(
                      begin: Alignment.bottomRight,
                      colors: [
                        Colors.blue,
                        Colors.blue.shade900,
                      ],
                    ),
                  ),
                  child: TextButton(
                    onPressed: sendRateMethod,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          Text(
                            'Send Your Rate',
                            style: const TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ElevatedButton(
//   style: ElevatedButton.styleFrom(
//     backgroundColor: Colors.red[900], // background color
//     shape: RoundedRectangleBorder(
//       borderRadius:
//           BorderRadius.circular(10), // rounded corners
//     ),
//   ),
//   onPressed: sendRateMethod,
//   child: Text(
//     'Send Your Rate',
//     style: const TextStyle(
//       fontSize: 20.0,
//       color: Colors.white,
//       fontWeight: FontWeight.bold,
//     ),
//   ),
// ),

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:graduation/constants/colors.dart';
// import 'package:graduation/constants/colors.dart';
// import 'package:graduation/constants/colors.dart';
// import 'package:graduation/models/model_provider.dart';
// import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';
//
// import '../../../components/appBar/resaubleAppBar.dart';
//
// class RateScreen extends StatefulWidget {
//   const RateScreen({Key? key}) : super(key: key);
//   static String rateScreenRoute = 'rate screen';
//   @override
//   State<RateScreen> createState() => _RateScreenState();
// }
//
// class _RateScreenState extends State<RateScreen> {
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     final userData = Provider.of<ModelProvider>(context).getUserData();
//     int rating = 0;
//     int userId = userData['user_id'];
//     final String apiEndpoint = 'http://185.132.55.54:8000/rateapp/';
//     Future<void> sendPostRequest() async {
//       Map<String, dynamic> data = {
//         'rate': rating,
//         'user_id': userId,
//       };
//       Map<String, String> headers = {
//         'Content-type': 'application/json',
//         'Accept': 'application/json',
//       };
//       var response = await http.post(Uri.parse(apiEndpoint),
//           headers: headers, body: jsonEncode(data));
//       if (response.statusCode == 200) {
//         var responseBody = jsonDecode(response.body);
//         print(responseBody);
//         print('${response.statusCode}');
//       } else {
//         print('Error: ${response.reasonPhrase}');
//       }
//     }
//     return Scaffold(
//       appBar: ReusableAppBar(
//         leadingFunction: () {
//           Navigator.pop(context);
//         },
//         title: 'Rate',
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(10.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Column(
//               children: [
//                 SizedBox(
//                   height: 15.0,
//                 ),
//                 Text(
//                   'Rate the app',
//                   style: TextStyle(
//                     color: defBlue,
//                     fontSize: 50.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 30.0,
//                 ),
//                 Container(
//                   height: 200.0,
//                   child: Image.asset('assets/rate_images/rate.png'),
//                 ),
//                 SizedBox(
//                   height: 40,
//                 ),
//                 Text(
//                   'Rating: ${rating.toString()}',
//                   style: TextStyle(
//                     fontSize: 40,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 30,
//                 ),
//                 RatingBar.builder(
//                   minRating: 1,
//                   itemSize: 46,
//                   itemPadding: EdgeInsets.symmetric(horizontal: 4),
//                   itemBuilder: (context, _) => Icon(
//                     Icons.star,
//                     color: Colors.amber,
//                   ),
//                   onRatingUpdate: (rating) => setState(() {
//                     this.rating = rating.round();
//                   }),
//                   updateOnDrag: true,
//                 ),
//                 SizedBox(
//                   height: 15,
//                 ),
//                 Text(
//                   'Please rate the app.',
//                   style: TextStyle(
//                     fontSize: 25,
//                     color: Colors.green,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: sendPostRequest,
//                   child: Text('Send Your Rate'),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
