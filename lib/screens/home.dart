import 'package:covid_app/models/world_model.dart';
import 'package:covid_app/services/state_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

import 'country_page.dart';

final coloList = <Color>[
  Color(0xffeb490e),
  Color(0xff0cf0ca),
  Color(0xff0319a3),
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // with TickerProviderStateMixin
  // late final AnimationController _controller =
  //     AnimationController(duration: const Duration(seconds: 3), vsync: this)
  //       ..repeat();

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          centerTitle: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text('World Covid-19'),
        ),
        body: SafeArea(child: Builder()));
  }
}

class Data extends StatelessWidget {
  final String title, value;
  Data({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}

class Builder extends StatelessWidget {
  const Builder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: StateServices.fetchData(),
        builder: (context, AsyncSnapshot<WorldModel> snapShot) {
          if (!snapShot.hasData) {
            return SpinKitFadingCircle(
              color: Colors.white,
              size: 50,
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        PieChart(
                          chartValuesOptions: ChartValuesOptions(
                              showChartValuesInPercentage: true),
                          chartRadius: MediaQuery.of(context).size.width / 2.7,
                          legendOptions: LegendOptions(
                              legendPosition: LegendPosition.left),
                          dataMap: {
                            'Total': snapShot.data!.cases!.toDouble(),
                            'Recoverd': snapShot.data!.recovered!.toDouble(),
                            'Death': snapShot.data!.deaths!.toDouble(),
                          },
                          animationDuration: Duration(seconds: 3),
                          chartType: ChartType.ring,
                          colorList: coloList,
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Column(
                        children: [
                          Data(
                              title: 'Total',
                              value: '${snapShot.data!.population}'),
                          Data(
                              title: 'Recoverd',
                              value: '${snapShot.data!.recovered}'),
                          Data(
                              title: 'Death',
                              value: '${snapShot.data!.deaths}'),
                          Data(
                              title: 'Active',
                              value: '${snapShot.data!.active}'),
                          Data(
                              title: 'Tests', value: '${snapShot.data!.tests}'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CountryPage()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.circular(12)),
                      width: MediaQuery.of(context).size.width / 2,
                      height: MediaQuery.of(context).size.width / 10,
                      child: Center(child: Text('Track Country')),
                    ),
                  )
                ],
              ),
            );
          }
        });
  }
}
