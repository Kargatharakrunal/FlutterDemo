import 'package:flutterdemo/APIControl/APIService.dart';
import 'package:flutterdemo/Models/Detailmodel.dart';
import 'package:get/get.dart';

class DashboardDetailController extends GetxController{
  final apiService = Get.find<APIService>();
  Rx<Welcomes> detailsData = Rx<Welcomes>(Welcomes());
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Future.delayed(const Duration(microseconds: 100), () async{
      Data addData= Data();
      addData.year = 2020;
      Details modelpayload = Details();
      modelpayload.name ="Appless";
      modelpayload.data = addData;
      print(modelpayload.toJson());
      Welcomes? model = await apiService.postdata(bodyData: modelpayload);
      detailsData.value = model!;

    });
  }
}