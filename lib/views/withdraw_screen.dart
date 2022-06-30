// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shelbi_finance/constants/app_color.dart';
import 'package:shelbi_finance/models/profit.dart';
import 'package:shelbi_finance/models/withdraw.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../controllers/withdraw_controller.dart';
import 'widgets/profit_data_widget.dart';

class WithdrawScreen extends StatelessWidget {
  const WithdrawScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WithdrawController(apiClient: Get.find()));

    /*final List<Color> color = <Color>[];
    color.add(Colors.red[300]!);
    color.add(Colors.red);

    final List<double> stops = <double>[];
    stops.add(0.0);

    stops.add(1.0);

    final LinearGradient gradientColors = LinearGradient(
      colors: color,
      stops: stops,
      transform: GradientRotation(270.toDouble() * 3.14 / 180),
    );*/

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColor.primaryBackground,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'WITHDRAW',
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
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, right: 10, bottom: 10),
                child: Column(
                  children: [
                    const Text(
                      'Outgoing Withdraw',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Obx(
                      () => Text(
                        controller.profit.value.interestAmount ?? '0',
                        style: const TextStyle(
                          fontSize: 23,
                          color: Colors.white,
                          fontFamily: 'Bahnschrift',
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                    Obx(
                      () => controller.profitType.value == 1
                          ? SizedBox(
                              height: Get.width * 9 / 16,
                              child: SfCartesianChart(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                plotAreaBorderWidth: 0,
                                primaryXAxis: DateTimeAxis(
                                  interval: 1,
                                  intervalType: DateTimeIntervalType.days,
                                  majorGridLines:
                                      const MajorGridLines(width: 0),
                                  majorTickLines:
                                      const MajorTickLines(width: 0),
                                  dateFormat: DateFormat.d(),
                                ),
                                primaryYAxis: NumericAxis(isVisible: false),
                                series: <ChartSeries>[
                                  AreaSeries<WithdrawData, DateTime>(
                                    dataSource: controller.profitData.value,
                                    xValueMapper: (WithdrawData sales, _) =>
                                        DateFormat('yy-MM-dd')
                                            .parse(sales.date),
                                    yValueMapper: (WithdrawData sales, _) =>
                                        double.parse(sales.amount),
                                    borderColor: Colors.red.withOpacity(0.7),
                                    borderWidth: 1.5,
                                    color: Colors.red.withOpacity(0.1),
                                    markerSettings: const MarkerSettings(
                                      isVisible: true,
                                      color: AppColor.primaryBackground,
                                      width: 12,
                                      height: 12,
                                      borderWidth: 2,
                                      borderColor: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : controller.profitType.value == 2
                              ? SizedBox(
                                  height: Get.width * 9 / 16,
                                  child: SfCartesianChart(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    plotAreaBorderWidth: 0,
                                    primaryXAxis: DateTimeAxis(
                                      interval: 1,
                                      intervalType: DateTimeIntervalType.months,
                                      majorGridLines:
                                          const MajorGridLines(width: 0),
                                      majorTickLines:
                                          const MajorTickLines(width: 0),
                                      dateFormat: DateFormat.MMM(),
                                    ),
                                    primaryYAxis: NumericAxis(isVisible: false),
                                    series: <ChartSeries>[
                                      AreaSeries<WithdrawData, DateTime>(
                                        dataSource: controller.profitData.value,
                                        xValueMapper: (WithdrawData sales, _) =>
                                            DateFormat('yy-MM-dd')
                                                .parse(sales.date),
                                        yValueMapper: (WithdrawData sales, _) =>
                                            double.parse(sales.amount),
                                        borderColor:
                                            Colors.red.withOpacity(0.7),
                                        borderWidth: 1.5,
                                        color: Colors.red.withOpacity(0.1),
                                        markerSettings: const MarkerSettings(
                                          isVisible: true,
                                          color: AppColor.primaryBackground,
                                          width: 12,
                                          height: 12,
                                          borderWidth: 2,
                                          borderColor: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : SizedBox(
                                  height: Get.width * 9 / 16,
                                  child: SfCartesianChart(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    plotAreaBorderWidth: 0,
                                    primaryXAxis: DateTimeAxis(
                                      interval: 1,
                                      intervalType: DateTimeIntervalType.years,
                                      majorGridLines:
                                          const MajorGridLines(width: 0),
                                      majorTickLines:
                                          const MajorTickLines(width: 0),
                                      dateFormat: DateFormat.y(),
                                    ),
                                    primaryYAxis: NumericAxis(isVisible: false),
                                    series: <ChartSeries>[
                                      AreaSeries<WithdrawData, DateTime>(
                                        dataSource: controller.profitData.value,
                                        xValueMapper: (WithdrawData sales, _) =>
                                            DateFormat('yy-MM-dd')
                                                .parse(sales.date),
                                        yValueMapper: (WithdrawData sales, _) =>
                                            double.parse(sales.amount),
                                        borderColor:
                                            Colors.red.withOpacity(0.7),
                                        borderWidth: 1.5,
                                        color: Colors.red.withOpacity(0.1),
                                        markerSettings: const MarkerSettings(
                                          isVisible: true,
                                          color: AppColor.primaryBackground,
                                          width: 12,
                                          height: 12,
                                          borderWidth: 2,
                                          borderColor: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                    ),
                    const SizedBox(height: 10),
                    Obx(
                      () => LinearPercentIndicator(
                        width: Get.width - 20,
                        animation: true,
                        lineHeight: 25.0,
                        percent: double.parse(
                                controller.profit.value.totalRate ?? '0') /
                            100,
                        backgroundColor: const Color(0xFF252528),
                        center: Text(
                          (controller.profit.value.totalRate ?? '0') + '%',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                        barRadius: const Radius.circular(5.0),
                        linearGradient: LinearGradient(
                          colors: <Color>[Colors.red[300]!, Colors.red],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Transactions',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      height: 45,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(6.0)),
                        color: AppColor.newBlack,
                      ),
                      child: TabBar(
                        indicatorColor: const Color(0xFF31A1C9),
                        labelColor: Colors.white,
                        unselectedLabelColor: AppColor.blue,
                        labelStyle: const TextStyle(
                          fontSize: 18,
                          fontFamily: 'Bahnschrift',
                        ),
                        indicator: ShapeDecoration.fromBoxDecoration(
                          const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(6.0)),
                            color: Color(0xFF31A1C9),
                          ),
                        ),
                        onTap: (index) {
                          switch (index) {
                            case 0:
                              controller.fetchProfitData(1);
                              break;
                            case 1:
                              controller.fetchProfitData(2);
                              break;
                            case 2:
                              controller.fetchProfitData(3);
                              break;
                          }
                        },
                        tabs: const [
                          Tab(text: 'Day'),
                          Tab(text: 'Month'),
                          Tab(text: 'Year'),
                        ],
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      child: Obx(
                        () => TabBarView(
                          children: [
                            ProfitDataWidget(
                              profitData: controller.profitData.value
                                  .map((e) =>
                                      ProfitData(e.date, e.amount, e.currency))
                                  .toList(),
                              amount: controller.profit.value.interestAmount,
                              dateTimeFormat: 'MMM dd yyyy',
                            ),
                            ProfitDataWidget(
                              profitData: controller.profitData.value
                                  .map((e) =>
                                      ProfitData(e.date, e.amount, e.currency))
                                  .toList(),
                              amount: controller.profit.value.interestAmount,
                              dateTimeFormat: 'MMM',
                            ),
                            ProfitDataWidget(
                              profitData: controller.profitData.value
                                  .map((e) =>
                                      ProfitData(e.date, e.amount, e.currency))
                                  .toList(),
                              amount: controller.profit.value.interestAmount,
                              dateTimeFormat: 'yyyy',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
