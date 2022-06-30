import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shelbi_finance/constants/app_color.dart';
import 'package:shelbi_finance/models/profit.dart';

class ProfitDataWidget extends StatelessWidget {
  const ProfitDataWidget({
    Key? key,
    required this.profitData,
    required this.amount,
    required this.dateTimeFormat,
  }) : super(key: key);

  final List<ProfitData> profitData;
  final String? amount;
  final String dateTimeFormat;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12.0, bottom: 10),
      decoration: const BoxDecoration(
        color: AppColor.primaryBackground,
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            spreadRadius: 2.0,
          )
        ],
      ),
      child: ListView(
        shrinkWrap: true,
        // physics: const NeverScrollableScrollPhysics(),
        children: [
          /*Container(
            height: 90.0,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF31A1C9), Color(0xFF3DB6D4)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          'Amount of use',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          amount ?? '0',
                          style: const TextStyle(
                            fontSize: 19,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 35.0,
                    width: 35.0,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: const Icon(
                      Icons.account_balance_wallet,
                      color: Color(0xFF3DB6D4),
                    ),
                  ),
                ],
              ),
            ),
          ),*/
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF31A1C9), Color(0xFF3DB6D4)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'AMOUNT OF USE',
                      style: TextStyle(
                        color: AppColor.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Bahnschrift',
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      amount ?? '0',
                      style: const TextStyle(
                        fontSize: 20,
                        color: AppColor.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Bahnschrift',
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ...List.generate(
            profitData.length,
            (index) => Container(
              color: index % 2 == 0
                  ? const Color(0xFF121214)
                  : const Color(0xFF020001),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 15, bottom: 15),
                child: Row(
                  children: [
                    /*Container(
                      width: 3,
                      height: 30,
                      color: Colors.white12,
                    ),
                    const SizedBox(width: 20),*/
                    Text(
                      '${profitData[index].currency}${profitData[index].amount}',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white70,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      DateFormat(dateTimeFormat).format(
                          DateFormat('yy-MM-dd').parse(profitData[index].date)),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
