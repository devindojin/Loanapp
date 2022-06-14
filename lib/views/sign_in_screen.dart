import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shelbi_finance/constants/app_color.dart';
import 'package:shelbi_finance/constants/app_image.dart';
import 'package:shelbi_finance/controllers/auth_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: AppColor.primaryBackground,
      body: Center(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                Image.asset(
                  AppImage.logo,
                  width: 150,
                  height: 150,
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
                          width: 0.15,
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
                                  return 'Please type an email';
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
                          width: 0.15,
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
                                  return 'Please typle an password';
                                }
                                return null;
                              },
                              style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'Bahnschrift',
                              ),
                              textAlign: TextAlign.start,
                              controller: controller.passwordController.value,
                              keyboardType: TextInputType.emailAddress,
                              autocorrect: false,
                              obscureText: true,
                              autofocus: false,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                icon: Padding(
                                  padding: EdgeInsets.only(right: 10.0),
                                  child: Icon(
                                    Icons.vpn_key,
                                    size: 20,
                                    color: AppColor.blue,
                                  ),
                                ),
                                contentPadding: EdgeInsets.all(0.0),
                                filled: true,
                                fillColor: Colors.transparent,
                                labelText: 'Password',
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
                  padding: const EdgeInsets.only(right: 3.0, top: 9.0),
                  child: InkWell(
                    onTap: () async {
                      await launchUrl(Uri.parse(
                          'https://shelbifinance.com/password/reset'));
                    },
                    child: const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Forgot Password ?",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12.0,
                          fontFamily: 'Bahnschrift',
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        FocusScope.of(context).unfocus();
                        controller.onSignIn();
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
                          "Sign In",
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
      ),
    );
  }
}
