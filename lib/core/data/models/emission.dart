import 'package:equatable/equatable.dart';

class Emission extends Equatable {
  final String location;
  final String time;
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
      time: json['time'] as String,
      rating: json['rating'] as double,
      duration: json['duration'] as String,
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
