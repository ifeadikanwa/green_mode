// ignore_for_file: constant_identifier_names

import 'package:jitsi_meet/feature_flag/feature_flag.dart';

enum CallResolution {
  LD_RESOLUTION(
    presentationName: "Low resolution video",
    flag: FeatureFlagVideoResolution.LD_RESOLUTION,
  ),
  MD_RESOLUTION(
    presentationName: "Medium resolution video",
    flag: FeatureFlagVideoResolution.MD_RESOLUTION,
  ),
  HD_RESOLUTION(
    presentationName: "High resolution video",
    flag: FeatureFlagVideoResolution.HD_RESOLUTION,
  );

  const CallResolution({required this.presentationName, required this.flag});

  final String presentationName;
  final int flag;
}
