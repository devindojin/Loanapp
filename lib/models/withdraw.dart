class Withdraw {
  Withdraw({
    this.interestAmount,
    this.totalRate,
  });

  String? interestAmount;
  String? totalRate;

  factory Withdraw.fromJson(Map<String, dynamic> json) => Withdraw(
        interestAmount: json["withdraw_amount"],
        totalRate: json["withdraw_rate"],
      );
}

class WithdrawData {
  String date;
  String amount;
  String currency;

  WithdrawData(
    this.date,
    this.amount,
    this.currency,
  );

  factory WithdrawData.fromJson(Map<String, dynamic> json) => WithdrawData(
        json["date"],
        json["withdraw_amount"].toString(),
        json["currency"],
      );
}
