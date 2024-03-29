import 'package:flutter/material.dart';
import 'package:flutterdemo/controller/DashboradDetailController.dart';
import 'package:get/get.dart';

class DashboardDetail extends StatelessWidget {
  const DashboardDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX<DashboardDetailController>(
        init: DashboardDetailController(),
        builder: (detailControl) {
          return Container(
            child: Text(detailControl.detailsData.value.name??''),
          );
        }
      ),
    );
  }
}
