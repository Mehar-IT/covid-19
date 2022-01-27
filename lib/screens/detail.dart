import 'package:covid_app/screens/home.dart';
import 'package:flutter/material.dart';

class DetailCountry extends StatelessWidget {
  final String name, flag, cases, todayRecovered, recoverd, active, death;
  const DetailCountry(
      {Key? key,
      required this.active,
      required this.cases,
      required this.death,
      required this.flag,
      required this.name,
      required this.recoverd,
      required this.todayRecovered})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Data(title: 'cases', value: cases),
                      Data(title: 'death', value: death),
                      Data(title: 'active', value: active),
                      Data(title: 'recoverd', value: recoverd),
                      Data(title: 'todayRecovered', value: todayRecovered),
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(flag),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
