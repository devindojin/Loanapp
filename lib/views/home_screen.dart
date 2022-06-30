import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shelbi_finance/constants/app_image.dart';
import 'package:shelbi_finance/controllers/home_controller.dart';
import 'package:shelbi_finance/models/investment_response.dart';
import 'package:shelbi_finance/views/info_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/api.dart';
import 'profit_screen.dart';
import 'support_screen.dart';
import 'widgets/credit_card_widget.dart';
import 'widgets/nav_bar.dart';
import 'withdraw_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final HomeController controller =
        Get.put(HomeController(apiClient: Get.find()));

    return Obx(
      () => controller.loading.value
          ? Container(
              width: Get.width,
              height: Get.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImage.loginAnimation),
                  fit: BoxFit.cover,
                ),
              ),
            )
          : Scaffold(
              key: _key,
              backgroundColor: Colors.transparent,
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: InkWell(
                  onTap: () {
                    _key.currentState?.openDrawer();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, top: 16.0),
                    child: Image.asset(AppImage.menuBar),
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, right: 25.0),
                    child: SizedBox(
                      height: 24,
                      width: 24,
                      child: InkWell(
                        onTap: () {
                          Get.to(() => const SupportScreen());
                        },
                        child: Image.asset(
                          AppImage.assistance,
                          height: 24,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              drawer: const NavBar(),
              body: Container(
                width: Get.width,
                height: Get.height,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppImage.backgroundGif),
                    fit: BoxFit.cover,
                  ),
                ),
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 15.0),
                        Container(
                          width: Get.width,
                          padding: const EdgeInsets.only(
                              left: 30.0, right: 30.0, top: 30.0, bottom: 15.0),
                          margin: const EdgeInsets.symmetric(horizontal: 20.0),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12.0)),
                            border: Border.all(
                              color: const Color(0xFF0a7e9b),
                              width: 2.0,
                            ),
                          ),
                          child: Column(
                            children: [
                              Obx(
                                () => Text(
                                  controller.investment.value.cardDetails
                                          ?.userName ??
                                      '',
                                  style: const TextStyle(
                                    color: Color(0xFF42bfd7),
                                    fontSize: 20,
                                    fontFamily: 'Bank Gothic',
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
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
                                      "0\$",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Bahnschrift',
                                  ),
                                ),
                              ),
                              const SizedBox(height: 25),
                              Obx(
                                () => Row(
                                  children: [
                                    const SizedBox(width: 5),
                                    _profitWithrawal(
                                      AppImage.greenFrame,
                                      'Profit',
                                      '+  ' +
                                          (controller.investment.value.profit ??
                                              "0\$"),
                                    ),
                                    const SizedBox(width: 15),
                                    _profitWithrawal(
                                      AppImage.redFrame,
                                      'Withdrawal',
                                      '-  ' +
                                          (controller
                                                  .investment.value.withdraw ??
                                              "0\$"),
                                    ),
                                    const SizedBox(width: 5),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 15.0, bottom: 20.0),
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
                        Obx(
                          () => Column(
                            children: [
                              CarouselSlider(
                                options: CarouselOptions(
                                  aspectRatio: 1 / 2,
                                  viewportFraction: 1.0,
                                  enableInfiniteScroll: false,
                                  height: 220.0,
                                  onPageChanged: (index, _) {
                                    controller.currentCard.value = index;
                                  },
                                ),
                                items: controller.cardDetails
                                    .map((element) => CreditCardWidget(
                                          name: element.cardName,
                                          number: element.accountNumber,
                                          holderName: element.userName,
                                          expDate: element.expiryDate,
                                          colors: element.cardColorType.colors,
                                        ))
                                    .toList(),
                              ),
                              if (controller.cardDetails.length > 1)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: controller.cardDetails
                                      .asMap()
                                      .entries
                                      .map((entry) {
                                    return Container(
                                      width: 12.0,
                                      height: 12.0,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 4.0),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: controller.currentCard.value ==
                                                entry.key
                                            ? Colors.white.withOpacity(0.8)
                                            : Colors.white.withOpacity(0.4),
                                      ),
                                    );
                                  }).toList(),
                                )
                            ],
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        GestureDetector(
                          onTap: () async {
                            await launchUrl(Uri.parse(Api.NEWS));
                          },
                          child: Image.asset(
                            AppImage.homeLogo,
                            height: 95,
                            width: 95,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                      ],
                    ),
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
              if (title == 'Profit') {
                Get.to(() => const ProfitScreen());
              } else {
                Get.to(() => const WithdrawScreen());
              }
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
      child: GestureDetector(
        onTap: () {
          Get.to(() => InfoScreen(
                title: title,
                value: value,
              ));
        },
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
      ),
    );
  }
}
