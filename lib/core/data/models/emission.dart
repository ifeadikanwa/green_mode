import 'package:equatable/equatable.dart';
import 'package:green_mode/core/data/util/time_util.dart';

class Emission extends Equatable {
  final String location;
  final DateTime time;
  final double rating;
  final String duration;

  const Emission({
    required this.location,
    required this.time,
    required this.rating,
    required this.duration,
  });

  factory Emission.fromJson(Map<String, dynamic> json) {
    return Emission(
      location: json['location'] as String,
      time: TimeUtil.convertCarbonAwareApiTimeStringToLocalTime(
        json['time'] as String,
      ),
      rating: json['rating'] as double,
      duration: json['duration'] as String,
    );
  }

  factory Emission.forecastFromJson(Map<String, dynamic> json) {
    return Emission(
      location: json['location'] as String,
      time: TimeUtil.convertCarbonAwareApiTimeStringToLocalTime(
        json['timestamp'] as String,
      ),
      rating: json['value'] as double,
      duration: (json['duration'] as int).toString(),
    );
  }

  @override
  List<Object?> get props => [
        location,
        time,
        rating,
        duration,
      ];
}
