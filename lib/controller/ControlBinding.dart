import 'package:flutterdemo/APIControl/APIService.dart';
import 'package:get/get.dart';

class ControlBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<APIService>(APIService());
  }

}