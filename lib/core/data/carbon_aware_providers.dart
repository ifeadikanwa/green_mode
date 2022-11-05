import 'dart:convert';
import 'package:green_mode/core/data/carbon_aware_service.dart';
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

  return CarbonAwareService.getTodaysEmission(location);
});

final bestEmissionToComeTimeProvider =
    FutureProvider.autoDispose<DateTime>((ref) async {
  final daysEmissions = await ref.watch(todaysEmissionProvider.future);

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
});
