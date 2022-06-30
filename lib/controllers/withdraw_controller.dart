import 'package:get/get.dart';
import 'package:shelbi_finance/constants/api.dart';
import 'package:shelbi_finance/services/api_client.dart';

import '../models/withdraw.dart';
import 'base_controller.dart';

class WithdrawController extends GetxController with BaseController {
  final ApiClient apiClient;

  WithdrawController({required this.apiClient});

  final RxList<WithdrawData> profitData = <WithdrawData>[].obs;
  final Rx<Withdraw> profit = Withdraw().obs;

  final RxInt profitType = 1.obs;

  @override
  void onReady() {
    super.onReady();

    fetchProfitData(1);
    fetchProfit();
  }

  // 1 Day / 2 Month / 3 year
  void fetchProfitData(int type) async {
    profitType.value = type;
    profitData.clear();

    final body = {
      'period': '$type',
    };

    showLoading();
    dynamic response = await apiClient
        .post(Api.WITHDRAW_DATA, body: body)
        .catchError(handleError);

    hideLoading();

    if (response != null) {
      profitData.value = List<WithdrawData>.from(
          response["withdraw"].map((x) => WithdrawData.fromJson(x)));
    } else {
      profitData.clear();
    }
  }

  void fetchProfit() async {
    dynamic response =
        await apiClient.post(Api.MY_WITHDRAW).catchError(handleError);

    profit.value = Withdraw.fromJson(response);
  }
}
