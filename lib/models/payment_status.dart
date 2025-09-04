enum PaymentStatus { payed, notPayed }

extension PaymentStatusExtension on PaymentStatus {
  String toDbString() {
    switch (this) {
      case PaymentStatus.payed:
        return "payed";
      case PaymentStatus.notPayed:
        return "not-payed";
    }
  }

  static PaymentStatus fromDbString(String value) {
    switch (value) {
      case "payed":
        return PaymentStatus.payed;
      case "not-payed":
        return PaymentStatus.notPayed;
      default:
        throw ArgumentError("Invalid PaymentStatus: $value");
    }
  }
}
