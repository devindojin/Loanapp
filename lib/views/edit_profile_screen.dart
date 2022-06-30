import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shelbi_finance/constants/app_color.dart';
import 'package:shelbi_finance/constants/app_image.dart';
import 'package:shelbi_finance/controllers/home_controller.dart';
import 'package:shelbi_finance/controllers/profile_controller.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final ImagePicker _imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    ProfileController controller =
        Get.put(ProfileController(apiClient: Get.find()));

    return Scaffold(
      backgroundColor: AppColor.primaryBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'PROFILE',
          style: TextStyle(
            color: AppColor.blue,
            fontFamily: 'Bahnschrift',
          ),
        ),
        iconTheme: const IconThemeData(
          color: AppColor.blue, //change your color here
        ),
        leading: IconButton(
          iconSize: 24,
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(25),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  FocusScope.of(context).unfocus();

                  Get.dialog(
                    Dialog(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: () async {
                                final xFile = await _imagePicker.pickImage(
                                  source: ImageSource.camera,
                                  imageQuality: 70,
                                );
                                if (xFile != null) {
                                  controller.profileImageUploading.value = true;
                                  controller.profileFile = xFile;
                                  Get.back();
                                }
                              },
                              child: const SizedBox(
                                height: 60,
                                child: Icon(
                                  Icons.camera,
                                  color: AppColor.blue,
                                  size: 60,
                                ),
                              ),
                            ),
                            const SizedBox(width: 64),
                            InkWell(
                              onTap: () async {
                                final xFile = await _imagePicker.pickImage(
                                  source: ImageSource.gallery,
                                  imageQuality: 70,
                                );
                                if (xFile != null) {
                                  controller.profileImageUploading.value = true;
                                  controller.profileFile = xFile;
                                  Get.back();
                                }
                              },
                              child: const SizedBox(
                                height: 60,
                                child: Icon(
                                  Icons.add_photo_alternate_outlined,
                                  color: AppColor.blue,
                                  size: 60,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                child: Obx(
                  () => Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xff6d8dad).withOpacity(0.25),
                          blurRadius: 60,
                          offset: const Offset(4, 24),
                        ),
                      ],
                      image: controller.profileImageUploading.value
                          ? DecorationImage(
                              image:
                                  FileImage(File(controller.profileFile!.path)),
                              fit: BoxFit.cover,
                            )
                          : controller.profileImage.value.isEmpty
                              ? const DecorationImage(
                                  image: AssetImage(AppImage.newLogo),
                                  fit: BoxFit.cover,
                                )
                              : DecorationImage(
                                  image: NetworkImage(
                                      controller.profileImage.value),
                                  fit: BoxFit.cover,
                                ),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColor.blue,
                        width: 3.0,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Column(
                children: <Widget>[
                  Container(
                    height: 53.5,
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(5.0)),
                      border: Border.all(
                        color: AppColor.blue,
                        width: 1,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 12.0, right: 12.0, top: 10.0),
                      child: Theme(
                        data: ThemeData(hintColor: Colors.transparent),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: TextFormField(
                            validator: (input) {
                              if (input!.isEmpty) {
                                return 'Please type name';
                              } else {
                                return null;
                              }
                            },
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Bahnschrift',
                            ),
                            textAlign: TextAlign.start,
                            controller: controller.nameController.value,
                            keyboardType: TextInputType.name,
                            autocorrect: false,
                            autofocus: false,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              icon: Padding(
                                padding: EdgeInsets.only(right: 10.0),
                                child: Icon(
                                  Icons.person,
                                  color: AppColor.blue,
                                  size: 20,
                                ),
                              ),
                              contentPadding: EdgeInsets.all(0.0),
                              filled: true,
                              fillColor: Colors.transparent,
                              labelText: 'Name',
                              hintStyle: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Bahnschrift',
                              ),
                              labelStyle: TextStyle(
                                color: Colors.white70,
                                fontFamily: 'Bahnschrift',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Column(
                children: <Widget>[
                  Container(
                    height: 53.5,
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(5.0)),
                      border: Border.all(
                        color: AppColor.blue,
                        width: 1,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 12.0, right: 12.0, top: 10.0),
                      child: Theme(
                        data: ThemeData(hintColor: Colors.transparent),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: TextFormField(
                            validator: (input) {
                              if (input!.isEmpty) {
                                return 'Please type name';
                              } else if (!input.isEmail) {
                                return 'Please enter valid an email';
                              } else {
                                return null;
                              }
                            },
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Bahnschrift',
                            ),
                            textAlign: TextAlign.start,
                            controller: controller.emailController.value,
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            autofocus: false,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              icon: Padding(
                                padding: EdgeInsets.only(right: 10.0),
                                child: Icon(
                                  Icons.email,
                                  color: AppColor.blue,
                                  size: 20,
                                ),
                              ),
                              contentPadding: EdgeInsets.all(0.0),
                              filled: true,
                              fillColor: Colors.transparent,
                              labelText: 'Email',
                              hintStyle: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Bahnschrift',
                              ),
                              labelStyle: TextStyle(
                                color: Colors.white70,
                                fontFamily: 'Bahnschrift',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Column(
                children: <Widget>[
                  Container(
                    height: 53.5,
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(5.0)),
                      border: Border.all(
                        color: AppColor.blue,
                        width: 1,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 12.0, right: 12.0, top: 10.0),
                      child: Theme(
                        data: ThemeData(hintColor: Colors.transparent),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: TextFormField(
                            validator: (input) {
                              if (input!.isEmpty) {
                                return 'Please type phone number';
                              }
                              return null;
                            },
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Bahnschrift',
                            ),
                            textAlign: TextAlign.start,
                            controller: controller.phoneController.value,
                            keyboardType: TextInputType.phone,
                            autocorrect: false,
                            autofocus: false,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              icon: Padding(
                                padding: EdgeInsets.only(right: 10.0),
                                child: Icon(
                                  Icons.phone,
                                  color: AppColor.blue,
                                  size: 20,
                                ),
                              ),
                              contentPadding: EdgeInsets.all(0.0),
                              filled: true,
                              fillColor: Colors.transparent,
                              labelText: 'Phone',
                              hintStyle: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Bahnschrift',
                              ),
                              labelStyle: TextStyle(
                                color: Colors.white70,
                                fontFamily: 'Bahnschrift',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      FocusScope.of(context).unfocus();
                      controller.updateUserDetails();
                      Get.find<HomeController>().fetchInvestmentDetail();
                    }
                  },
                  child: Container(
                    height: 50.0,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      color: AppColor.blue,
                    ),
                    child: const Center(
                      child: Text(
                        "Submit",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 20.0,
                          letterSpacing: 1.0,
                          fontFamily: 'Bahnschrift',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
