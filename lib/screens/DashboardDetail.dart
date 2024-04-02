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
          return Column(
            children: [
              Container(
                child: Text(detailControl.detailsData.value.name??''),
              ),
              ElevatedButton(
                onPressed: () {
                  detailControl.addItem();

                },
                child: Text('Create'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Read operation
detailControl.fetchItems();
                },
                child: Text('Read'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Update operation

                },
                child: Text('Update'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Delete operation
                  detailControl.database.child('items/${detailControl.newItemKey.value}').remove();
                },
                child: Text('Delete'),
              ),
              Expanded(
                child: ListView.builder(itemBuilder: (context, index){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(detailControl.items[index].name??''),
                        GestureDetector(
                            onTap: (){
                              detailControl.removeItem(index);
                            },
                            child: Text('Delete')),
                        GestureDetector(
                            onTap: (){
                              detailControl.updateItem(index);
                            },
                            child: Text('Update')),
                      ],
                    ),
                  );
                },
                  itemCount: detailControl.items.length,),
              ),


            ],
          );
        }
      ),
    );
  }
}
class Item {
  late String key;
  late String name;

  Item(this.key, this.name);
}