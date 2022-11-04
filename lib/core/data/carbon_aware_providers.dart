import 'dart:convert';
import 'package:green_mode/core/data/constants/location.dart';
import 'package:green_mode/core/data/models/emission.dart';
import 'package:green_mode/core/data/util/time_util.dart';
import 'package:http/http.dart' as http;

import 'package:green_mode/core/data/constants/carbon_aware_api_constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final locationProvider = StateProvider<Location>((ref) => Location.uksouth);

final canAutoLoadImageProvider = FutureProvider<bool>((ref) async {
  final currentEmission = await ref.watch(currentEmissionProvider.future);

  final location = ref.watch(locationProvider);

  return currentEmission.rating <= location.veryGoodThreshold;
});

final currentEmissionProvider = FutureProvider<Emission>((ref) async {
  final location = ref.watch(locationProvider);

  final Uri url = Uri.parse(
    CarbonAwareApiConstants.getCurrentEmissionByLocationRequestURL(
        location.name),
  );

  final response = await http.get(url);

  final List<dynamic> jsonResponses = jsonDecode(response.body);

  return Emission.fromJson(jsonResponses[0]);
});

final todaysEmissionProvider = FutureProvider<List<Emission>>((ref) async {
  //get in local time:
  //start of day time, current time, end of day time
  //round current time to the nearest 5
  //convert to utc: all above

  //get emission btw start of day and current time
  //get forecast between (current time + 5 minutes) to end time

  //convert the list of emission in LOCAL TIME

  final location = ref.watch(locationProvider);

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
    (a, b) =>
        a.time.millisecondsSinceEpoch.compareTo(b.time.millisecondsSinceEpoch),
  );

  return todaysEmissionList;
});
