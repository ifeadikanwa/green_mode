import 'package:green_mode/green_do/data/energy_quality.dart';

enum Activity {
  washerAndDryer(
    presentationName: "Run washer and dryer",
    minimumQuality: EnergyQuality.veryGood,
  ),
  dishwasher(
    presentationName: "Run dishwasher",
    minimumQuality: EnergyQuality.veryGood,
  ),
  socialMedia(
    presentationName: "Use social media",
    minimumQuality: EnergyQuality.good,
  ),
  airConditioner(
    presentationName: "Use air conditioning",
    minimumQuality: EnergyQuality.veryGood,
  ),
  heating(
    presentationName: "Use heating",
    minimumQuality: EnergyQuality.veryGood,
  ),
  waterHeating(
    presentationName: "Run water heater",
    minimumQuality: EnergyQuality.veryGood,
  ),
  streamOnline(
    presentationName: "Stream online",
    minimumQuality: EnergyQuality.veryGood,
  ),
  elaborateResearch(
    presentationName: "Do elaborate research online",
    minimumQuality: EnergyQuality.good,
  ),
  electricVehicle(
    presentationName: "Charge electric vehicle",
    minimumQuality: EnergyQuality.veryGood,
  ),
  downloadLargeFiles(
    presentationName: "Download large files",
    minimumQuality: EnergyQuality.veryGood,
  ),

  gadgets(
    presentationName: "Charge gadgets",
    minimumQuality: EnergyQuality.okay,
  ),

  onlineGaming(
    presentationName: "Play games online",
    minimumQuality: EnergyQuality.veryGood,
  );

  const Activity({
    required this.presentationName,
    required this.minimumQuality,
  });

  final String presentationName;
  final EnergyQuality minimumQuality;
}
