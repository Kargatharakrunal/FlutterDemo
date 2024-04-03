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
    database.child('items/$newItemKey').set({'name': 'New Item', 'address': {'city':'surat','state':'gujarat', 'country':'india'}});
    items.add(Item(newItemKey, 'New Item', Address('surat', 'gujarat', 'india')));
    update();
  }

  updateItem(int index) {
    String key = items[index].key;
    final newAddress = {'city': 'surat$index', 'state': 'gujarat$index', 'country': 'india$index'};
    database.child('items/$key').update({'name': 'Updated Item$index', 'address': newAddress});
    items[index].name = 'Updated Item$index';
    items[index].address = Address('surat$index', 'gujarat$index', 'india$index');
    items.refresh();
    update();
    // fetchItems();
  }

  removeItem(int index) {
    String key = items[index].key;
    database.child('items/$key').remove();
    items.removeAt(index);
    update();
  }

  fetchItems() {
    database.child('items').once().then((event) {
      final dataSnapshot = event.snapshot;
      if (dataSnapshot.value != null) {
        print(dataSnapshot.value);
        items.clear();

        Map<dynamic, dynamic> values = dataSnapshot.value as Map<dynamic, dynamic>;
        values.forEach((key, value) {
          final Map<dynamic, dynamic> addressMap = value['address'] ?? {};
          items.add(Item(key, value['name'], Address(addressMap['city'],addressMap['state'],addressMap['country'])));
        });
        update();
      }
    });
  }
}