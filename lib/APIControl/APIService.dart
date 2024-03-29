import 'dart:convert';
import 'dart:io';

import 'package:flutterdemo/Models/Detailmodel.dart';
import 'package:flutterdemo/Models/Welcome.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../controller/connectivityChecker.dart';

class APIService extends GetxService{

  String getUrl = "https://api.restful-api.dev/objects";
  String postUrl = "https://api.restful-api.dev/objects";

  ///getMethod
  Future<Welcome?> getUrlDATA() async {
    return get(url: getUrl).then((http.Response response) {
      print("true");
      return Welcome.fromRawJson(response.body);
    }).catchError((err) {
      print("error");
      return Welcome();
    });
  }
///post method
  Future<Welcomes?> postdata({required Details bodyData}) async {
    return post(url: postUrl, body: bodyData.toMap()).then((http.Response response) {
      return Welcomes.fromJson(response.body);
    }).catchError((err) {
      return Welcomes();
    });
  }



}

Future<http.Response> post({required String url, required Map<String, dynamic>? body}) async {
  print("======================= POST =====================");
  print("Api : $url");
  print("header : ${jsonEncode({
    "Content-Type": "application/json",
    // if (authToken.isNotEmpty) "Authorization": authToken,
  })}");
  print("body : ${jsonEncode(body)}");
  print("==================================================");
  if (await ConnectivityChecker().checkConnectivity()) {
    try {
      return http
          .post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            // if (authToken.isNotEmpty) "Authorization": authToken,
          },
          body: jsonEncode(body))
          .timeout(const Duration(minutes: 1), onTimeout: () {
        Future.delayed(const Duration(milliseconds: 10), () {
          print("Connection Time Out");
        });
        return http.Response("Connection Time-out", 504);
      }).then((http.Response response) {
        print("=================== RESPONSE =====================");
        print("Api : $url");
        print("Status Code : ${response.statusCode}");
        print("Body data : ${response.body}");
        print("==================================================");
        return response;
      });
    } on SocketException {
      return http.Response("", 500);
    }
  }else {
    throw Exception('No internet Connection');
  }
}

Future<http.Response> get({required String url}) async {
  

  print("======================= GET =====================");
  print("Api : $url");
  print("header : ${jsonEncode({
    "Content-Type": "application/json",
    // if (authToken.isNotEmpty) "Authorization": "Bearer $authToken",
    })}");
  print("==================================================");
  if (await ConnectivityChecker().checkConnectivity()) {
    try {
      return http.get(Uri.parse(url), headers: {
        "Content-Type": "application/json",
        // if (authToken.isNotEmpty) "Authorization": "Bearer $authToken",
      }).timeout(const Duration(minutes: 1), onTimeout: () {
        Future.delayed(const Duration(milliseconds: 10), () {
          print("Connection Time Out");
        });
        return http.Response("Gateway Time-out", 504);
      }).then((http.Response response) {
        print("=================== RESPONSE =====================");
        print("Api : $url");
        print("Status Code : ${response.statusCode}");
        print("Body data : ${response.body}");
        print("==================================================");


          return response;
      });
    } on SocketException {
      return http.Response("", 500);
    }
  } else {
    throw Exception('No internet Connection');
  }
}