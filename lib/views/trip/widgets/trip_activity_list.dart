import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/models/trip_model.dart';
import '/providers/trip_provider.dart';
import '/models/activity_model.dart';

class TripActivityList extends StatelessWidget {
  final String tripId;
  final ActivityStatus filter;

  const TripActivityList({
    Key? key,
    required this.filter,
    required this.tripId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TripProvider>(
      builder: (context, tripProvider, child) {
        final Trip trip = Provider.of<TripProvider>(context).getById(tripId);
        final List<Activity> activities = trip.activities
            .where((activity) => activity.status == filter)
            .toList();

        return ListView.builder(
          itemCount: activities.length,
          itemBuilder: (context, i) {
            Activity activity = activities[i];
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: filter == ActivityStatus.ongoing
                  ? Dismissible(
                      direction: DismissDirection.endToStart,
                      background: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        alignment: Alignment.centerRight,
                        child: const Icon(Icons.check,
                            color: Colors.white, size: 30),
                        decoration: BoxDecoration(
                          color: Colors.greenAccent.shade700,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      key: ValueKey(activity.id),
                      child: Card(
                        child: ListTile(title: Text(activity.name)),
                      ),
                      onDismissed: (_) {
                        Provider.of<TripProvider>(context)
                            .setActivityToDone(activity);
                      },
                    )
                  : Card(
                      child: ListTile(
                        title: Text(
                          activity.name,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
            );
          },
        );
      },
    );
  }
}
