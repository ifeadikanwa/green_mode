import 'dart:convert';
import 'package:green_mode/core/data/constants/location.dart';
import 'package:green_mode/core/data/models/emission.dart';
import 'package:http/http.dart' as http;

import 'package:green_mode/core/data/constants/carbon_aware_api_constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

final locationProvider = StateProvider<Location>((ref) => Location.northeurope);
