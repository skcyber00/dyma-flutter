import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/providers/trip_provider.dart';
import '/providers/city_provider.dart';
import '/views/home/home_view.dart';
import '/views/city/widget/trip_activity_list.dart';
import '../widgets/dyma_drawer.dart';
import './widget/activity_list.dart';
import './widget/trip_overview.dart';
import '../../models/city_model.dart';
import '../../models/activity_model.dart';
import '../../models/trip_model.dart';

class CityView extends StatefulWidget {
  static const String routeName = '/city';

  const CityView({
    Key? key,
  }) : super(key: key);

  @override
  _CityState createState() => _CityState();
}

class _CityState extends State<CityView> {
  // final List<Activity> activities = data.activities;
  late Trip mytrip;
  late int index;

  double get amount {
    return mytrip.activities.fold(0.0, (prev, element) {
      return prev + element.price;
    });
  }

  void setDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2023),
    ).then((newDate) {
      if (newDate != null) {
        setState(() {
          mytrip.date = newDate;
        });
      }
    });
  }

  void switchIndex(newIndex) {
    setState(() {
      index = newIndex;
    });
  }

  void toggleActivity(Activity activity) {
    setState(() {
      mytrip.activities.contains(activity)
          ? mytrip.activities.remove(activity)
          : mytrip.activities.add(activity);
    });
  }

  void deleteTripActivity(Activity activity) {
    setState(() {
      mytrip.activities.remove(activity);
    });
  }

  void saveTrip(String cityName) async {
    final result = await showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Voulez-vous sauvegarder ?'),
          contentPadding: const EdgeInsets.all(20),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, 'cancel');
                    },
                    child: const Text('Annuler')),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, 'save');
                  },
                  child: const Text('Savegarder',
                      style: TextStyle(color: Colors.white)),
                )
              ],
            )
          ],
        );
      },
    );
    if (mytrip.date == null) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Attenteion ! '),
            content: const Text('Vous n\'avez pas entré de date'),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Ok'))
            ],
          );
        },
      );
    } else if (result == 'save') {
      mytrip.city = cityName;
      Provider.of<TripProvider>(context).addTrip(mytrip);
      Navigator.pushNamed(context, HomeView.routeName);
    }
  }

  @override
  void initState() {
    super.initState();
    index = 0;
    mytrip = Trip(
      activities: [],
      city: 'null',
      date: DateTime.now(),
    );
  }

  @override
  Widget build(BuildContext context) {
    var cityName = ModalRoute.of(context)!.settings.arguments;
    City city = Provider.of<CityProvider>(context).getCityByName(cityName);
    // print(city);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Organisation voyage'),
        actions: const <Widget>[
          Icon(Icons.more_vert),
        ],
      ),
      drawer: const DymaDrawer(),
      body: Column(
        children: [
          TripOverview(
            cityname: city.name,
            setDate: setDate,
            mytrip: mytrip,
            amount: amount,
          ),
          Expanded(
            child: index == 0
                ? ActivityList(
                    activities: city.activities,
                    selectedActivities: mytrip.activities,
                    toggleActivity: toggleActivity,
                  )
                : TripActivityList(
                    activities: mytrip.activities,
                    deleteTripActivity: deleteTripActivity,
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.forward),
        onPressed: () {
          saveTrip(city.name);
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Decouverte',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.stars),
            label: 'Mes activités',
          ),
        ],
        onTap: switchIndex,
      ),
    );
  }
}
