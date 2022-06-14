import 'package:flutter/material.dart';
import 'package:shelbi_finance/constants/app_image.dart';

class CreditCardWidget extends StatelessWidget {
  const CreditCardWidget({
    Key? key,
    required this.name,
    required this.number,
    required this.holderName,
    required this.expDate,
    required this.colors,
  }) : super(key: key);

  final String name;
  final String number;
  final String holderName;
  final String expDate;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 15.0, right: 15.0, top: 10.0, bottom: 5.0),
      child: Stack(
        children: [
          Container(
            height: 220.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: colors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Image.asset(
                        AppImage.logo,
                        width: 100,
                        height: 105,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 25.0),
                      child: Text(
                        name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontFamily: 'Myriad Pro',
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0, top: 5.0),
                  child: Text(
                    number,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Myriad Pro',
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 25.0, right: 25.0, top: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text(
                          holderName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'Myriad Pro',
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          const Text(
                            'Date',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'Myriad Pro',
                            ),
                          ),
                          Text(
                            expDate,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Myriad Pro',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              height: 170.0,
              width: 170.0,
              decoration: BoxDecoration(
                color: Colors.white10.withOpacity(0.1),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(200.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
