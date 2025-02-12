import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LineChart Value Toggle',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ChartPage(),
    );
  }
}

class ChartPage extends StatefulWidget {
  const ChartPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  bool _showAllValues = false;

  final List<FlSpot> _spots = <FlSpot>[
    const FlSpot(0, 1),
    const FlSpot(1, 3),
    const FlSpot(2, 2),
    const FlSpot(3, 5),
    const FlSpot(4, 3.5),
    const FlSpot(5, 4),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LineChart with Value Toggle'),
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => setState(() => _showAllValues = !_showAllValues),
            child: Text(_showAllValues ? '値を隠す' : '値を表示'),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: LineChart(
                LineChartData(
                  minX: 0,
                  maxX: 5,
                  minY: 0,
                  maxY: 6,
                  titlesData: const FlTitlesData(
                    leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
                    bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
                  ),
                  lineBarsData: <LineChartBarData>[
                    LineChartBarData(
                      spots: _spots,
                      isCurved: true,
                      dotData: FlDotData(
                        getDotPainter: (FlSpot spot, double percent, LineChartBarData barData, int index) =>
                            MyCustomDotPainter(
                          radius: 4,
                          color: Colors.blue,
                          showText: _showAllValues,
                          text: spot.y.toString(),
                        ),
                      ),
                      belowBarData: BarAreaData(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

///
class MyCustomDotPainter extends FlDotPainter {
  MyCustomDotPainter({required this.radius, required this.color, required this.showText, required this.text});

  final double radius;
  final Color color;
  final bool showText;
  final String text;

  ///
  @override
  void draw(Canvas canvas, FlSpot spot, Offset offset) {
    final Paint paint = Paint()..color = color;

    canvas.drawCircle(offset, radius, paint);

    if (showText) {
      final TextSpan textSpan = TextSpan(text: text, style: const TextStyle(fontSize: 12, color: Colors.black));

      final TextPainter textPainter = TextPainter(text: textSpan, textDirection: TextDirection.ltr);

      textPainter.layout();

      final Offset textOffset = Offset(offset.dx - textPainter.width / 2, offset.dy - radius - textPainter.height - 2);

      textPainter.paint(canvas, textOffset);
    }
  }

  ///
  @override
  Size getSize(FlSpot spot) => Size(radius * 2, radius * 2);

  ///
  @override
  Color get mainColor => color;

  ///
  @override
  List<Object?> get props => <Object?>[radius, color, showText, text];

  ///
  @override
  FlDotPainter lerp(FlDotPainter a, FlDotPainter b, double t) {
    if (a is MyCustomDotPainter && b is MyCustomDotPainter) {
      return MyCustomDotPainter(
        radius: lerpDouble(a.radius, b.radius, t) ?? a.radius,
        color: Color.lerp(a.color, b.color, t) ?? a.color,
        showText: t < 0.5 ? a.showText : b.showText,
        text: t < 0.5 ? a.text : b.text,
      );
    }
    return this;
  }
}
