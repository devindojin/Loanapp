import 'package:flutter/material.dart';

class InvestmentResponse {
  InvestmentResponse({
    this.investmentDetail,
    this.cardDetails,
    this.profit,
  });

  InvestmentDetail? investmentDetail;
  CardDetails? cardDetails;
  String? profit;

  factory InvestmentResponse.fromJson(Map<String, dynamic> json) =>
      InvestmentResponse(
        investmentDetail: json["investment_detail"] == null
            ? null
            : InvestmentDetail.fromJson(json["investment_detail"]),
        cardDetails: CardDetails.fromJson(json["card_details"]),
        profit: json["profit"],
      );
}

class CardDetails {
  CardDetails({
    required this.cardColorType,
    required this.cardName,
    required this.accountNumber,
    required this.userName,
    required this.expiryDate,
  });

  CardColorType cardColorType;
  String cardName;
  String accountNumber;
  String userName;
  String expiryDate;

  factory CardDetails.fromJson(Map<String, dynamic> json) => CardDetails(
        cardColorType: (json["card_color_type"] as String).type,
        cardName: json["card_name"],
        accountNumber: json["account_number"],
        userName: json["user_name"],
        expiryDate: json["expiry_date"],
      );
}

class InvestmentDetail {
  InvestmentDetail({
    required this.totalBalance,
    required this.duration,
    required this.interestRate,
    required this.capitalAmount,
  });

  TotalBalance totalBalance;
  String duration;
  String interestRate;
  String capitalAmount;

  factory InvestmentDetail.fromJson(Map<String, dynamic> json) =>
      InvestmentDetail(
        totalBalance: TotalBalance.fromJson(json["total_balance"]),
        duration: json["duration"],
        interestRate: json["interest_rate"],
        capitalAmount: json["capital_amount"],
      );
}

class TotalBalance {
  TotalBalance({
    required this.balance,
  });

  String balance;

  factory TotalBalance.fromJson(Map<String, dynamic> json) => TotalBalance(
        balance: json["balance"],
      );
}

enum CardColorType {
  blue, // 1
  black, // 2
  gold, // 3
}

extension _CardColorTypeX on String {
  CardColorType get type {
    switch (this) {
      case "1":
        return CardColorType.blue;
      case "2":
        return CardColorType.black;
      case "3":
        return CardColorType.gold;
      default:
        return CardColorType.gold;
    }
  }
}

extension ColorX on CardColorType {
  List<Color> get colors {
    switch (this) {
      case CardColorType.blue:
        return const [
          Color(0xFF31A1C9),
          Color(0xFF3DB6D4),
        ];
      case CardColorType.black:
        return const [
          Color(0xFF222223),
          Color(0xFF0f0e0e),
        ];
      case CardColorType.gold:
        return const [
          Color(0xFFc3a337),
          Color(0xFFb39529),
        ];
    }
  }
}
