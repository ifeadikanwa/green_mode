class CarbonAwareApiConstants {
  static const String baseURL = "https://carbon-aware-api.azurewebsites.net";
  static const String emissionByLocationEndpoint =
      "/emissions/bylocation?location=";

  static getCurrentEmissionByLocationRequestURL(String location) {
    return "$baseURL$emissionByLocationEndpoint$location";
  }
}
