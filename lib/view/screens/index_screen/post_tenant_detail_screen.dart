import 'package:bsn_v2/controller/manufacturer/get_manufacturer_controller.dart';
import 'package:bsn_v2/controller/manufacturer/post_manufacturer_controller.dart';
import 'package:bsn_v2/controller/tenant/get_tenant_controller.dart';
import 'package:bsn_v2/controller/tenant/post_tenant_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TenantForm extends StatelessWidget {
  final postTenantDetailController = Get.find<PostTenantDetailController>();
  final getTenantDetailController = Get.find<GetTenantDetailController>();

  final getManufacturerController = Get.find<GetManufacturerController>();
  final postManufacutrerDetailController =
      Get.find<PostManufacturerController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Tenant')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: postTenantDetailController.nameController,
              decoration: InputDecoration(labelText: 'Tenant Name'),
            ),
            Obx(() => Column(
                  children: postTenantDetailController.points
                      .map((point) => Text('Point: (${point.x}, ${point.y})'))
                      .toList(),
                )),
            ElevatedButton(
              onPressed: () => postTenantDetailController.addPoint(), // 테스트용
              child: Text('Add Point'),
            ),
            ElevatedButton(
              onPressed: () => postTenantDetailController.initializeData(),
              child: Text('Submit'),
            ),
            ElevatedButton(
              onPressed: () => getTenantDetailController.initializeData(),
              child: Text('Submit'),
            ),
            ElevatedButton(
              onPressed: () => getManufacturerController.initializeData(),
              child: Text('Submit'),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  TextField(
                    controller: postManufacutrerDetailController.nameController,
                    decoration: InputDecoration(labelText: "제조업체 이름"),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller:
                        postManufacutrerDetailController.contactController,
                    decoration: InputDecoration(labelText: "연락처"),
                  ),
                  SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      postManufacutrerDetailController.initializeData();
                    },
                    child: Text("제출"),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
