// razorpay,
// stripe,
// paystack,
// flutterwave,
// mollie,
// braintree,
// adyen,
// square,
// authorizeNet,
// worldpay,
// cyberSource,
// payu,
// molliePayLater,
// klarnaPayLater,
// afterpayClearpay,
// zipPayLater,
// laybuyPayLater,
// sezzlePayLater,
// splititPayLater,
enum PaymentGateway {
  momo,
  vnpay;

  String get title {
    switch (this) {
      case PaymentGateway.momo:
        return 'Momo';
      case PaymentGateway.vnpay:
        return 'VNPAY';
    }
  }

  String get logoAsset {
    switch (this) {
      case PaymentGateway.momo:
        return 'assets/images/momo.png';
      case PaymentGateway.vnpay:
        return 'assets/images/vnpay.png';
    }
  }
}
