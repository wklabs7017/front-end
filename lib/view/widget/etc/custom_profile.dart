import 'package:bsn_v2/controller/user/get_user_info_controller.dart';
import 'package:flutter/material.dart';
import '../../../const/app_colors.dart';
import 'package:bsn_v2/const/app_text_style.dart';
import 'package:get/get.dart';

class CustomProfile extends StatelessWidget {
  CustomProfile({super.key});

  var getUserInfoController = Get.find<GetUserInfoController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisSize: MainAxisSize.min, // Add this line
          crossAxisAlignment: CrossAxisAlignment.start, // Change to center
          children: [
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 8.0),
                  child: CircleAvatar(
                    radius: 35, // 원하는 크기로 설정
                    backgroundColor: AppColors.backgroundColor, // 배경 색상 설정
                    child: Icon(
                      Icons.person, // 원하는 아이콘 선택
                      size: 30, // 아이콘 크기 설정
                      color: AppColors.primaryColor, // 아이콘 색상 설정
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0), // Add padding
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${getUserInfoController.userInformation!.name}',
                        style: AppTextStyles.bold
                            .copyWith(fontSize: 24, color: Colors.white),
                      ),
                      Text(
                        '${getUserInfoController.userInformation!.email}',
                        style: AppTextStyles.bold
                            .copyWith(fontSize: 17, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
