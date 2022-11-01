// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:jitsi_meet/feature_flag/feature_flag.dart';

enum CallResolution {
  LD_RESOLUTION(
    presentationName: "Low resolution video",
    flag: FeatureFlagVideoResolution.LD_RESOLUTION,
    presentationColor: Colors.red,
  ),
  MD_RESOLUTION(
    presentationName: "Medium resolution video",
    flag: FeatureFlagVideoResolution.MD_RESOLUTION,
    presentationColor: Colors.orange,
  ),
  HD_RESOLUTION(
    presentationName: "High resolution video",
    flag: FeatureFlagVideoResolution.HD_RESOLUTION,
    presentationColor: Colors.green,
  );

  const CallResolution({
    required this.presentationName,
    required this.flag,
    required this.presentationColor,
  });

  final String presentationName;
  final int flag;
  final Color presentationColor;
}
