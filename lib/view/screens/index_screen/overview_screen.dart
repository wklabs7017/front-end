import 'package:bsn_v2/const/app_colors.dart';
import 'package:bsn_v2/view/widget/container/custom_basic_container.dart';
import 'package:bsn_v2/view/widget/app_bar/custom_overview_screen_app_bar.dart';
import 'package:flutter/material.dart';

class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomOverviewScreenAppBar(),
      body: ListView(
        children: [
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomBasicContainer(width: 80, height: 300),
                    const SizedBox(height: 8),
                    CustomBasicContainer(width: 80, height: 298)
                  ],
                ),
                const SizedBox(width: 10),
                Column(
                  children: [
                    CustomBasicContainer(width: 150, height: 385),
                    const SizedBox(height: 10),
                    CustomBasicContainer(width: 150, height: 213),
                  ],
                ),
                const SizedBox(width: 10),
                Expanded(child: CustomBasicContainer(width: 60, height: 607)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
