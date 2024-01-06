import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../const/app_colors.dart';

class CustomProfile extends StatelessWidget {
  const CustomProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 5.w,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 8.0),
              child: CircleAvatar(
                radius: 15, // 원하는 크기로 설정
                backgroundColor: AppColors.backgroundColor, // 배경 색상 설정
                child: Icon(
                  Icons.person, // 원하는 아이콘 선택
                  size: 15, // 아이콘 크기 설정
                  color: Colors.white, // 아이콘 색상 설정
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Text('가나다',
                      style: TextStyle(
                          fontSize: 18, color: AppColors.menuTextColor)),
                  Text('username@gmail.com',
                      style: TextStyle(
                          fontSize: 10, color: AppColors.menuTextColor)),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          child: Text('계정 설정',
                              style: TextStyle(
                                  fontSize: 10,
                                  color: AppColors.menuTextColor)),
                        ),
                        Text('ㅣ',
                            style: TextStyle(
                                fontSize: 10, color: AppColors.menuTextColor)),
                        GestureDetector(
                          child: Text('로그아웃',
                              style: TextStyle(
                                  fontSize: 10,
                                  color: AppColors.menuTextColor)),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
