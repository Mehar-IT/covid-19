import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();
  final coloList = <Color>[
    Color(0xffeb490e),
    Color(0xff0cf0ca),
    Color(0xff0319a3),
  ];
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            PieChart(
              chartRadius: MediaQuery.of(context).size.width / 2.7,
              legendOptions: LegendOptions(legendPosition: LegendPosition.left),
              dataMap: {
                'Total': 100,
                'Recoverd': 50,
                'Death': 10,
              },
              animationDuration: Duration(seconds: 3),
              chartType: ChartType.ring,
              colorList: coloList,
            ),
            SizedBox(height: 50),
            Container(
              height: MediaQuery.of(context).size.width / 2,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Data(title: 'Total', value: '100'),
                      Data(title: 'Recoverd', value: '40'),
                      Data(title: 'Death', value: '10'),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 50),
            Container(
              decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(12)),
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.width / 10,
              child: Center(child: Text('Track Country')),
            )
          ],
        ),
      ),
    ));
  }
}

class Data extends StatelessWidget {
  final String title, value;
  Data({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            Text(value),
          ],
        ),
        Divider()
      ],
    );
  }
}
