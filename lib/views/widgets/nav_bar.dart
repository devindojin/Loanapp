import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shelbi_finance/constants/app_color.dart';
import 'package:shelbi_finance/constants/app_image.dart';
import 'package:shelbi_finance/controllers/auth_controller.dart';

import '../edit_profile_screen.dart';
import '../profit_screen.dart';
import '../support_screen.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // backgroundColor: const Color(0xFF29303C),
      backgroundColor: AppColor.primaryBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 250,
                width: 250,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(350),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomRight,
                    tileMode: TileMode.repeated,
                    colors: [
                      Color(0xFF15EDED),
                      Color(0xFF029CF5),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 70.0, left: 20.0),
                child: Image.asset(
                  AppImage.blackLogo,
                  height: 125,
                  // color: Colors.black,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ],
          ),
          Flexible(
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              children: [
                const SizedBox(height: 20),
                _buildDrawerRow(
                  'ANALYSIS',
                  Icons.search,
                  onTap: () {
                    Get.back();
                    Get.to(() => const ProfitScreen());
                  },
                ),
                _buildDrawerRow(
                  'HOME',
                  Icons.home,
                  onTap: () {
                    Get.back();
                  },
                ),
                _buildDrawerRow(
                  'SUPPORT / ASSISTANCE',
                  Icons.assignment,
                  onTap: () async {
                    Get.back();
                    Get.to(() => const SupportScreen());
                  },
                ),
                _buildDrawerRow(
                  'SETTINGS',
                  Icons.settings,
                  onTap: () {
                    Get.back();
                    Get.to(() => EditProfileScreen());
                  },
                ),
                _buildDrawerRow(
                  'LOGOUT',
                  Icons.logout,
                  onTap: () {
                    Get.find<AuthController>().logout();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerRow(String title, IconData iconData,
      {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 30.0, left: 20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            title == 'SUPPORT / ASSISTANCE'
                ? Image.asset(
                    AppImage.assistance,
                    height: 24,
                    fit: BoxFit.fitHeight,
                  )
                : Icon(
                    iconData,
                    size: 25,
                    color: AppColor.blue,
                  ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'Myriad Pro',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
