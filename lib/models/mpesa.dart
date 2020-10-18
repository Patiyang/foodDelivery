import 'package:mpesa/mpesa.dart';

class MpesaPayment {
  static final Mpesa mpesa = Mpesa(
    clientKey: 'GF1jzL26VBGJ6DMZ2lQxzBMzFk5O7dG6',
    clientSecret: '6MXoflqiRYXAG29U',
    environment: 'sandbox',
    initiatorPassword: 'Shortcode 1',
    passKey: 'bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919',
  );
}
