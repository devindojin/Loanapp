import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shelbi_finance/constants/api.dart';
import 'package:shelbi_finance/constants/preference_key.dart';
import 'package:shelbi_finance/services/api_client.dart';
import 'package:shelbi_finance/views/home_screen.dart';
import 'package:shelbi_finance/views/sign_in_screen.dart';

import 'base_controller.dart';
import 'home_controller.dart';

class AuthController extends GetxController with BaseController {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;

  AuthController({
    required this.apiClient,
    required this.sharedPreferences,
  });

  final RxBool isLogged = false.obs;

  @override
  void onReady() {
    isLogged.value = sharedPreferences.getBool(PreferenceKey.login) ?? false;

    super.onReady();
  }

  void onSignIn() async {
    showLoading();

    final body = {
      'email': emailController.value.text,
      'password': passwordController.value.text
    };

    dynamic response =
        await apiClient.post(Api.LOGIN, body: body).catchError(handleError);

    hideLoading();

    if (response != null) {
      String token = response['token'];

      await sharedPreferences.setBool(PreferenceKey.login, true);
      await sharedPreferences.setString(PreferenceKey.token, token);

      apiClient.updateHeader(token);

      Get.offAll(() => HomeScreen());
    }
  }

  void logout() async {
    await apiClient.post(Api.LOGOUT);
    //.catchError(handleError);
    await sharedPreferences.clear();

    Get.delete<HomeController>();

    Get.offAll(() => SignInScreen());
  }
}
