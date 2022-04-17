import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/providers/trip_provider.dart';
import '/views/trips/widgets/trip_list.dart';
import '/views/widgets/dyma_drawer.dart';
import '../../models/trip_model.dart';
import '../widgets/dyma_drawer.dart';

class TripsView extends StatelessWidget {
  static const String routeName = '/trips';
  const TripsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Trip> trips = Provider.of<TripProvider>(context).trips;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Mes voyages'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'A venir'),
              Tab(text: 'Passés'),
            ],
          ),
        ),
        drawer: const DymaDrawer(),
        body: TabBarView(
          children: [
            TripList(
              trips: trips
                  .where((trip) => DateTime.now().isBefore(trip.date))
                  .toList(),
            ),
            TripList(
              trips: trips
                  .where((trip) => DateTime.now().isAfter(trip.date))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
