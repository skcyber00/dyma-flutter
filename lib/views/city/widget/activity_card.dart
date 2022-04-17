import 'package:flutter/material.dart';
import '../../../models/activity_model.dart';

class ActivityCard extends StatelessWidget {
  final Activity activity;
  final bool isSelected;
  final VoidCallback toggleActivity;

  const ActivityCard({
    Key? key,
    required this.activity,
    required this.isSelected,
    required this.toggleActivity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Ink.image(
            image: AssetImage(activity.image),
            fit: BoxFit.cover,
            child: InkWell(
              onTap: toggleActivity,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (isSelected)
                        const Icon(
                          Icons.check,
                          size: 40,
                          color: Colors.white,
                        ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        activity.name,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
