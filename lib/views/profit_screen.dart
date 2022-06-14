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

    final List<Color> color = <Color>[];
    color.add(Colors.green[300]!);
    color.add(Colors.green);

    final List<double> stops = <double>[];
    stops.add(0.0);

    stops.add(1.0);

    final LinearGradient gradientColors = LinearGradient(
      colors: color,
      stops: stops,
      transform: GradientRotation(270.toDouble() * 3.14 / 180),
    );

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColor.primaryBackground,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'Profit',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Bahnschrift',
            ),
          ),
        ),
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFF373940),
                        border: Border.all(color: const Color(0xFF373940)),
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
                    ),
                    Obx(
                      () => controller.profitType.value == 1
                          ? SfCartesianChart(
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
                            )
                          : controller.profitType.value == 2
                              ? SfCartesianChart(
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
                                      gradient: gradientColors,
                                    ),
                                  ],
                                )
                              : SfCartesianChart(
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
                                      gradient: gradientColors,
                                    ),
                                  ],
                                ),
                    ),
                    Container(
                      height: 45,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        color: Colors.black26,
                      ),
                      child: TabBar(
                        indicatorColor: const Color(0xFF31A1C9),
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.white54,
                        indicator: ShapeDecoration.fromBoxDecoration(
                          const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
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
