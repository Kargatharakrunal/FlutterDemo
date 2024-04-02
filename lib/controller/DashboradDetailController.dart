import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutterdemo/APIControl/APIService.dart';
import 'package:flutterdemo/Models/Detailmodel.dart';
import 'package:get/get.dart';

import '../screens/DashboardDetail.dart';

class DashboardDetailController extends GetxController{
  final apiService = Get.find<APIService>();
  Rx<Welcomes> detailsData = Rx<Welcomes>(Welcomes());
  DatabaseReference database = FirebaseDatabase.instance.reference();
  RxList<Item> items = RxList();
  RxString newItemKey= RxString("");
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
      fetchItems();

    });
  }

  // fetchItems() {
  //   database.child('items').once().then((DataSnapshot snapshot) {
  //     Map<dynamic, dynamic> values = snapshot.value;
  //     values.forEach((key, value) {
  //       items.add(Item(key, value['name']));
  //     });
  //     update();
  //   });
  // }

   createOperation(){
     // Create operation
     newItemKey.value = database.child('items').push().key ?? '';
     database.child('items/$newItemKey').set({'name': 'New Item'});
   }
  readData(){
    database.child('items').once().then((event) {
      final dataSnapshot = event.snapshot;
      if (dataSnapshot.value != null) {
        print(dataSnapshot.value);
      }
    });
  }

  addItem() {
    String newItemKey = database.child('items').push().key ?? '';
    database.child('items/$newItemKey').set({'name': 'New Item'});
    items.add(Item(newItemKey, 'New Item'));
    update();
  }

  updateItem(int index) {
    String key = items[index].key;
    database.child('items/$key').update({'name': 'Updated Item$index'});
    items[index].name = 'Updated Item$index';
    items.refresh();
    update();
  }

  removeItem(int index) {
    String key = items[index].key;
    database.child('items/$key').remove();
    items.removeAt(index);
    update();
  }

  fetchItems() {
    items.clear();
    database.child('items').once().then((event) {
      final dataSnapshot = event.snapshot;
      if (dataSnapshot.value != null) {
        print(dataSnapshot.value);
        Map<dynamic, dynamic> values = dataSnapshot.value as Map<dynamic, dynamic>;
        values.forEach((key, value) {
          items.add(Item(key, value['name']));
        });
        update();
      }
    });
  }
}