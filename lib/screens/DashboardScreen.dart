import 'package:flutter/material.dart';
import 'package:flutterdemo/controller/DashboardController.dart';
import 'package:flutterdemo/screens/DashboardDetail.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX<DashboardController>(
        init: DashboardController(),
        builder: (dashboardController) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(itemBuilder: (context, index){
                  return GestureDetector(
                    onTap: (){Get.to(()=> DashboardDetail());
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(dashboardController.welcomeEntries[index].name??''),
                    ),
                  );
                },
                itemCount: dashboardController.welcomeEntries.length,),
              ),
            ],
          );
        }
      ),
    );
  }
}
