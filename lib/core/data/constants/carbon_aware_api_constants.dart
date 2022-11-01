class CarbonAwareApiConstants {
  static const String baseURL = "https://carbon-aware-api.azurewebsites.net";
  static const String emissionByLocationEndpoint =
      "/emissions/bylocation?location=";

  static String getCurrentEmissionByLocationRequestURL(String location) {
    return "$baseURL$emissionByLocationEndpoint$location";
  }

  static String getEmissionBetweenTimeByLocationRequestURL({
    required String location,
    required String startTime,
    required String endTime,
  }) {
    return "${getCurrentEmissionByLocationRequestURL(location)}&time=$startTime&toTime=$endTime";
  }

  static String  getEmissionForecastByLocationRequestURL({
    required String location,
    required String startTime,
    required String endTime,
  }) {
    return "$baseURL/emissions/forecasts/current?location=$location&dataStartAt=$startTime&dataEndAt=$endTime";
  }
}
