import 'package:bsn_v2/const/app_colors.dart';
import 'package:bsn_v2/const/app_text_style.dart';
import 'package:bsn_v2/controller/auth/sign_up_controller.dart';
import 'package:bsn_v2/controller/index/setting/setting_controller.dart';
import 'package:bsn_v2/controller/user/get_user_info_controller.dart';
import 'package:bsn_v2/controller/user/get_user_info_list_controller.dart';
import 'package:bsn_v2/controller/user/patch_user_email_controller.dart';
import 'package:bsn_v2/controller/user/patch_user_password_controller.dart';
import 'package:bsn_v2/controller/user/patch_user_privilege_controller.dart';
import 'package:bsn_v2/controller/user/patch_user_tenant_controller.dart';
import 'package:bsn_v2/controller/user/patch_user_user_id_controller.dart';
import 'package:bsn_v2/model/user.dart';
import 'package:bsn_v2/view/screens/index_screen/post_tenant_detail_screen.dart';
import 'package:bsn_v2/view/widget/container/custom_basic_container.dart';
import 'package:bsn_v2/view/widget/etc/user_management_table.dart';
import 'package:bsn_v2/view/widget/text_field/custom_edit_profile_elevated_button.dart';
import 'package:bsn_v2/view/widget/text_field/custom_text_form_field.dart';
import 'package:bsn_v2/view/widget/text_field/new_custom_text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final settingController = Get.find<SettingController>();
  final getUserInfoController = Get.find<GetUserInfoController>();
  final getUserInfoListController = Get.find<GetUserInfoListController>();
  final patchUserIdController = Get.find<PatchUserIDController>();

  final patchUserEmailController = Get.find<PatchUserEmailController>();

  final patchUserPasswordController = Get.find<PatchUserPasswordController>();

  final patchUserTenantController = Get.find<PatchUserTenantController>();

  final patchUserPrevillegeController =
      Get.find<PatchUserPrevillegeController>();

  bool showContainer = false; // 컨테이너 표시 여부를 결정하는 상태
  @override
  void initState() {
    super.initState();
    getUserInfoController.initializeData();
    patchUserIdController.userIdController.text =
        getUserInfoController.userInformation?.userId ?? '';
    patchUserEmailController.emailController.text =
        getUserInfoController.userInformation?.email ?? '';
    getUserInfoListController.fetchUserInformationList(skip: 0, take: 10);
  }

  final List<String> dropdownOptions2 = ['ADMIN', 'AWAITER'];

  void initializeData() async {
    // 사용자 정보 로드
    await getUserInfoController.fetchUserInfo();
    // 사용자 목록 로드
    getUserInfoListController.fetchUserInformationListPage();
  }

  void tryUpdateUserId() async {
    bool success = await patchUserIdController.initializeData();
    if (success) {
      getUserInfoController.update();

      setState(() {
        // 컨트롤러의 이름 정보를 업데이트합니다.
        getUserInfoController.userInformation?.userId =
            patchUserIdController.userIdController.text;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('사용자 ID가 성공적으로 업데이트되었습니다.'),
          duration: Duration(seconds: 2),
        ),
      );
      getUserInfoController.update();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('사용자 ID 업데이트에 실패했습니다. (이전 비밀번호가 맞는지 다시한번 살펴보세요.)'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void tryUpdateUserPW() async {
    bool? success = await patchUserPasswordController.initializeData();
    if (success!) {
      getUserInfoController.update();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('사용자 Password가 성공적으로 업데이트되었습니다.'),
          duration: Duration(seconds: 2),
        ),
      );
      getUserInfoController.update();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('사용자 Password 업데이트에 실패했습니다.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void tryUpdateUserprevillege() async {
    bool? success = await patchUserPrevillegeController.initializeData();
    if (success == true) {
      getUserInfoController.update();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('성공적으로 업데이트되었습니다.'),
          duration: Duration(seconds: 2),
        ),
      );
      getUserInfoController.update();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('업데이트에 실패했습니다.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void tryUpdateUserEmail() async {
    bool? success = await patchUserEmailController.initializeData();
    if (success!) {
      getUserInfoController.update();

      setState(() {
        // 컨트롤러의 이름 정보를 업데이트합니다.
        getUserInfoController.userInformation?.email =
            patchUserEmailController.emailController.text;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('사용자 email이 성공적으로 업데이트되었습니다.'),
          duration: Duration(seconds: 2),
        ),
      );
      getUserInfoController.update();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('사용자 email 업데이트에 실패했습니다.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _refreshScreen() {
    setState(() {
      // 이곳에 화면을 다시 그리기 위한 상태 변경 로직을 작성합니다.
      // 예: 데이터를 새로고침하거나, UI 상태를 변경하는 로직 등
    });
  }

  // Form 키를 정의합니다. 이를 통해 폼의 상태를 제어할 수 있습니다.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isWideScreen = screenWidth > 600; // 예: 600px 이상을 넓은 화면으로 간주

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body:
          isWideScreen ? _buildWideScreenLayout() : _buildNarrowScreenLayout(),
    );
  }

  Widget _buildWideScreenLayout() {
    // 넓은 화면용 레이아웃 (Row 사용)
    return Row(children: [
      CustomBasicContainer(
        width: 130,
        height: 800,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('유저 정보',
                  style: AppTextStyles.bold
                      .copyWith(color: Colors.black, fontSize: 25)),
            ),
            SizedBox(height: 5),
            Divider(),
            SizedBox(height: 50.h),
            Center(
              child: Container(
                width: 400,
                height: 600,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border:
                        Border.all(width: 3, color: AppColors.backgroundColor)),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 20),
                        Align(
                          alignment: Alignment.center,
                          child: CircleAvatar(
                            radius: 40,
                            backgroundColor:
                                Colors.indigoAccent, // Circle color
                            child: Icon(
                              Icons.person, // Person icon
                              color: Colors.white, // Icon color
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.lightBlueAccent[200]),
                              width: 70,
                              height: 40,
                              child: Center(
                                child: Text(
                                  'id',
                                  style: AppTextStyles.medium
                                      .copyWith(fontSize: 12),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      width: 1,
                                      color: AppColors.backgroundColor)),
                              width: 280,
                              height: 42,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        '   ${getUserInfoController.userInformation!.id}',
                                        style: AppTextStyles.medium
                                            .copyWith(fontSize: 17),
                                      ),
                                      Spacer(),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.lightBlueAccent[200]),
                              width: 70,
                              height: 40,
                              child: Center(
                                child: Text(
                                  'tenant',
                                  style: AppTextStyles.medium
                                      .copyWith(fontSize: 12),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      width: 1,
                                      color: AppColors.backgroundColor)),
                              width: 280,
                              height: 42,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        '   ${getUserInfoController.userInformation!.tenant}',
                                        style: AppTextStyles.medium
                                            .copyWith(fontSize: 17),
                                      ),
                                      Spacer(),
                                      getUserInfoController
                                                  .userInformation!.privilege ==
                                              'ADMIN'
                                          ? SizedBox.shrink()
                                          : IconButton(
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return Theme(
                                                      data: Theme.of(context)
                                                          .copyWith(
                                                        dialogBackgroundColor:
                                                            AppColors
                                                                .backgroundColor,
                                                      ), // 다이얼로그 배경색을 흰색으로 오버라이드
                                                      child: Dialog(
                                                        shape: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                        elevation: 0,
                                                        backgroundColor:
                                                            Colors.white,
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                          width: 400,
                                                          height: 280,
                                                          child: AlertDialog(
                                                            elevation: 0,
                                                            backgroundColor:
                                                                Colors.white,
                                                            title: Center(
                                                                child: Text(
                                                                    'ID 변경',
                                                                    style: AppTextStyles
                                                                        .bold
                                                                        .copyWith(
                                                                            fontSize:
                                                                                24))),
                                                            content: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                SizedBox(
                                                                    width: 20),
                                                                DropdownButtonFormField<
                                                                    String>(
                                                                  decoration:
                                                                      InputDecoration(
                                                                    labelText:
                                                                        'Select Status',
                                                                  ),
                                                                  value: dropdownOptions2.contains(patchUserPrevillegeController
                                                                          .previllegeController
                                                                          .text)
                                                                      ? patchUserPrevillegeController
                                                                          .previllegeController
                                                                          .text
                                                                      : null,
                                                                  onChanged:
                                                                      (String?
                                                                          newValue) {
                                                                    if (newValue !=
                                                                        null) {
                                                                      patchUserPrevillegeController
                                                                          .previllegeController
                                                                          .text = newValue;
                                                                    }
                                                                  },
                                                                  items: dropdownOptions2
                                                                      .map((String
                                                                          value) {
                                                                    return DropdownMenuItem<
                                                                        String>(
                                                                      value:
                                                                          value,
                                                                      child: Text(
                                                                          value),
                                                                    );
                                                                  }).toList(),
                                                                ),
                                                              ],
                                                            ),
                                                            actions: [
                                                              Row(
                                                                children: [
                                                                  SizedBox(
                                                                      width:
                                                                          30),
                                                                  ElevatedButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context); // 다이얼로그 닫기
                                                                    },
                                                                    child: Text(
                                                                        '취소'),
                                                                    style: ElevatedButton
                                                                        .styleFrom(
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              50,
                                                                          vertical:
                                                                              20), // 버튼 내부 패딩 조정
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                      width: 5),
                                                                  ElevatedButton(
                                                                    onPressed:
                                                                        () {
                                                                      tryUpdateUserprevillege();
                                                                      Navigator.pop(
                                                                          context); // 다이얼로그 닫기
                                                                    },
                                                                    child: Text(
                                                                        '변경'),
                                                                    style: ElevatedButton
                                                                        .styleFrom(
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              50,
                                                                          vertical:
                                                                              20), // 버튼 내부 패딩 조정
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                              icon: Icon(
                                                Icons.arrow_forward_ios_sharp,
                                                size: 15,
                                              ),
                                            ) // 조건이 만족하지 않을 때 아무것도 표시하지 않음
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.lightBlueAccent[200]),
                              width: 70,
                              height: 40,
                              child: Center(
                                child: Text(
                                  'privilege',
                                  style: AppTextStyles.medium
                                      .copyWith(fontSize: 12),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      width: 1,
                                      color: AppColors.backgroundColor)),
                              width: 280,
                              height: 42,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        '   ${getUserInfoController.userInformation!.privilege}',
                                        style: AppTextStyles.medium
                                            .copyWith(fontSize: 17),
                                      ),
                                      Spacer(),
                                      getUserInfoController
                                                  .userInformation!.privilege ==
                                              'ADMIN'
                                          ? SizedBox.shrink()
                                          : IconButton(
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return Theme(
                                                      data: Theme.of(context)
                                                          .copyWith(
                                                        dialogBackgroundColor:
                                                            AppColors
                                                                .backgroundColor,
                                                      ), // 다이얼로그 배경색을 흰색으로 오버라이드
                                                      child: Dialog(
                                                        shape: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                        elevation: 0,
                                                        backgroundColor:
                                                            Colors.white,
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                          width: 400,
                                                          height: 800,
                                                          child: AlertDialog(
                                                            elevation: 0,
                                                            backgroundColor:
                                                                Colors.white,
                                                            title: Center(
                                                                child: Text(
                                                                    'ID 변경',
                                                                    style: AppTextStyles
                                                                        .bold
                                                                        .copyWith(
                                                                            fontSize:
                                                                                24))),
                                                            content: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                SizedBox(
                                                                    width: 20),
                                                                // 여기에 드롭다운을 추가합니다.
                                                                Expanded(
                                                                  child:
                                                                      DropdownButtonFormField<
                                                                          String>(
                                                                    decoration:
                                                                        InputDecoration(
                                                                      labelText:
                                                                          'Select Status',
                                                                    ),
                                                                    value: dropdownOptions2.contains(patchUserPrevillegeController
                                                                            .previllegeController
                                                                            .text)
                                                                        ? patchUserPrevillegeController
                                                                            .previllegeController
                                                                            .text
                                                                        : null,
                                                                    onChanged:
                                                                        (String?
                                                                            newValue) {
                                                                      if (newValue !=
                                                                          null) {
                                                                        patchUserPrevillegeController
                                                                            .previllegeController
                                                                            .text = newValue;
                                                                      }
                                                                    },
                                                                    items: dropdownOptions2
                                                                        .map((String
                                                                            value) {
                                                                      return DropdownMenuItem<
                                                                          String>(
                                                                        value:
                                                                            value,
                                                                        child: Text(
                                                                            value),
                                                                      );
                                                                    }).toList(),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            actions: [
                                                              Row(children: [
                                                                SizedBox(
                                                                    width: 30),
                                                                ElevatedButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context); // 다이얼로그 닫기
                                                                  },
                                                                  child: Text(
                                                                      '취소'),
                                                                  style: ElevatedButton
                                                                      .styleFrom(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            50,
                                                                        vertical:
                                                                            20), // 버튼 내부 패딩 조정
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    width: 5),
                                                                ElevatedButton(
                                                                  onPressed:
                                                                      () {
                                                                    tryUpdateUserprevillege();
                                                                    Navigator.pop(
                                                                        context); // 다이얼로그 닫기
                                                                  },
                                                                  child: Text(
                                                                      '변경'),
                                                                  style: ElevatedButton
                                                                      .styleFrom(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            50,
                                                                        vertical:
                                                                            20), // 버튼 내부 패딩 조정
                                                                  ),
                                                                ),
                                                              ]),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                              icon: Icon(
                                                Icons.arrow_forward_ios_sharp,
                                                size: 15,
                                              ),
                                            )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.lightBlueAccent[200]),
                              width: 70,
                              height: 40,
                              child: Center(
                                child: Text(
                                  'name',
                                  style: AppTextStyles.medium
                                      .copyWith(fontSize: 12),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      width: 1,
                                      color: AppColors.backgroundColor)),
                              width: 280,
                              height: 42,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        '   ${getUserInfoController.userInformation!.name}',
                                        style: AppTextStyles.medium
                                            .copyWith(fontSize: 17),
                                      ),
                                      Spacer(),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.lightBlueAccent[200]),
                              width: 70,
                              height: 40,
                              child: Center(
                                child: Text(
                                  'userId',
                                  style: AppTextStyles.medium
                                      .copyWith(fontSize: 12),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      width: 1,
                                      color: AppColors.backgroundColor)),
                              width: 280,
                              height: 42,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        '   ${getUserInfoController.userInformation!.userId}',
                                        style: AppTextStyles.medium
                                            .copyWith(fontSize: 17),
                                      ),
                                      Spacer(),
                                      IconButton(
                                        icon: Icon(
                                            size: 15,
                                            Icons.arrow_forward_ios_sharp),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Theme(
                                                data:
                                                    Theme.of(context).copyWith(
                                                  dialogBackgroundColor:
                                                      AppColors.backgroundColor,
                                                ), // 다이얼로그 배경색을 흰색으로 오버라이드
                                                child: Dialog(
                                                  shape: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  elevation: 0,
                                                  backgroundColor: Colors.white,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20)),
                                                    width: 400,
                                                    height: 280,
                                                    child: AlertDialog(
                                                      elevation: 0,
                                                      backgroundColor:
                                                          Colors.white,
                                                      title: Center(
                                                          child: Text('ID 변경',
                                                              style: AppTextStyles
                                                                  .bold
                                                                  .copyWith(
                                                                      fontSize:
                                                                          24))),
                                                      content: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          SizedBox(width: 20),
                                                          Expanded(
                                                            child:
                                                                NewCustomTextFormField(
                                                              maxLength: 20,
                                                              controller:
                                                                  patchUserIdController
                                                                      .userIdController,
                                                              // TextFormField의 스타일을 조정할 수 있습니다
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      actions: [
                                                        Row(
                                                          children: [
                                                            SizedBox(width: 30),
                                                            ElevatedButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context); // 다이얼로그 닫기
                                                              },
                                                              child: Text('취소'),
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            50,
                                                                        vertical:
                                                                            20), // 버튼 내부 패딩 조정
                                                              ),
                                                            ),
                                                            SizedBox(width: 5),
                                                            ElevatedButton(
                                                              onPressed: () {
                                                                tryUpdateUserId();
                                                                Navigator.pop(
                                                                    context); // 다이얼로그 닫기
                                                              },
                                                              child: Text('변경'),
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            50,
                                                                        vertical:
                                                                            20), // 버튼 내부 패딩 조정
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.lightBlueAccent[200]),
                              width: 70,
                              height: 40,
                              child: Center(
                                child: Text(
                                  'email',
                                  style: AppTextStyles.medium
                                      .copyWith(fontSize: 12),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      width: 1,
                                      color: AppColors.backgroundColor)),
                              width: 280,
                              height: 42,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        '   ${getUserInfoController.userInformation!.email}',
                                        style: AppTextStyles.medium
                                            .copyWith(fontSize: 17),
                                      ),
                                      Spacer(),
                                      IconButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Theme(
                                                  data: Theme.of(context)
                                                      .copyWith(
                                                    dialogBackgroundColor:
                                                        AppColors
                                                            .backgroundColor,
                                                  ), // 다이얼로그 배경색을 흰색으로 오버라이드
                                                  child: Dialog(
                                                    shape: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20)),
                                                    elevation: 0,
                                                    backgroundColor:
                                                        Colors.white,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20)),
                                                      width: 400,
                                                      height: 280,
                                                      child: AlertDialog(
                                                        elevation: 0,
                                                        backgroundColor:
                                                            Colors.white,
                                                        title: Center(
                                                            child: Text(
                                                                'Email 변경',
                                                                style: AppTextStyles
                                                                    .bold
                                                                    .copyWith(
                                                                        fontSize:
                                                                            24))),
                                                        content: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            SizedBox(width: 20),
                                                            Expanded(
                                                              child: Form(
                                                                key: _formKey,
                                                                child:
                                                                    NewCustomTextFormField(
                                                                  validator:
                                                                      (value) {
                                                                    if (value ==
                                                                            null ||
                                                                        value
                                                                            .isEmpty) {
                                                                      return '이메일을 입력해주세요.'; // 비어 있을 때의 에러 메시지
                                                                    }
                                                                    // 이메일 형식을 검증하는 정규 표현식
                                                                    String
                                                                        pattern =
                                                                        r'\b[\w\.-]+@[\w\.-]+\.\w{2,4}\b';
                                                                    RegExp
                                                                        regex =
                                                                        RegExp(
                                                                            pattern);
                                                                    if (!regex
                                                                        .hasMatch(
                                                                            value)) {
                                                                      return '유효한 이메일 주소를 입력해주세요.'; // 형식이 맞지 않을 때의 에러 메시지
                                                                    }
                                                                    return null; // 입력이 유효할 때 null을 반환
                                                                  },
                                                                  maxLength: 20,
                                                                  controller:
                                                                      patchUserEmailController
                                                                          .emailController,
                                                                  // 추가적인 TextFormField 스타일 설정
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        actions: [
                                                          Row(
                                                            children: [
                                                              SizedBox(
                                                                  width: 30),
                                                              ElevatedButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context); // 다이얼로그 닫기
                                                                },
                                                                child:
                                                                    Text('취소'),
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                  padding: EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          50,
                                                                      vertical:
                                                                          20), // 버튼 내부 패딩 조정
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: 5),
                                                              ElevatedButton(
                                                                onPressed: () {
                                                                  if (_formKey
                                                                      .currentState!
                                                                      .validate()) {
                                                                    tryUpdateUserEmail();
                                                                    Navigator.pop(
                                                                        context);
                                                                  }
                                                                  // 다이얼로그 닫기
                                                                },
                                                                child:
                                                                    Text('변경'),
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                  padding: EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          50,
                                                                      vertical:
                                                                          20), // 버튼 내부 패딩 조정
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          icon: Icon(
                                              size: 15,
                                              Icons.arrow_forward_ios_sharp))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.lightBlueAccent[200]),
                              width: 70,
                              height: 40,
                              child: Center(
                                child: Text(
                                  'Password',
                                  style: AppTextStyles.medium
                                      .copyWith(fontSize: 12),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      width: 1,
                                      color: AppColors.backgroundColor)),
                              width: 280,
                              height: 42,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        '      보안상 확인할 수 없습니다. 변경을 원할 시 아이콘을 눌러주세요',
                                        style: AppTextStyles.medium.copyWith(
                                            fontSize: 8, color: Colors.red),
                                      ),
                                      Spacer(),
                                      IconButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Center(
                                                  child: Dialog(
                                                    elevation: 0,
                                                    backgroundColor:
                                                        Colors.white,
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                          width: 500,
                                                          height: 600,
                                                          child: AlertDialog(
                                                            elevation: 0,
                                                            backgroundColor:
                                                                Colors.white,
                                                            title: Center(
                                                                child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(3.0),
                                                              child: Text(
                                                                  'Password 변경',
                                                                  style: AppTextStyles
                                                                      .bold
                                                                      .copyWith(
                                                                          fontSize:
                                                                              24)),
                                                            )),
                                                            content: Column(
                                                              children: [
                                                                Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: [
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerLeft, // 여기에서 원하는 정렬을 설정하세요.
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            3.0),
                                                                        child:
                                                                            Text(
                                                                          '이전 비밀번호',
                                                                          style: AppTextStyles
                                                                              .medium
                                                                              .copyWith(fontSize: 14),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    NewCustomTextFormField(
                                                                      maxLength:
                                                                          20,
                                                                      controller:
                                                                          patchUserPasswordController
                                                                              .prevPasswordController,
                                                                    ),
                                                                  ],
                                                                ),
                                                                Column(
                                                                  children: [
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerLeft, // 여기에서 원하는 정렬을 설정하세요.
                                                                      child:
                                                                          Text(
                                                                        '새로운 비밀번호',
                                                                        style: AppTextStyles
                                                                            .medium
                                                                            .copyWith(fontSize: 14),
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topCenter,
                                                                      child:
                                                                          NewCustomTextFormField(
                                                                        maxLength:
                                                                            20,
                                                                        controller:
                                                                            patchUserPasswordController.newPasswordController,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                            actions: [
                                                              Row(
                                                                children: [
                                                                  SizedBox(
                                                                      width:
                                                                          30),
                                                                  ElevatedButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context); // 다이얼로그 닫기
                                                                    },
                                                                    child: Text(
                                                                        '취소'),
                                                                    style: ElevatedButton
                                                                        .styleFrom(
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              50,
                                                                          vertical:
                                                                              20), // 버튼 내부 패딩 조정
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                      width: 5),
                                                                  ElevatedButton(
                                                                    onPressed:
                                                                        () {
                                                                      tryUpdateUserPW();
                                                                      Navigator.pop(
                                                                          context); // 다이얼로그 닫기
                                                                    },
                                                                    child: Text(
                                                                        '변경'),
                                                                    style: ElevatedButton
                                                                        .styleFrom(
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              50,
                                                                          vertical:
                                                                              20), // 버튼 내부 패딩 조정
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
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
                                          icon: Icon(
                                              size: 15,
                                              Icons.arrow_forward_ios_sharp))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10)
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      CustomBasicContainer(
        width: 209,
        height: 800,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('멤버 관리',
                  style: AppTextStyles.bold
                      .copyWith(color: Colors.black, fontSize: 25)),
            ),
            Divider(),
            Container(
              width: 500.w,
              height: 450.h,
              child: CustomUserManagementTable(
                  users: getUserInfoListController.paginatedUserData),
            ),
          ],
        ),
      )
    ]);
  }

  Widget _buildNarrowScreenLayout() {
    // 좁은 화면용 레이아웃 (Column 사용)
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CustomBasicContainer(width: 350, height: 600),
              CustomBasicContainer(width: 350, height: 600)
            ],
          ),
        ),
      ],
    );
  }
}
