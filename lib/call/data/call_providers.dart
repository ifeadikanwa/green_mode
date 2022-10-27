import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_mode/call/data/constants/call_resolution.dart';
import 'package:green_mode/core/data/carbon_aware_providers.dart';

final usernameProvider = StateProvider<String>((ref) => "Enter your name");

final userEmailProvider = StateProvider<String>((ref) => "Enter your email");

final callUrlProvider = StateProvider<String>((ref) => "");

final startWithAudioProvider = StateProvider<bool>((ref) => false);

final startWithVideoProvider = StateProvider<bool>((ref) => false);

final callResolutionProvider = Provider<CallResolution>((ref) {
  final currentEmission = ref.watch(currentEmissionProvider);

  //todo: use the emission to determine the resolution

  return CallResolution.MD_RESOLUTION;
});
