import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_color.dart';
import '../constants/app_image.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    String description = "";

    switch (title) {
      case "CAPITAL":
        description =
            "I capitali sono custoditi su Squared Financial di cui tu hai le chiavi di accesso.\n\nIn questa casella viene riportata la somma in euro che hai depositato.\n\nPer aumentare il capitale investito e di conseguenza alzare i tuoi rendimenti annui ti basterà aprire un ticket e verrai ricontattato dal tuo consulente di riferimento per una consulenza strategica.";
        break;
      case "YEARS":
        description =
            "In questa sezione viene riportata la durata contrattuale che hai pattuito con il consulente.\n\nPer aumentare la durata contrattuale e di conseguenza alzare i tuoi rendimenti annui ti basterà aprire un ticket e verrai ricontattato dal tuo consulente di riferimento per una consulenza strategica dove potrai beneficiare di accordi ancora più redditizi.";
        break;
      case "INTEREST":
        description =
            "In questa sezione viene riportata la % contrattuale che hai pattuito con il consulente.\n\nPer aumentare la % contrattuale e di conseguenza alzare i tuoi rendimenti annui ti basterà aprire un ticket e verrai ricontattato dal tuo consulente di riferimento per una consulenza strategica dove potrai beneficiare di accordi ancora più redditizi.";
        break;
    }

    return Scaffold(
      backgroundColor: AppColor.primaryBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          title,
          style: const TextStyle(
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
          Container(
            height: 100,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImage.polygon),
                fit: BoxFit.contain,
              ),
            ),
            child: Center(
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Bahnschrift',
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'Bahnschrift',
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
