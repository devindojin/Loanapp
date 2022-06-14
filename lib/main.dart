import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/api.dart';
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
      title: 'ShelBi Finance',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Obx(
        () => Get.find<AuthController>().isLogged.value
            ? HomeScreen()
            : SignInScreen(),
      ),
    );
  }
}
