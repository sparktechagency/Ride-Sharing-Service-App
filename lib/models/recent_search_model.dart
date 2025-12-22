import 'dart:convert';

class RecentSearchModel {
  final String pickup;
  final String dropoff;
  final String date;
  final int passengers;

  RecentSearchModel({
    required this.pickup,
    required this.dropoff,
    required this.date,
    required this.passengers,
  });

  Map<String, dynamic> toJson() => {
    'pickup': pickup,
    'dropoff': dropoff,
    'date': date,
    'passengers': passengers,
  };

  factory RecentSearchModel.fromJson(Map<String, dynamic> json) => RecentSearchModel(
    pickup: json['pickup'],
    dropoff: json['dropoff'],
    date: json['date'],
    passengers: json['passengers'],
  );
}