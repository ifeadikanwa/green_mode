import 'package:green_mode/core/data/constants/location.dart';
import 'package:green_mode/green_do/data/energy_quality.dart';

bool canPerformActivity({
  required Location location,
  required double emissionValue,
  required EnergyQuality activityMinQuality,
}) {
  switch (activityMinQuality) {
    case EnergyQuality.veryGood:
      return emissionValue <= location.veryGoodThreshold;
    case EnergyQuality.good:
      return emissionValue <= location.goodThreshold;
    default:
      return true;
  }
}
