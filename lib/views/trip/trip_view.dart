import 'package:flutter/material.dart';
import 'package:projet1/providers/city_provider.dart';
import 'package:projet1/providers/trip_provider.dart';
import 'package:provider/provider.dart';
import '/views/trip/widgets/trip_activities.dart';
import '/views/trip/widgets/trip_city_bar.dart';
import '../../models/city_model.dart';
import '../../models/trip_model.dart';

class TripView extends StatelessWidget {
  static const String routeName = '/trip';

  const TripView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cityName = (ModalRoute.of(context)!.settings.arguments
        as Map<String, String>)['cityName'];
    var tripId = (ModalRoute.of(context)!.settings.arguments
        as Map<String, String>)['tripId'];
    final City city = Provider.of<CityProvider>(context, listen: false)
        .getCityByName(cityName);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              TripCityBar(city: city),
              TripActivities(tripId: tripId!),
            ],
          ),
        ),
      ),
    );
  }
}
