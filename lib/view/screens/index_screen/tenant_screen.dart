import 'package:bsn_v2/const/app_text_style.dart';
import 'package:bsn_v2/controller/canvas_controller.dart';
import 'package:bsn_v2/controller/manufacturer/get_manufacturer_controller.dart';
import 'package:bsn_v2/controller/manufacturer/post_manufacturer_controller.dart';
import 'package:bsn_v2/controller/tenant/get_tenant_controller.dart';
import 'package:bsn_v2/controller/tenant/post_tenant_controller.dart';
import 'package:bsn_v2/controller/user/get_user_info_controller.dart';
import 'package:bsn_v2/model/manufacturer.dart';
import 'package:bsn_v2/view/widget/etc/custom_manufacturer_text_field.dart';

import 'package:bsn_v2/view/widget/etc/custom_manufacturer_list_tile_detail.dart';
import 'package:bsn_v2/view/widget/etc/custom_tenant_list_tile_detail.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bsn_v2/const/app_colors.dart';
import 'package:bsn_v2/view/widget/container/custom_basic_container.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TenantScreen extends StatefulWidget {
  TenantScreen({super.key});

  @override
  State<TenantScreen> createState() => _TenantScreenState();
}

class _TenantScreenState extends State<TenantScreen> {
  @override
  void initState() {
    super.initState();
    // 여기서 초기화 작업 수행
  }

  // 데모 데이터 목록
  final List<String> items = List<String>.generate(20, (i) => "Item ${i + 1}");

  var getUserInfoController = Get.find<GetUserInfoController>();

  var getTenantDetailController = Get.find<GetTenantDetailController>();

  var getManufacturerDetailController = Get.find<GetManufacturerController>();

  var postTenantDetailController = Get.find<PostTenantDetailController>();

