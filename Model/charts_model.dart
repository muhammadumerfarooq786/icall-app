import 'package:charts_flutter/flutter.dart' as charts;

class ChartModel {
  String year;
  int financial;
  final charts.Color color;

  ChartModel({
    required this.year,
    required this.financial,
    required this.color,
  });
}
