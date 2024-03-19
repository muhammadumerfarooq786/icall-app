import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:icall/Model/all_cases_model.dart';
import 'package:icall/Model/charts_model.dart';
import 'package:icall/Model/user_all_posts_model.dart';
import 'package:icall/services/api_service.dart';
import 'dart:convert';

class UserStats extends StatefulWidget {
  UserStats({Key? key}) : super(key: key);

  @override
  State<UserStats> createState() => _UserStatsState();
}

class _UserStatsState extends State<UserStats> {
  String CasesPosts = '';

  int violence = 0;
  int murder = 0;
  int theft = 0;
  int rape = 0;
  int others = 0;
  int islamabad = 0;
  int peshawar = 0;
  int lahore = 0;
  int multan = 0;
  int karachi = 0;

  late List<ChartModel> data = [];
  late List<ChartModel> data_city = [];

  Future<void> convertToJson() async {
    List myMap = jsonDecode(CasesPosts);
    List<UserAllPostsModel> myPosts = [];

    myMap.forEach((dynamic post) {
      UserAllPostsModel myPost = UserAllPostsModel.fromJson(post);
      if (myPost.category == "murder") {
        setState(() {
          murder = murder + 1;
        });
      } else if (myPost.category == "homeviolence") {
        setState(() {
          violence = violence + 1;
        });
      } else if (myPost.category == "accident") {
        setState(() {
          rape = rape + 1;
        });
      } else if (myPost.category == "theft") {
        setState(() {
          theft = theft + 1;
        });
      } else if (myPost.category == "others") {
        setState(() {
          others = others + 1;
        });
      }

      if (myPost.cityName == "islamabad") {
        setState(() {
          islamabad = islamabad + 1;
        });
      } else if (myPost.cityName == "lahore") {
        setState(() {
          lahore = lahore + 1;
        });
      } else if (myPost.cityName == "peshawar") {
        setState(() {
          peshawar = peshawar + 1;
        });
      } else if (myPost.cityName == "karachi") {
        setState(() {
          karachi = karachi + 1;
        });
      } else if (myPost.cityName == "multan") {
        setState(() {
          multan = multan + 1;
        });
      }

      myPosts.add(myPost);
    });

    final List<ChartModel> all_cases = [
      ChartModel(
        year: "Violence",
        financial: violence,
        color: charts.ColorUtil.fromDartColor(Colors.blueGrey),
      ),
      ChartModel(
        year: "Murder",
        financial: murder,
        color: charts.ColorUtil.fromDartColor(Colors.red),
      ),
      ChartModel(
        year: "Accident",
        financial: rape,
        color: charts.ColorUtil.fromDartColor(Colors.green),
      ),
      ChartModel(
        year: "Theft",
        financial: theft,
        color: charts.ColorUtil.fromDartColor(Colors.yellow),
      ),
      ChartModel(
        year: "Others",
        financial: others,
        color: charts.ColorUtil.fromDartColor(Colors.yellow),
      )
    ];

    final List<ChartModel> all_cities = [
      ChartModel(
        year: "Islmabad",
        financial: islamabad,
        color: charts.ColorUtil.fromDartColor(Colors.blueGrey),
      ),
      ChartModel(
        year: "Lahore",
        financial: lahore,
        color: charts.ColorUtil.fromDartColor(Colors.red),
      ),
      ChartModel(
        year: "Multan",
        financial: multan,
        color: charts.ColorUtil.fromDartColor(Colors.green),
      ),
      ChartModel(
        year: "Karachi",
        financial: karachi,
        color: charts.ColorUtil.fromDartColor(Colors.yellow),
      ),
      ChartModel(
        year: "Peshawar",
        financial: peshawar,
        color: charts.ColorUtil.fromDartColor(Colors.yellow),
      )
    ];
    setState(() {
      data = all_cases;
      data_city = all_cities;
    });
  }

  Future readJsonFile() async {
    APIService.PostDetails().then((response) {
      setState(() {
        CasesPosts = response;
      });
      if (response != "") {
        convertToJson();
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(content: Text('Success!!')),
        // );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error While Fetching Cases!!')),
        );
      }
    });
  }

  @override
  void initState() {
    readJsonFile();
    // readJsonFile();
    WidgetsFlutterBinding.ensureInitialized();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<charts.Series<ChartModel, String>> series = [
      charts.Series(
        id: "categoryCases",
        data: data,
        domainFn: (ChartModel series, _) => series.year,
        measureFn: (ChartModel series, _) => series.financial,
        colorFn: (ChartModel series, _) => series.color,
      ),
    ];

    List<charts.Series<ChartModel, String>> cityseries = [
      charts.Series(
        id: "cityCases",
        data: data_city,
        domainFn: (ChartModel series, _) => series.year,
        measureFn: (ChartModel series, _) => series.financial,
        colorFn: (ChartModel series, _) => series.color,
      ),
    ];

    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Cases Statistics"),
            centerTitle: true,
            backgroundColor: Color(0xff1976d2),
            bottom: TabBar(
              indicatorColor: Color(0xff9962D0),
              tabs: [
                Tab(icon: Icon(Icons.bar_chart_sharp)),
                Tab(
                  icon: Icon(Icons.area_chart_sharp),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 10),
                        Text(
                          'Cases Category Analysis',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        SizedBox(height: 20),
                        Expanded(
                          child: charts.BarChart(series,
                              animate: true,
                              animationDuration: Duration(seconds: 2),
                              behaviors: [
                                new charts.ChartTitle('Cases Category',
                                    behaviorPosition:
                                        charts.BehaviorPosition.bottom,
                                    titleOutsideJustification: charts
                                        .OutsideJustification.middleDrawArea),
                                new charts.ChartTitle('Number Of Cases',
                                    behaviorPosition:
                                        charts.BehaviorPosition.start,
                                    titleOutsideJustification: charts
                                        .OutsideJustification.middleDrawArea),
                              ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'City Cases Analysis',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: charts.BarChart(cityseries,
                              animate: true,
                              animationDuration: Duration(seconds: 2),
                              behaviors: [
                                new charts.ChartTitle('City',
                                    behaviorPosition:
                                        charts.BehaviorPosition.bottom,
                                    titleOutsideJustification: charts
                                        .OutsideJustification.middleDrawArea),
                                new charts.ChartTitle('Number Of Cases',
                                    behaviorPosition:
                                        charts.BehaviorPosition.start,
                                    titleOutsideJustification: charts
                                        .OutsideJustification.middleDrawArea),
                              ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// Container(
//         padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
//         child: charts.BarChart(
//           series,
//           animate: true,
//         ),
//       ),