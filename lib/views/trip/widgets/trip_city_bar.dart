import 'package:flutter/material.dart';
import '../../../models/city_model.dart';

class TripCityBar extends StatelessWidget {
  final City city;

  const TripCityBar({
    Key? key,
    required this.city,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          Image.asset(
            city.image,
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black38,
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 30,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      city.name,
                      style: const TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
