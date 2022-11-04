import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_mode/call/data/constants/call_resolution.dart';
import 'package:green_mode/core/data/carbon_aware_providers.dart';

final usernameProvider = StateProvider<String>((ref) => "");

final userEmailProvider = StateProvider<String>((ref) => "");

final callUrlProvider = StateProvider<String>((ref) => "");

final startWithAudioProvider = StateProvider<bool>((ref) => false);

final startWithVideoProvider = StateProvider<bool>((ref) => false);

final callResolutionProvider = FutureProvider<CallResolution>((ref) async {
  final currentEmission = await ref.watch(currentEmissionProvider.future);
  final location = ref.watch(locationProvider);

  if (currentEmission.rating <= location.veryGoodThreshold) {
    return CallResolution.HD_RESOLUTION;
  } else if (currentEmission.rating <= location.goodThreshold) {
    return CallResolution.MD_RESOLUTION;
  } else {
    return CallResolution.LD_RESOLUTION;
  }
});
