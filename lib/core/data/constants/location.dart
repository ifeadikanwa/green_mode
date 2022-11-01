import 'package:green_mode/core/data/constants/country_code.dart';

enum Location {
  //north america
  
  eastus(
    countryCode: CountryCode.us,
    veryGoodThreshold: 530.0,
    goodThreshold: 580.0,
    okayThreshold: 650.0,
  ),
  canadacentral(
    countryCode: CountryCode.ca,
    veryGoodThreshold: 465.0,
    goodThreshold: 480.0,
    okayThreshold: 600.0,
  ),
  //europe
  uksouth(
    countryCode: CountryCode.gb,
    veryGoodThreshold: 350.0,
    goodThreshold: 400.0,
    okayThreshold: 500.0,
  ),
  //australia
  australiasoutheast(
    countryCode: CountryCode.au,
    veryGoodThreshold: 500.0,
    goodThreshold: 760.0,
    okayThreshold: 1000.0,
  );
  //asia
  //africa
  //south america

  const Location({
    required this.countryCode,
    required this.veryGoodThreshold,
    required this.goodThreshold,
    required this.okayThreshold,
  });

  final String countryCode;
  final double veryGoodThreshold;
  final double goodThreshold;
  final double okayThreshold;
}
