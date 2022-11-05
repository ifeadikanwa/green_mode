import 'dart:convert';
import 'package:green_mode/core/data/constants/location.dart';
import 'package:green_mode/core/data/models/emission.dart';
import 'package:green_mode/core/data/util/time_util.dart';
import 'package:http/http.dart' as http;

import 'package:green_mode/core/data/constants/carbon_aware_api_constants.dart';
import 'package:green_mode/core/data/models/emission.dart';

class CarbonAwareService {
  static Future<List<Emission>> getTodaysEmission(Location location) async {
    final currentTimeUTC = TimeUtil.getCurrentUTCTime();
    final dayStartTimeUTC = TimeUtil.getStartOfDayUTCTime();
    final dayEndTimeUTC = TimeUtil.getEndOfDayUTCTime();

    final List<Emission> todaysEmissionList = [];

//emission so far
    final emissionsSoFarUrl = Uri.parse(
      CarbonAwareApiConstants.getEmissionBetweenTimeByLocationRequestURL(
        location: location.name,
        startTime: TimeUtil.convertUTCTimeToCarbonAwareApiTimeString(
          dayStartTimeUTC,
        ),
        endTime: TimeUtil.convertUTCTimeToCarbonAwareApiTimeString(
          currentTimeUTC,
        ),
      ),
    );

    final emissionSoFarResponse = await http.get(emissionsSoFarUrl);

    final List<dynamic> emissionsSoFarList = jsonDecode(
      emissionSoFarResponse.body,
    );

    for (Map<String, dynamic> emission in emissionsSoFarList) {
      todaysEmissionList.add(Emission.fromJson(emission));
    }

//emission forecast
    final emissionForecastUrl = Uri.parse(
      CarbonAwareApiConstants.getEmissionForecastByLocationRequestURL(
        location: location.name,
        startTime: TimeUtil.convertUTCTimeToCarbonAwareApiTimeString(
          currentTimeUTC.add(
            const Duration(
              minutes: 5,
            ),
          ),
        ),
        endTime: TimeUtil.convertUTCTimeToCarbonAwareApiTimeString(
          dayEndTimeUTC,
        ),
      ),
    );

    final emissionForecastResponse = await http.get(emissionForecastUrl);

    final List<dynamic> emissionForecastResponseList =
        jsonDecode(emissionForecastResponse.body);

    final Map<String, dynamic> emissionForecastResponseMap =
        emissionForecastResponseList[0];

    final List<dynamic> emissionForecastList =
        emissionForecastResponseMap["forecastData"];

    for (Map<String, dynamic> forecastEmission in emissionForecastList) {
      todaysEmissionList.add(Emission.forecastFromJson(forecastEmission));
    }

    todaysEmissionList.sort(
      (a, b) => a.time.millisecondsSinceEpoch
          .compareTo(b.time.millisecondsSinceEpoch),
    );

    return todaysEmissionList;
  }

  static Future<DateTime> getBestEmissionTime(Location location) async {
    final daysEmissions = await getTodaysEmission(location);

    final currentTime = DateTime.now();

    final emissionsToCome = daysEmissions
        .where(
          (emission) =>
              emission.time.hour >= currentTime.hour &&
              emission.time.minute >= currentTime.minute,
        )
        .toList();

    //sort in ascending order
    emissionsToCome.sort((a, b) => a.rating.compareTo(b.rating));

    return emissionsToCome.first.time;
  }
}
