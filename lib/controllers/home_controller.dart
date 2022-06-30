import 'dart:async';

import 'package:get/get.dart';
import 'package:shelbi_finance/constants/api.dart';
import 'package:shelbi_finance/models/investment_response.dart';
import 'package:shelbi_finance/services/api_client.dart';

import 'base_controller.dart';

class HomeController extends GetxController with BaseController {
  final ApiClient apiClient;

  HomeController({required this.apiClient});

  final Rx<InvestmentResponse> investment = InvestmentResponse().obs;
  final RxList<CardDetails> cardDetails = <CardDetails>[].obs;
  final RxInt currentCard = 0.obs;
  final RxBool loading = true.obs;

  late Timer _timer;

  @override
  void onInit() {
    super.onInit();

    _timer = Timer(const Duration(seconds: 7), () {
      loading.value = false;
    });
  }

  @override
  void dispose() {
    _timer.cancel();

    super.dispose();
  }

  @override
  void onReady() {
    super.onReady();

    fetchInvestmentDetail();
  }

  void fetchInvestmentDetail() async {
    // showLoading();

    dynamic response =
        await apiClient.post(Api.MY_INVESTMENT).catchError(handleError);

    // hideLoading();

    // Handle response & bind to the UI
    InvestmentResponse investmentResponse =
        InvestmentResponse.fromJson(response);

    cardDetails.clear();
    cardDetails.add(investmentResponse.cardDetails!);

    switch (investmentResponse.cardDetails!.cardColorType) {
      case CardColorType.blue:
        cardDetails.add(CardDetails(
            cardColorType: CardColorType.gold,
            cardName: "",
            accountNumber:
                "TO CHANGE YOUR INVESTMENT PLAN PLEASE CONTACT AN OUR AGENT.",
            userName: "",
            expiryDate: ""));
        cardDetails.add(CardDetails(
            cardColorType: CardColorType.black,
            cardName: "",
            accountNumber:
                "TO CHANGE YOUR INVESTMENT PLAN PLEASE CONTACT AN OUR AGENT.",
            userName: "",
            expiryDate: ""));
        break;
      case CardColorType.gold:
        cardDetails.add(CardDetails(
            cardColorType: CardColorType.black,
            cardName: "",
            accountNumber:
                "TO CHANGE YOUR INVESTMENT PLAN PLEASE CONTACT AN OUR AGENT.",
            userName: "",
            expiryDate: ""));
        break;
      case CardColorType.black:
        break;
    }

    investment.value = investmentResponse;
  }
}
