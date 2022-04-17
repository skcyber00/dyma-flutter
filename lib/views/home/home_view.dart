import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/providers/city_provider.dart';
import '/views/widgets/dyma_loader.dart';
import '../widgets/dyma_drawer.dart';
import '../../models/city_model.dart';

import 'widgets/city_card.dart';

class HomeView extends StatefulWidget {
  static const String routeName = '/';

  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeState createState() {
    return _HomeState();
  }
}

class _HomeState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    List<City> cities = Provider.of<CityProvider>(context).cities;

    return Scaffold(
      appBar: AppBar(
        title: const Text('DymaTrip'),
      ),
      drawer: const DymaDrawer(),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: RefreshIndicator(
          onRefresh:
              Provider.of<CityProvider>(context, listen: false).fetchData,
          child: cities.length > 0
              ? ListView.builder(
                  itemCount: cities.length,
                  itemBuilder: (_, i) => CityCard(
                    city: cities[i],
                  ),
                )
              : const DymaLoader(),
        ),
      ),
    );
  }
}