  var postManufacturerDetailController = Get.find<PostManufacturerController>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isWideScreen = screenWidth > 600;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: isWideScreen
          ? _buildWideScreenLayout(screenWidth)
          : _buildNarrowScreenLayout(),
    );
  }

  Widget _buildWideScreenLayout(double screenWidth) {
    return ListView(
      children: [
        SizedBox(height: 20),
        Row(
          children: [
            CustomBasicContainer(width: screenWidth * 0.143, height: 620),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('   Tenant Information',
                        style: AppTextStyles.bold
                            .copyWith(color: Colors.black, fontSize: 25)),
                    SizedBox(
                        width: 43
                            .w), // .w 제거, 여기서는 SizedBox의 width에 직접 값을 주는 것이 적절합니다.
                    if (getUserInfoController.userInformation!.privilege !=
                        'AWAITER') ...[
                      IconButton(
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        onPressed: () {
                          showDialog(
                            barrierDismissible: true, // 대화상자 바깥을 눌러도 닫히게 설정
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                backgroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  width: 600,
                                  height: 600,
                                  child: AlertDialog(
                                    elevation: 0,
                                    backgroundColor: Colors.white,
                                    title: Align(
                                      alignment: Alignment.topCenter,
                                      child: Text(
                                        'Tenant 추가',
                                        style: AppTextStyles.bold,
                                      ),
                                    ),
                                    content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Form(
                                            key: _formKey,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  TextFormField(
                                                    controller:
                                                        postTenantDetailController
                                                            .nameController,
                                                    decoration: InputDecoration(
                                                      labelText: 'Name',
                                                    ),
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Please enter a name';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  SizedBox(height: 10),
                                                  TextFormField(
                                                    controller:
                                                        postTenantDetailController
                                                            .longitudeController,
                                                    decoration: InputDecoration(
                                                      labelText: 'X Coordinate',
                                                    ),
                                                    keyboardType:
                                                        TextInputType.number,
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Please enter x coordinate';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  TextFormField(
                                                    controller:
                                                        postTenantDetailController
                                                            .latitudeController,
                                                    decoration: InputDecoration(
                                                      labelText: 'Y Coordinate',
                                                    ),
                                                    keyboardType:
                                                        TextInputType.number,
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Please enter y coordinate';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  SizedBox(height: 20),
                                                  Center(
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        if (_formKey
                                                            .currentState!
                                                            .validate()) {
                                                          // 입력된 좌표값을 정수로 변환
                                                          int xCoordinate = int.tryParse(
                                                                  postTenantDetailController
                                                                      .longitudeController
                                                                      .text) ??
                                                              0;
                                                          int yCoordinate = int.tryParse(
                                                                  postTenantDetailController
                                                                      .latitudeController
                                                                      .text) ??
                                                              0;

                                                          postTenantDetailController
                                                              .initializeData();
                                                          // 여기에서 변환된 좌표값을 사용하여 서버에 요청을 보낼 수 있습니다.
                                                          print(
                                                              'Name: ${postTenantDetailController.nameController.text}');
                                                          print(
                                                              'X Coordinate: $xCoordinate');
                                                          print(
                                                              'Y Coordinate: $yCoordinate');
                                                          setState(() {});
                                                        }
                                                      },
                                                      child: Text('Submit'),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ]),
                                    actions: <Widget>[
                                      Center(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.grey,
                                                foregroundColor: Colors.white,
                                                minimumSize: Size(120, 45),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 16,
                                                    vertical: 8),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                              child: Text('취소'),
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pop(); // 대화상자를 닫습니다
                                              },
                                            ),
                                            SizedBox(width: 10), // 버튼 사이의 간격
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.grey,
                                                foregroundColor: Colors.white,
                                                minimumSize: Size(120, 45),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 16,
                                                    vertical: 8),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                              child: Text('확인'),
                                              onPressed: () {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  postManufacturerDetailController
                                                      .initializeData();
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        icon: Icon(Icons.add, size: 20, color: Colors.grey),
                      ),
                      IconButton(
                        onPressed: () {
                          // '삭제' 버튼 눌렀을 때 실행할 코드
                        },
                        icon: Icon(Icons.delete, size: 20, color: Colors.grey),
                      ),
                      SizedBox(width: 5),
                    ],
                  ],
                ),
                CustomBasicContainer(
                  width: 110,
                  height: 305,
                  child: Column(
                    children: [
                      Column(
                        children: [
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'Search',
                              prefixIcon: Icon(Icons.search),
                            ),
                            onChanged: (query) {
                              // 검색어(query)를 사용하여 아이템을 필터링하거나 처리할 수 있습니다.
                            },
                          ),
                        ],
                      ),
                      Container(
                        height: 305,
                        child: Obx(
                          () => ListView.builder(
                            itemCount: getTenantDetailController.tenants.length,
                            itemBuilder: (context, index) {
                              var tenant =
                                  getTenantDetailController.tenants[index];
                              return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      width: 1,
                                      color: AppColors.screenBackgroundColor,
                                    ),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Dialog(
                                            backgroundColor: Colors.white,
                                            shape: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            elevation: 0,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              width: 500,
                                              height: 450,
                                              child: AlertDialog(
                                                backgroundColor: Colors.white,
                                                elevation: 0,
                                                title: Align(
                                                  alignment:
                                                      AlignmentDirectional
                                                          .topCenter,
                                                  child: Text(
                                                      'Tenant ${getTenantDetailController.tenants[index]!.name} 작업 영역'),
                                                ),
                                                content: SingleChildScrollView(
                                                  child: ListBody(
                                                    children: <Widget>[
                                                      CustomTenantListTileDetail(
                                                          label: 'TenantId',
                                                          text:
                                                              '${getTenantDetailController.tenants[index]!.id}'),
                                                      SizedBox(height: 5),
                                                      CustomTenantListTileDetail(
                                                          label: 'Area',
                                                          text:
                                                              'x: ${getTenantDetailController.tenants[index].point.latitude}, y: ${getTenantDetailController.tenants[index]!.point.longitude}'),
                                                      SizedBox(height: 5),
                                                      CustomTenantListTileDetail(
                                                          label: 'Devices',
                                                          text:
                                                              '${getTenantDetailController.tenants[index]!.devices.isEmpty ? 'Not detected' : null}'),
                                                      SizedBox(height: 5),
                                                      CustomTenantListTileDetail(
                                                          label: 'Workers',
                                                          text:
                                                              '${getTenantDetailController.tenants[index]!.workers.isEmpty ? 'Not detected' : null}'),
                                                      SizedBox(height: 5),
                                                      CustomTenantListTileDetail(
                                                          label: 'createdAt',
                                                          text:
                                                              '${getTenantDetailController.tenants[index]!.createdAt}'),
                                                      SizedBox(height: 5),
                                                      CustomTenantListTileDetail(
                                                          label: 'deletedAt',
                                                          text:
                                                              '${getTenantDetailController.tenants[index]!.deletedAt ?? 'Not applicable'}: null}'),
                                                    ],
                                                  ),
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: Text('취소'),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop(); // 대화상자를 닫습니다
                                                    },
                                                  ),
                                                  TextButton(
                                                    child: Text('확인'),
                                                    onPressed: () {
                                                      // 확인 버튼이 눌렸을 때 수행할 작업
                                                      Navigator.of(context)
                                                          .pop(); // 대화상자를 닫습니다
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: ListTile(
                                      leading: Text('${tenant.name}'),
                                      title: Text('}'),
                                      trailing: Icon(Icons.arrow_forward),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text('   Manufacturer Information',
                        style: AppTextStyles.bold
                            .copyWith(color: Colors.black, fontSize: 25)),
                    SizedBox(
                        width: 25
                            .w), // .w 제거, 여기서는 SizedBox의 width에 직접 값을 주는 것이 적절합니다.
                    if (getUserInfoController.userInformation!.privilege !=
                        'AWAITER') ...[
                      IconButton(
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        onPressed: () {
                          showDialog(
                            barrierDismissible: true, // 대화상자 바깥을 눌러도 닫히게 설정
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                backgroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  width: 600,
                                  height: 300,
                                  child: AlertDialog(
                                    elevation: 0,
                                    backgroundColor: Colors.white,
                                    title: Align(
                                      alignment: Alignment.topCenter,
                                      child: Text(
                                        'Manufacturer 추가',
                                        style: AppTextStyles.bold,
                                      ),
                                    ),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CustomManufacturerTextField(
                                          label: 'Name',
                                          controller:
                                              postManufacturerDetailController
                                                  .nameController,
                                        ),
                                        SizedBox(height: 5),
                                        Form(
                                          key: _formKey,
                                          child: CustomManufacturerTextField(
                                            validator:
                                                postManufacturerDetailController
                                                    .validatePhoneNumber,
                                            label: 'Contact',
                                            controller:
                                                postManufacturerDetailController
                                                    .contactController,
                                          ),
                                        ),
                                      ],
                                    ),
                                    actions: <Widget>[
                                      Center(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.grey,
                                                foregroundColor: Colors.white,
                                                minimumSize: Size(120, 45),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 16,
                                                    vertical: 8),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                              child: Text('취소'),
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pop(); // 대화상자를 닫습니다
                                              },
                                            ),
                                            SizedBox(width: 10), // 버튼 사이의 간격
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.grey,
                                                foregroundColor: Colors.white,
                                                minimumSize: Size(120, 45),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 16,
                                                    vertical: 8),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                              child: Text('확인'),
                                              onPressed: () {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  getManufacturerDetailController
                                                      .addManufacturer(Manufacturer(
                                                          name:
                                                              '${postManufacturerDetailController.nameController.text}',
                                                          contact:
                                                              '${postManufacturerDetailController.contactController.text}'));

                                                  postManufacturerDetailController
                                                      .initializeData();
                                                  setState(() {});
                                                  Navigator.of(context)
                                                      .pop(); // 대화상자 닫기
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        icon: Icon(Icons.add, size: 20, color: Colors.grey),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.delete, size: 20, color: Colors.grey),
                      ),
                      SizedBox(width: 5),
                    ],
                  ],
                ),
                CustomBasicContainer(
                  width: 110,
                  height: 305,
                  child: Column(
                    children: [
                      Column(
                        children: [
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'Search',
                              prefixIcon: Icon(Icons.search),
                            ),
                            onChanged: (query) {
                              // 검색어(query)를 사용하여 아이템을 필터링하거나 처리할 수 있습니다.
                            },
                          ),
                        ],
                      ),
                      Container(
                        height: 300,
                        child: Obx(
                          () => ListView.builder(
                            itemCount: getManufacturerDetailController
                                .manufacturers.length,
                            itemBuilder: (context, index) {
                              var manufacturer = getManufacturerDetailController
                                  .manufacturers[index];
                              return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      width: 1,
                                      color: AppColors.screenBackgroundColor,
                                    ),
                                  ),
                                  child: ListTile(
                                    leading: Text(
                                        '${getManufacturerDetailController.manufacturers[index].name}'),
                                    title: Text(
                                        '${getManufacturerDetailController.manufacturers[index].contact}'),
                                    trailing: Icon(Icons.arrow_forward),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNarrowScreenLayout() {
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              CustomBasicContainer(width: 350.w, height: 600.h),
              CustomBasicContainer(width: 350.w, height: 600.h),
            ],
          ),
        ),
      ],
    );
  }
}
