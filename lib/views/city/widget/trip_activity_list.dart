import 'package:flutter/material.dart';
import '../../../models/activity_model.dart';

class TripActivityList extends StatelessWidget {
  final List<Activity> activities;
  final Function deleteTripActivity;

  const TripActivityList({
    Key? key,
    required this.activities,
    required this.deleteTripActivity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemBuilder: (context, index) {
          var activity = activities[index];
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(activity.image),
              ),
              title: Text(activity.name),
              subtitle: Text(activity.city),
              trailing: IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () {
                  deleteTripActivity(activity.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Activité supprimé'),
                      backgroundColor: Colors.red,
                      duration: const Duration(seconds: 3),
                      action: SnackBarAction(
                        label: 'annuler',
                        textColor: Colors.white,
                        onPressed: () {},
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
        itemCount: activities.length,
      ),
    );
  }
}
