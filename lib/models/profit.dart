class Profit {
  Profit({
    this.interestAmount,
    this.totalRate,
  });

  String? interestAmount;
  String? totalRate;

  factory Profit.fromJson(Map<String, dynamic> json) => Profit(
        interestAmount: json["interest_amount"],
        totalRate: json["total_rate"],
      );
}

class ProfitData {
  String date;
  String amount;
  String currency;

  ProfitData(
    this.date,
    this.amount,
    this.currency,
  );

  factory ProfitData.fromJson(Map<String, dynamic> json) => ProfitData(
        json["date"],
        json["interest_amount"].toString(),
        json["currency"],
      );
}
