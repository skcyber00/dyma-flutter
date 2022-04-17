import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../models/activity_model.dart';
import '../models/trip_model.dart';
import 'package:http/http.dart' as http;

class TripProvider with ChangeNotifier {
  final String host = 'http://10.0.2.2:80';
  List<Trip> _trips = [];
  bool isLoading = false;

  UnmodifiableListView<Trip> get trips => UnmodifiableListView(_trips);

  void addTrip(Trip trip) {
    _trips.add(trip);
    notifyListeners();
  }

  Trip getById(String tripId) {
    return trips.firstWhere((trip) => trip.id == tripId);
  }

  void setActivityToDone(Activity activity) {
    activity.status = ActivityStatus.done;
    notifyListeners();
  }

  Future<void> fetchData() async {
    try {
      isLoading = true;
      http.Response response = await http.get(Uri.parse('$host/api/trips'));
      if (response.statusCode == 200) {
        _trips = (json.decode(response.body) as List)
            .map((tripJson) => Trip.fromJson(tripJson))
            .toList();
        isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      rethrow;
    }
  }
}
