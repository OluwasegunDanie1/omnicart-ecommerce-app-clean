import 'package:flutter_dotenv/flutter_dotenv.dart';

String publishableKey =
    "pk_test_51SfgirLw1sVrjcKo0JpWfLMnim3MR6TdqIpfUCT2PfPLPA7VfLXmxNdUmMAVgBdaE5NZ43lnl8y8ess1AqaQxHtx004aZN1SeT";

String secretKey = dotenv.env['STRIPE_API_KEY'] ?? "YOUR_STRIPE_API_KEY";
