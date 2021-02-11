import 'package:flutter/material.dart';
import 'dart:math';
import 'package:charts_flutter/flutter.dart' as charts;

class ChartsDemo extends StatefulWidget {
  static const routeName = '/bar-screen';

  ChartsDemo() : super();

  final String title = "Prediction Chart";
  @override
  ChartsDemoState createState() => ChartsDemoState();
}

class ChartsDemoState extends State<ChartsDemo> {
  //
  List<charts.Series> seriesList;

  static List<charts.Series<PredictData, String>> _createRandomData() {
    final random = Random();

    final desktopSalesData = [
      PredictData(' Apple Apple Scab', random.nextDouble()),
      PredictData('Apple Healthy', random.nextDouble()),
      PredictData('Corn (maize)', random.nextDouble()),
      PredictData('Northern Leaf Blight', random.nextDouble()),
      PredictData('Corn (maize) Healthy', random.nextDouble()),
      PredictData('Potato Early Blight', random.nextDouble()),
      PredictData('Potato Healthy', random.nextDouble()),
      PredictData('Tomato Bacterial Spot', random.nextDouble()),
      PredictData('Tomato Healthy', random.nextDouble()),
    ];

    return [
      charts.Series<PredictData, String>(
        id: 'Predict',
        domainFn: (PredictData data, _) => data.leafType,
        measureFn: (PredictData data, _) => data.predictValue,
        data: desktopSalesData,
        fillColorFn: (PredictData datas, _) {
          return (datas.predictValue == 80)
              ? charts.MaterialPalette.green.shadeDefault
              : charts.MaterialPalette.red.shadeDefault;
        },
      ),
    ];
  }

  barChart() {
    return charts.BarChart(
      seriesList,
      animate: true,
      vertical: false,
    );
  }

  @override
  void initState() {
    super.initState();
    seriesList = _createRandomData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
