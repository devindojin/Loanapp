import 'package:get/get.dart';
import 'package:shelbi_finance/constants/api.dart';
import 'package:shelbi_finance/models/profit.dart';
import 'package:shelbi_finance/services/api_client.dart';

import 'base_controller.dart';

class ProfitController extends GetxController with BaseController {
  final ApiClient apiClient;

  ProfitController({required this.apiClient});

  final RxList<ProfitData> profitData = <ProfitData>[].obs;
  final Rx<Profit> profit = Profit().obs;

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
        .post(Api.PROFIT_DATA, body: body)
        .catchError(handleError);

    hideLoading();

    if (response != null) {
      profitData.value = List<ProfitData>.from(
          response["profit"].map((x) => ProfitData.fromJson(x)));
    } else {
      profitData.clear();
    }
  }

  void fetchProfit() async {
    dynamic response =
        await apiClient.post(Api.MY_PROFIT).catchError(handleError);

    profit.value = Profit.fromJson(response);
  }

  /// Find the first date of the week which contains the provided date.
  DateTime findFirstDateOfTheWeek() {
    final dateTime = DateTime.now();
    return dateTime.subtract(Duration(days: dateTime.weekday - 1));
  }

  /// Find last date of the week which contains provided date.
  DateTime findLastDateOfTheWeek() {
    final dateTime = DateTime.now();
    return dateTime
        .add(Duration(days: DateTime.daysPerWeek - dateTime.weekday));
  }
}
