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
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _controller,
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
                          return ListTile(
                              title: Text(snapshot.data![index]['country']),
                              subtitle: Text('Cases: ' +
                                  snapshot.data![index]['cases'].toString()),
                              leading: Image(
                                  height: 60,
                                  width: 70,
                                  image: NetworkImage(snapshot.data![index]
                                      ['countryInfo']['flag'])));
                        });
                  }
                }),
          )
        ],
      )),
    );
  }
}
