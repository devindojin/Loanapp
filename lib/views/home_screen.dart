import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shelbi_finance/constants/api.dart';
import 'package:shelbi_finance/constants/app_color.dart';
import 'package:shelbi_finance/constants/app_image.dart';
import 'package:shelbi_finance/controllers/home_controller.dart';
import 'package:shelbi_finance/models/investment_response.dart';
import 'package:url_launcher/url_launcher.dart';

import 'profit_screen.dart';
import 'widgets/credit_card_widget.dart';
import 'widgets/nav_bar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final HomeController controller =
        Get.put(HomeController(apiClient: Get.find()));

    return Scaffold(
      key: _key,
      backgroundColor: AppColor.black,
      drawer: const NavBar(),
      body: Container(
        width: Get.width,
        height: Get.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImage.background),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 25, right: 25, top: 35, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          _key.currentState?.openDrawer();
                        },
                        child: Image.asset(AppImage.menuBar),
                      ),
                      InkWell(
                        onTap: () async {
                          Get.back();
                          await launchUrl(Uri.parse(Api.SUPPORT));
                        },
                        child: Image.asset(
                          AppImage.assistance,
                          height: 24,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: Get.width,
                  padding: const EdgeInsets.all(30.0),
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppImage.frame),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  child: Column(
                    children: [
                      Obx(
                        () => Text(
                          controller.investment.value.cardDetails?.userName ??
                              '',
                          style: const TextStyle(
                            color: Color(0xFF42bfd7),
                            fontSize: 20,
                            fontFamily: 'Bank Gothic',
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      const Text(
                        'Total Balance',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Bank Gothic',
                        ),
                      ),
                      const SizedBox(height: 5),
                      Obx(
                        () => Text(
                          controller.investment.value.investmentDetail
                                  ?.totalBalance.balance ??
                              '\$0',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Bahnschrift',
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Obx(
                        () => Row(
                          children: [
                            const SizedBox(width: 10),
                            _profitWithrawal(
                              AppImage.greenFrame,
                              'Profit',
                              controller.investment.value.profit ?? '\$0',
                            ),
                            const SizedBox(width: 15),
                            _profitWithrawal(
                              AppImage.redFrame,
                              'Withdrawal',
                              '\$0',
                            ),
                            const SizedBox(width: 10),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 5.0, bottom: 20.0),
                  child: Obx(
                    () => Row(
                      children: [
                        _poly(
                          AppImage.polygon,
                          'CAPITAL',
                          controller.investment.value.investmentDetail
                                  ?.capitalAmount ??
                              '0',
                        ),
                        const SizedBox(width: 25),
                        _poly(
                          AppImage.polygon,
                          'YEARS',
                          controller.investment.value.investmentDetail
                                  ?.duration ??
                              '0',
                        ),
                        const SizedBox(width: 25),
                        _poly(
                          AppImage.polygon,
                          'INTEREST',
                          controller.investment.value.investmentDetail
                                  ?.interestRate ??
                              '0',
                        ),
                      ],
                    ),
                  ),
                ),
                CarouselSlider(
                  options: CarouselOptions(
                    aspectRatio: 1 / 2,
                    viewportFraction: 1.0,
                    enableInfiniteScroll: false,
                    height: 220.0,
                  ),
                  items: [
                    Obx(
                      () => CreditCardWidget(
                        name:
                            controller.investment.value.cardDetails?.cardName ??
                                '',
                        number: controller
                                .investment.value.cardDetails?.accountNumber ??
                            '',
                        holderName:
                            controller.investment.value.cardDetails?.userName ??
                                '',
                        expDate: controller
                                .investment.value.cardDetails?.expiryDate ??
                            '',
                        colors: controller.investment.value.cardDetails
                                ?.cardColorType.colors ??
                            CardColorType.gold.colors,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Image.asset(
                  AppImage.homeLogo,
                  height: 110,
                  width: 110,
                ),
                const SizedBox(height: 10.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _profitWithrawal(String image, String title, String value) {
    return Expanded(
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Get.to(() => const ProfitScreen());
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.fitWidth,
                ),
              ),
              child: Center(
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 17,
                    color: title == 'Profit' ? Colors.green : Colors.red,
                    fontFamily: 'Bahnschrift',
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Bank Gothic',
            ),
          ),
        ],
      ),
    );
  }

  Widget _poly(String image, String title, String value) {
    return Expanded(
      child: Column(
        children: [
          Container(
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(image),
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
          const SizedBox(height: 5.0),
          Text(
            title,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.white,
              fontFamily: 'Bank Gothic',
            ),
          ),
        ],
      ),
    );
  }
}
