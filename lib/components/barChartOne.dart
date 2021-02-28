import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ChartsDemo extends StatefulWidget {
  static const routeName = '/bar-screen';

  ChartsDemo() : super();

  final String title = "Prediction Chart";
  @override
  ChartsDemoState createState() => ChartsDemoState();
}

class ChartsDemoState extends State<ChartsDemo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context).settings.arguments as Map;
    final detectionScores = routeArgs['detection_scores'];

    List<charts.Series> seriesList;

    List<charts.Series<PredictData, String>> data() {
      List<PredictData> desktopSalesData = [];

      for (var i = 0; i < detectionScores.length; i++) {
        desktopSalesData.add(PredictData('Spot ${i + 1}', detectionScores[i]));
      }

      return [
        charts.Series<PredictData, String>(
          id: 'Predict',
          domainFn: (PredictData data, _) => data.leafType,
          measureFn: (PredictData data, _) => data.predictValue,
          data: desktopSalesData,
          fillColorFn: (PredictData datas, _) {
            return (datas.predictValue > 90)
                ? charts.MaterialPalette.red.shadeDefault
                : charts.MaterialPalette.green.shadeDefault;
          },
        ),
      ];
    }

    barChart() {
      seriesList = data();

      return charts.BarChart(
        seriesList,
        animate: true,
        vertical: false,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        toolbarHeight: 75,
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: barChart(),
      ),
    );
  }
}

class PredictData {
  final String leafType;
  final double predictValue;
  PredictData(this.leafType, this.predictValue);
}
