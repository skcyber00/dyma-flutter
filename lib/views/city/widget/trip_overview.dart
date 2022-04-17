import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../models/trip_model.dart';

class TripOverview extends StatelessWidget {
  final VoidCallback setDate;
  final Trip mytrip;
  final String cityname;
  final double amount;

  const TripOverview({
    Key? key,
    required this.setDate,
    required this.mytrip,
    required this.cityname,
    required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 200,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            cityname,
            style: const TextStyle(
                fontSize: 25, decoration: TextDecoration.underline),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  mytrip.date != null
                      ? DateFormat("d/M/y").format(mytrip.date)
                      : 'Choisissez une date',
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              ElevatedButton(
                  onPressed: setDate,
                  child: const Text('Selectionner une date'))
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Montant / personne',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Text(
                '$amount €',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          )
        ],
      ),
    );
  }
}
