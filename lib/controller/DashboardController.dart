import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutterdemo/APIControl/APIService.dart';
import 'package:flutterdemo/Models/Welcome.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController{
  final apiService = Get.find<APIService>();
  RxString title = RxString("GetxDemo");
  RxList<Welcome> welcomeEntries = RxList([]);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Future.delayed(const Duration(microseconds: 100), () async{
      //Direct List To call this
      final response = await http.get(Uri.parse("https://api.restful-api.dev/objects"));
      final statusCode = response.statusCode;
      if (statusCode == 200) {
        List<dynamic> body = json.decode(response.body);
        welcomeEntries.value = body.map((json) => Welcome.fromJson(json)).toList();
        print(welcomeEntries.value.length);

      }
    });
  }


  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}