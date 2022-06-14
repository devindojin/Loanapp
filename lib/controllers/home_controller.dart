import 'package:get/get.dart';
import 'package:shelbi_finance/constants/api.dart';
import 'package:shelbi_finance/models/investment_response.dart';
import 'package:shelbi_finance/services/api_client.dart';

import 'base_controller.dart';

class HomeController extends GetxController with BaseController {
  final ApiClient apiClient;

  HomeController({required this.apiClient});

  final Rx<InvestmentResponse> investment = InvestmentResponse().obs;

  @override
  void onReady() {
    super.onReady();

    fetchInvestmentDetail();
  }

  void fetchInvestmentDetail() async {
    showLoading();

    dynamic response =
        await apiClient.post(Api.MY_INVESTMENT).catchError(handleError);

    hideLoading();

    // Handle response & bind to the UI
    InvestmentResponse investmentResponse =
        InvestmentResponse.fromJson(response);

    investment.value = investmentResponse;
  }
}
