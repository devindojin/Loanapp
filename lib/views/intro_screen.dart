import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:shelbi_finance/constants/app_image.dart';
import 'package:shelbi_finance/controllers/auth_controller.dart';
import 'package:shelbi_finance/views/sign_in_screen.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const headerStyle = TextStyle(
      fontSize: 21.0,
      fontWeight: FontWeight.w800,
      color: Color(0xFF45C2DA),
      letterSpacing: 1.5,
    );

    const descriptionStyle = TextStyle(
      fontSize: 15.0,
      color: Colors.white70,
      fontWeight: FontWeight.w400,
    );

    return IntroViewsFlutter(
      [
        PageViewModel(
          pageColor: Colors.black,
          iconColor: Colors.white,
          bubbleBackgroundColor: Colors.white,
          body: Column(
            children: const [
              Text(
                "BENVENUTO IN SHELBI FINANCE PRO",
                style: headerStyle,
              ),
              SizedBox(height: 25),
              Text(
                "10 anni avanti nel futuro",
                textAlign: TextAlign.center,
                style: descriptionStyle,
              ),
            ],
          ),
          mainImage: Image.asset(
            AppImage.intro_1,
            height: 285.0,
            width: 285.0,
            alignment: Alignment.center,
          ),
        ),
        PageViewModel(
          pageColor: Colors.black,
          iconColor: Colors.white,
          bubbleBackgroundColor: Colors.white,
          body: Column(
            children: const [
              Text(
                "COSA FACCIAMO?",
                style: headerStyle,
              ),
              SizedBox(height: 25),
              Text(
                "Mettiamo a disposizione il nostro ecosistema certificato e le abilità dei nostri trader a disposizione di tutte le persone che vogliono beneficiare degli alti rendimenti del trading senza dover avere nessuna competenza in essa",
                textAlign: TextAlign.center,
                style: descriptionStyle,
              ),
            ],
          ),
          mainImage: Image.asset(
            AppImage.intro_2,
            height: 285.0,
            width: 285.0,
            alignment: Alignment.center,
          ),
        ),
        PageViewModel(
          pageColor: Colors.black,
          iconColor: Colors.white,
          bubbleBackgroundColor: Colors.white,
          body: Column(
            children: const [
              Text(
                "AVRAI IL TOTALE CONTROLLO DEI TUOI CAPITALI",
                style: headerStyle,
              ),
              SizedBox(height: 25),
              Text(
                "",
                textAlign: TextAlign.center,
                style: descriptionStyle,
              ),
            ],
          ),
          mainImage: Image.asset(
            AppImage.intro_3,
            height: 285.0,
            width: 285.0,
            alignment: Alignment.center,
          ),
        ),
        PageViewModel(
          pageColor: Colors.black,
          iconColor: Colors.white,
          bubbleBackgroundColor: Colors.white,
          body: Column(
            children: const [
              Text(
                "SE NON SEI ANCORA CLIENTE",
                style: headerStyle,
              ),
              SizedBox(height: 25),
              Text(
                "clicca su SCOPRI DI PIU' e dal sito fissa una consulenza strategica a GRATIS",
                textAlign: TextAlign.center,
                style: descriptionStyle,
              ),
            ],
          ),
          mainImage: Image.asset(
            AppImage.intro_4,
            height: 285.0,
            width: 285.0,
            alignment: Alignment.center,
          ),
        ),
      ],
      showSkipButton: true,
      pageButtonsColor: Colors.white,
      background: Colors.black,
      onTapSkipButton: () {
        Get.find<AuthController>().setUserFirstTime();
        Get.off(() => SignInScreen());
      },
      onTapDoneButton: () {
        Get.find<AuthController>().setUserFirstTime();
        Get.off(() => SignInScreen());
      },
    );
  }
}
