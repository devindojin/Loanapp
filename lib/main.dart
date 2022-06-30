import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shelbi_finance/views/intro_screen.dart';

import 'constants/api.dart';
import 'constants/app_color.dart';
import 'controllers/auth_controller.dart';
import 'services/api_client.dart';
import 'views/home_screen.dart';
import 'views/sign_in_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(
      () => ApiClient(baseUrl: Api.BASE_URL, sharedPreferences: Get.find()));

  Get.lazyPut(() =>
      AuthController(apiClient: Get.find(), sharedPreferences: Get.find()));

  runApp(const ShelbiFinanceApp());
}

class ShelbiFinanceApp extends StatelessWidget {
  const ShelbiFinanceApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Shelbi Finance',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
          iconTheme: IconThemeData(
            color: AppColor.blue, //change your color here
          ),
          titleTextStyle: TextStyle(
            color: AppColor.blue,
            fontFamily: 'Bahnschrift',
          ),
        ),
        primarySwatch: Colors.blue,
      ),
      home: Obx(
        () => Get.find<AuthController>().isUserFirstTime.value
            ? const IntroScreen()
            : Get.find<AuthController>().isLogged.value
                ? HomeScreen()
                : SignInScreen(),
      ),
    );
  }
}
