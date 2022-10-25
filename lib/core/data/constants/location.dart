import 'package:green_mode/core/data/constants/country_code.dart';

enum Location {
  //north america
  centralus(countryCode: CountryCode.us),
  eastus(countryCode: CountryCode.us),
  westus(countryCode: CountryCode.us),
  northcentralus(countryCode: CountryCode.us),
  canadaeast(countryCode: CountryCode.ca),
  canadacentral(countryCode: CountryCode.ca),
  //europe
  northeurope(countryCode: CountryCode.gb),
  uksouth(countryCode: CountryCode.gb),
  ukwest(countryCode: CountryCode.gb),
  //australia
  australiaeast(countryCode: CountryCode.au),
  australiacentral(countryCode: CountryCode.au),
  australiasoutheast(countryCode: CountryCode.au);
  //asia
  //africa
  //south america

  const Location({required this.countryCode});
  final String countryCode;
}
