import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shelbi_finance/constants/api.dart';
import 'package:shelbi_finance/constants/app_color.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'SUPPORT / ASSISTANCE',
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
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "Hai bisogno di aiuto?\n\nApri un ticket esponendo la tua richiesta o il tuo problema e verrai ricontattato il prima possibile da uno dei nostri consulenti.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Bahnschrift',
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(height: 30.0),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: GestureDetector(
              onTap: () async {
                await launchUrl(Uri.parse(Api.SUPPORT));
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
                    "Support Tickets",
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
    );
  }
}
