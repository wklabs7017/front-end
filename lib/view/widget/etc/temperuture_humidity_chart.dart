import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TemperatureHumidityChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(text: '  '),
      legend: Legend(isVisible: false),
      tooltipBehavior: TooltipBehavior(enable: true),
      primaryXAxis: CategoryAxis(
        majorGridLines: MajorGridLines(width: 0), // X축 그리드 라인 숨기기

        title: AxisTitle(text: 'Time'),
      ),
      primaryYAxis: NumericAxis(
        name: 'TemperatureAxis',
        minimum: 10,
        maximum: 30,
        interval: 5,
        axisLine: AxisLine(width: 0),
        title: AxisTitle(text: 'Temp(°C)'),
      ),
      axes: <ChartAxis>[
        NumericAxis(
          name: 'HumidityAxis',
          opposedPosition: true,
          minimum: 0,
          maximum: 100,
          interval: 10,
          axisLine: AxisLine(width: 0),
          title: AxisTitle(text: 'Humid(%)'),
        ),
      ],
      series: <CartesianSeries>[
        LineSeries<TempHumidData, String>(
          dataSource: getChartData(),
          xValueMapper: (TempHumidData data, _) => data.time,
          yValueMapper: (TempHumidData data, _) => data.temperature,
          name: 'Temperature',
          yAxisName: 'TemperatureAxis',
        ),
        LineSeries<TempHumidData, String>(
          dataSource: getChartData(),
          xValueMapper: (TempHumidData data, _) => data.time,
          yValueMapper: (TempHumidData data, _) => data.humidity,
          name: 'Humidity',
          yAxisName: 'HumidityAxis',
          color: Colors.red,
        ),
      ],
    );
  }

  List<TempHumidData> getChartData() {
    final List<TempHumidData> chartData = [
      TempHumidData(time: '00:00', temperature: 15, humidity: 60),
      TempHumidData(time: '03:00', temperature: 17, humidity: 59),
      TempHumidData(time: '06:00', temperature: 19, humidity: 59),
      TempHumidData(time: '09:00', temperature: 14, humidity: 71),
      TempHumidData(time: '12:00', temperature: 15, humidity: 67),
      TempHumidData(time: '15:00', temperature: 16, humidity: 66),
      TempHumidData(time: '18:00', temperature: 17, humidity: 79),
      TempHumidData(time: '21:00', temperature: 20, humidity: 70),
      TempHumidData(time: '24:00', temperature: 15, humidity: 65),
    ];
    return chartData;
  }
}

class TempHumidData {
  TempHumidData(
      {required this.time, required this.temperature, required this.humidity});
  final String time;
  final double temperature;
  final double humidity;
}
