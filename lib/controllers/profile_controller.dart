import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shelbi_finance/constants/api.dart';
import 'package:shelbi_finance/helpers/dialog_helper.dart';
import 'package:shelbi_finance/models/user_response.dart';
import 'package:shelbi_finance/services/api_client.dart';

import 'base_controller.dart';

class ProfileController extends GetxController with BaseController {
  final ApiClient apiClient;

  ProfileController({required this.apiClient});

  final Rx<TextEditingController> nameController = TextEditingController().obs;
  final Rx<TextEditingController> emailController = TextEditingController().obs;
  final Rx<TextEditingController> phoneController = TextEditingController().obs;

  final RxBool profileImageUploading = false.obs;
  final Rx<String> profileImage = ''.obs;

  XFile? profileFile;

  @override
  void onReady() {
    super.onReady();

    _getUserDetail();
  }

  _getUserDetail() async {
    dynamic response =
        await apiClient.post(Api.GET_USER).catchError(handleError);
    if (response != null) {
      UserResponse userResponse = UserResponse.fromJson(response);

      nameController.value.text = userResponse.user.name;
      emailController.value.text = userResponse.user.email;
      phoneController.value.text = userResponse.user.phone ?? '';

      profileImage.value = userResponse.user.profilePicture ?? '';
    }
  }

  void updateUserDetails() async {
    final body = {
      'name': nameController.value.text,
      'email': emailController.value.text,
      'phone': phoneController.value.text
    };

    showLoading();
    dynamic response = await apiClient
        .postMultipart(
          Api.UPDATE_PROFILE,
          body,
          multipartBody: profileFile != null
              ? [MultipartBody('profile_picture', profileFile!)]
              : null,
        )
        .catchError(handleError);

    hideLoading();

    if (response != null) {
      Get.back();
      DialogHelper.showSuccessSnackBar(response['message']);
    }
  }
}
