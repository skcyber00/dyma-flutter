import 'package:flutter/material.dart';
import '/views/trip/widgets/trip_activity_list.dart';
import '../../../models/activity_model.dart';

class TripActivities extends StatelessWidget {
  final String tripId;

  const TripActivities({
    Key? key,
    required this.tripId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Container(
              color: Theme.of(context).primaryColor,
              child: TabBar(
                indicatorColor: Colors.blue.shade100,
                tabs: const [
                  Tab(
                    text: 'En cours',
                  ),
                  Tab(
                    text: 'Terminé',
                  ),
                ],
              ),
            ),
            Container(
              height: 600,
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  TripActivityList(
                    tripId: tripId,
                    filter: ActivityStatus.ongoing,
                  ),
                  TripActivityList(
                    tripId: tripId,
                    filter: ActivityStatus.done,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
