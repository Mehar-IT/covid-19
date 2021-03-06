import 'package:covid_app/screens/detail.dart';
import 'package:covid_app/services/state_services.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountryPage extends StatefulWidget {
  const CountryPage({Key? key}) : super(key: key);

  @override
  State<CountryPage> createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('Countries'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _controller,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                    hintText: 'Input Country Name',
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50))),
              )),
          Expanded(
            child: FutureBuilder(
                future: StateServices.countryData(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (!snapshot.hasData) {
                    return ListView.builder(
                        itemCount: 20,
                        itemBuilder: (context, index) {
                          return Shimmer.fromColors(
                            highlightColor: Colors.grey.shade700,
                            baseColor: Colors.grey.shade100,
                            child: ListTile(
                                title: Container(
                                    height: 10,
                                    width: 100,
                                    color: Colors.white),
                                subtitle: Container(
                                    height: 10,
                                    width: 100,
                                    color: Colors.white),
                                leading: Container(
                                    height: 50,
                                    width: 50,
                                    color: Colors.white)),
                          );
                        });
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          String name = snapshot.data![index]['country'];
                          if (_controller.text.isEmpty) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailCountry(
                                              active: snapshot.data![index]
                                                      ['active']
                                                  .toString(),
                                              cases: snapshot.data![index]
                                                      ['cases']
                                                  .toString(),
                                              death: snapshot.data![index]
                                                      ['deaths']
                                                  .toString(),
                                              flag: snapshot.data![index]
                                                      ['countryInfo']['flag']
                                                  .toString(),
                                              name: snapshot.data![index]
                                                      ['country']
                                                  .toString(),
                                              recoverd: snapshot.data![index]
                                                      ['recovered']
                                                  .toString(),
                                              todayRecovered: snapshot
                                                  .data![index]
                                                      ['todayRecovered']
                                                  .toString(),
                                            )));
                              },
                              child: ListTile(
                                  title: Text(snapshot.data![index]['country']),
                                  subtitle: Text('Cases: ' +
                                      snapshot.data![index]['cases']
                                          .toString()),
                                  leading: Image(
                                      height: 50,
                                      width: 50,
                                      image: NetworkImage(snapshot.data![index]
                                          ['countryInfo']['flag']))),
                            );
                          } else if (name
                              .toLowerCase()
                              .contains(_controller.text.toLowerCase())) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailCountry(
                                              active: snapshot.data![index]
                                                      ['active']
                                                  .toString(),
                                              cases: snapshot.data![index]
                                                      ['cases']
                                                  .toString(),
                                              death: snapshot.data![index]
                                                      ['deaths']
                                                  .toString(),
                                              flag: snapshot.data![index]
                                                      ['countryInfo']['flag']
                                                  .toString(),
                                              name: snapshot.data![index]
                                                      ['country']
                                                  .toString(),
                                              recoverd: snapshot.data![index]
                                                      ['recovered']
                                                  .toString(),
                                              todayRecovered: snapshot
                                                  .data![index]
                                                      ['todayRecovered']
                                                  .toString(),
                                            )));
                              },
                              child: ListTile(
                                  title: Text(snapshot.data![index]['country']),
                                  subtitle: Text('Cases: ' +
                                      snapshot.data![index]['cases']
                                          .toString()),
                                  leading: Image(
                                      height: 50,
                                      width: 50,
                                      image: NetworkImage(snapshot.data![index]
                                          ['countryInfo']['flag']))),
                            );
                          } else {
                            return Container();
                          }
                        });
                  }
                }),
          )
        ],
      )),
    );
  }
}
