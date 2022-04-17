import 'package:flutter/material.dart';
import '../../../models/activity_model.dart';
import './activity_card.dart';

class ActivityList extends StatelessWidget {
  final List<Activity> activities;
  final List<Activity> selectedActivities;
  final Function toggleActivity;

  const ActivityList({
    Key? key,
    required this.activities,
    required this.selectedActivities,
    required this.toggleActivity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      mainAxisSpacing: 1,
      crossAxisSpacing: 1,
      crossAxisCount: 2,
      children: activities
          .map(
            (activity) => ActivityCard(
              activity: activity,
              isSelected: selectedActivities.contains(activity),
              toggleActivity: () {
                toggleActivity(activity);
              },
            ),
          )
          .toList(),
    );
  }
}
