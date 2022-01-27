import 'package:covid_app/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

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
        title: Text(name),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Column(
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 5, right: 5),
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
          SizedBox(height: 20),
          PieChart(
            chartValuesOptions:
                ChartValuesOptions(showChartValuesInPercentage: true),
            chartRadius: MediaQuery.of(context).size.width / 3,
            legendOptions: LegendOptions(legendPosition: LegendPosition.left),
            dataMap: {
              'Total': double.parse(cases),
              'Recoverd': double.parse(recoverd),
              'Active': double.parse(active),
            },
            animationDuration: Duration(seconds: 3),
            chartType: ChartType.disc,
            colorList: coloList,
          ),
        ],
      ),
    );
  }
}
