// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shelbi_finance/constants/app_color.dart';
import 'package:shelbi_finance/controllers/profit_controller.dart';
import 'package:shelbi_finance/models/profit.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'widgets/profit_data_widget.dart';

class ProfitScreen extends StatelessWidget {
  const ProfitScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfitController(apiClient: Get.find()));

    /*final List<Color> color = <Color>[];
    color.add(Colors.green[300]!);
    color.add(Colors.green);

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
            'PROFIT',
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
                      'Incoming Profit',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Obx(
                      () => Text(
                        controller.profit.value.interestAmount ?? '0',
                        style: const TextStyle(
                          fontSize: 28,
                          color: Colors.white,
                          fontFamily: 'Bahnschrift',
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.bold,
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
                                  minimum: controller
                                      .findFirstDateOfTheWeek()
                                      .subtract(const Duration(days: 1)),
                                  maximum: controller.findLastDateOfTheWeek(),
                                ),
                                primaryYAxis: NumericAxis(isVisible: false),
                                series: <ChartSeries>[
                                  AreaSeries<ProfitData, DateTime>(
                                    dataSource: controller.profitData.value,
                                    xValueMapper: (ProfitData sales, _) =>
                                        DateFormat('yy-MM-dd')
                                            .parse(sales.date),
                                    yValueMapper: (ProfitData sales, _) =>
                                        double.parse(sales.amount),
                                    borderColor: Colors.green.withOpacity(0.7),
                                    borderWidth: 1.5,
                                    color: Colors.green.withOpacity(0.1),
                                    markerSettings: const MarkerSettings(
                                      isVisible: true,
                                      color: AppColor.primaryBackground,
                                      width: 12,
                                      height: 12,
                                      borderWidth: 2,
                                      borderColor: Colors.green,
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
                                      AreaSeries<ProfitData, DateTime>(
                                        dataSource: controller.profitData.value,
                                        xValueMapper: (ProfitData sales, _) =>
                                            DateFormat('yy-MM-dd')
                                                .parse(sales.date),
                                        yValueMapper: (ProfitData sales, _) =>
                                            double.parse(sales.amount),
                                        borderColor:
                                            Colors.green.withOpacity(0.7),
                                        borderWidth: 1.5,
                                        color: Colors.green.withOpacity(0.1),
                                        markerSettings: const MarkerSettings(
                                          isVisible: true,
                                          color: AppColor.primaryBackground,
                                          width: 12,
                                          height: 12,
                                          borderWidth: 2,
                                          borderColor: Colors.green,
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
                                      AreaSeries<ProfitData, DateTime>(
                                        dataSource: controller.profitData.value,
                                        xValueMapper: (ProfitData sales, _) =>
                                            DateFormat('yy-MM-dd')
                                                .parse(sales.date),
                                        yValueMapper: (ProfitData sales, _) =>
                                            double.parse(sales.amount),
                                        borderColor:
                                            Colors.green.withOpacity(0.7),
                                        borderWidth: 1.5,
                                        color: Colors.green.withOpacity(0.1),
                                        markerSettings: const MarkerSettings(
                                          isVisible: true,
                                          color: AppColor.primaryBackground,
                                          width: 12,
                                          height: 12,
                                          borderWidth: 2,
                                          borderColor: Colors.green,
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
                        backgroundColor: const Color(0xFF18191d),
                        center: Text(
                          (controller.profit.value.totalRate ?? '0') + '%',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                        barRadius: const Radius.circular(5.0),
                        linearGradient: LinearGradient(
                          colors: <Color>[Colors.green[300]!, Colors.green],
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
                          Tab(text: 'WEEK'),
                          Tab(text: 'MONTH'),
                          Tab(text: 'YEAR'),
                        ],
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      child: Obx(
                        () => TabBarView(
                          children: [
                            ProfitDataWidget(
                              profitData: controller.profitData.value,
                              amount: controller.profit.value.interestAmount,
                              dateTimeFormat: 'MMM dd yyyy',
                            ),
                            ProfitDataWidget(
                              profitData: controller.profitData.value,
                              amount: controller.profit.value.interestAmount,
                              dateTimeFormat: 'MMM',
                            ),
                            ProfitDataWidget(
                              profitData: controller.profitData.value,
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

/*SfCartesianChart(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              plotAreaBorderWidth: 0,
                              primaryXAxis: DateTimeAxis(
                                interval: 1,
                                intervalType: DateTimeIntervalType.days,
                                majorGridLines: const MajorGridLines(width: 0),
                                majorTickLines: const MajorTickLines(width: 0),
                                dateFormat: DateFormat.d(),
                              ),
                              primaryYAxis: NumericAxis(isVisible: false),
                              series: <ChartSeries>[
                                LineSeries<ProfitData, DateTime>(
                                  dataSource: controller.profitData.value,
                                  xValueMapper: (ProfitData sales, _) =>
                                      DateFormat('yy-MM-dd').parse(sales.date),
                                  yValueMapper: (ProfitData sales, _) =>
                                      double.parse(sales.amount),
                                  markerSettings: const MarkerSettings(
                                    isVisible: true,
                                    color: Colors.green,
                                    width: 12,
                                    height: 12,
                                    borderWidth: 3,
                                    borderColor: Colors.green,
                                  ),
                                  color: Colors.green[300]!,
                                  width: 3,
                                ),
                              ],
                            )*/
                          /*SfCartesianChart(
                              plotAreaBorderWidth: 0,
                              primaryXAxis: DateTimeAxis(
                                interval: 1,
                                intervalType: DateTimeIntervalType.days,
                                majorGridLines: const MajorGridLines(width: 0),
                                majorTickLines: const MajorTickLines(width: 0),
                                dateFormat: DateFormat.d(),
                              ),
                              primaryYAxis: NumericAxis(isVisible: false),
                              series: <ChartSeries>[
                                AreaSeries<ProfitData, DateTime>(
                                  dataSource: controller.profitData.value,
                                  xValueMapper: (ProfitData sales, _) =>
                                      DateFormat('yy-MM-dd').parse(sales.date),
                                  yValueMapper: (ProfitData sales, _) =>
                                      double.parse(sales.amount),
                                  gradient: gradientColors,
                                ),
                              ],
                            )*/


/*Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFF31A1C9),
                        border: Border.all(
                            color:
                                const Color(0xFF31A1C9) /*Color(0xFF373940)*/),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 35.0,
                                width: 35.0,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40.0)),
                                  color: Colors.lightGreen,
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.file_download,
                                    size: 18.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 30),
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
                            ],
                          ),
                          const SizedBox(height: 15),
                          Obx(
                            () => LinearPercentIndicator(
                              width: MediaQuery.of(context).size.width - 50,
                              animation: true,
                              lineHeight: 18.0,
                              percent: double.parse(
                                      controller.profit.value.totalRate ??
                                          '0') /
                                  100,
                              backgroundColor: const Color(0xFF252528),
                              center: Text(
                                (controller.profit.value.totalRate ?? '0') +
                                    '%',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                              barRadius: const Radius.circular(10.0),
                              linearGradient: LinearGradient(
                                colors: <Color>[
                                  Colors.green[300]!,
                                  Colors.green
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),*/