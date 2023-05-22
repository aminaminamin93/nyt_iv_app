import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iv_nyt_app/search.dart';
import 'package:iv_nyt_app/view/articles/most_populars.dart';

void main() async{
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nyt Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'NYT'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double myLatitude = 0.00;
  double myLongitude = 0.0;

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  void _getCurrentLocation() async {
    Position position = await _determinePosition();
    setState(() {
      myLatitude = position.latitude;
      myLongitude = position.longitude;
    });
  }

  @override
  void initState() {
    _getCurrentLocation();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.title)),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 50,
        padding: const EdgeInsets.only(top: 4),
        surfaceTintColor: Colors.white,
        shadowColor: Colors.transparent,
        child: Column(
          children: [
            const Text('Current Location',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87
                )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Latitude: ${myLongitude.toString()}",
                    style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54
                    )
                ),
                const SizedBox(width: 10,),
                Text("Longitude: ${myLongitude.toString()}",
                    style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54
                    )
                )
              ],
            )
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            const SizedBox(height: 10,),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 4),
              child:
              Text('Search', style: TextStyle(fontWeight: FontWeight.bold),),
            ),
            HomeNavButtonWidget(btnTitle: 'Search Articles', btnAction: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchWidget()),
              );
            }),
            const SizedBox(height: 30,),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 4),
              child:
              Text('Popular', style: TextStyle(fontWeight: FontWeight.bold),),
            ),
            HomeNavButtonWidget(btnTitle: 'Most Viewed', btnAction: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MostPopularArticles(type: 'viewed', title: 'Most Viewed Articles',)),
              );
            }),
            HomeNavButtonWidget(btnTitle: 'Most Shared', btnAction: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MostPopularArticles(type: 'shared', title: 'Most Shared Articles',)),
              );
            }),
            HomeNavButtonWidget(btnTitle: 'Most Emailed', btnAction: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MostPopularArticles(type: 'emailed', title: 'Most Emailed Articles',)),
              );
            }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class HomeNavButtonWidget extends StatelessWidget {
  const HomeNavButtonWidget({
      super.key,
      required this.btnTitle,
      required this.btnAction,
    });

  final String btnTitle;
  final dynamic btnAction;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: btnAction,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(btnTitle,
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black54
                  )
              ),
              const Icon(Icons.keyboard_arrow_right, color: Colors.black54,)
            ],
          ),
        ),
      ),
    );
  }
}
