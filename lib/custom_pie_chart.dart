import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class CustomPieChart extends StatefulWidget {
  const CustomPieChart({
    super.key,
    required this.data,
    this.chartTitle,
    this.startDegreeOffset = 250,
    this.sectionsSpace = 0,
    this.centerSpaceRadius = 100,
    this.barRadius = 25,
    this.showTitle = false,
    this.chartTitleSize = 20,
  });

  final List<dynamic> data;
  final String? chartTitle;
  final double startDegreeOffset;
  final double sectionsSpace;
  final double centerSpaceRadius;
  final double barRadius;
  final double chartTitleSize;
  final bool showTitle;

  @override
  State<CustomPieChart> createState() => _CustomPieChartState();
}

class _CustomPieChartState extends State<CustomPieChart> {
  int _total = 0;

  @override
  Widget build(BuildContext context) {
    for (var entry in widget.data) {
      int value = entry[entry.keys.first];
      _total += value;
    }

    return SizedBox(
      height: 250,
      child: Stack(
        children: [
          PieChart(
            PieChartData(
              startDegreeOffset: widget.startDegreeOffset,
              sectionsSpace: widget.sectionsSpace,
              centerSpaceRadius: widget.centerSpaceRadius,
              sections: [
                for (var i = 0; i < widget.data.length; i++)
                  PieChartSectionData(
                    value:
                        (widget.data[i][widget.data[i].keys.first] / _total) *
                            100,
                    color: Color.fromRGBO(
                      (255 - (255 / widget.data.length) * i)
                          .toInt(), // Red component adjusted by index
                      ((255 / widget.data.length) * i)
                          .toInt(), // Green component adjusted by index
                      ((255 / widget.data.length) * (i + 1))
                          .toInt(), // Blue component adjusted by index
                      1,
                    ),
                    radius: widget.barRadius,
                    showTitle: widget.showTitle,
                    title: widget.showTitle
                        ? widget.data[i].keys.first.toString()
                        : '',
                  ),
              ],
            ),
          ),
          if (widget.chartTitle != null)
            Positioned.fill(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 160,
                    width: 160,
                    child: Center(
                      child: Text(
                        widget.chartTitle!,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: widget.chartTitleSize),
                      ),
                    ),
                  )
                ],
              ),
            )
        ],
      ),
    );
  }
}

class Legend extends StatelessWidget {
  const Legend({
    super.key,
    required this.data,
    this.legendTitle = "Legend",
    this.legendBoxRadius = 16,
    this.legendBoxColor = const Color.fromARGB(75, 200, 200, 201),
    this.width,
    this.height,
    this.colorRadius,
  });

  final List<dynamic> data;
  final String legendTitle;
  final double legendBoxRadius;
  final Color legendBoxColor;
  final double? width;
  final double? height;
  final double? colorRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(legendBoxRadius),
        color: legendBoxColor,
      ),
      child: Column(
        children: [
          Text(
            legendTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Theme.of(context).colorScheme.primary),
          ),
          const SizedBox(height: 8), // Add spacing below the text
          for (var i = 0; i < data.length; i += 2)
            Container(
              width: (MediaQuery.of(context).size.width - 48) /
                  2, // Half the screen minus spacing
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LegendItem(
                    color: Color.fromRGBO(
                      (255 - (255 / data.length) * i).toInt(), // Red component
                      ((255 / data.length) * i).toInt(), // Green component
                      ((255 / data.length) * (i + 1)).toInt(), // Blue component
                      1,
                    ),
                    label: data[i].keys.first.toString(),
                    width: width == null ? 16 : width!,
                    height: height == null ? 16 : height!,
                    colorRadius: colorRadius == null ? 0 : colorRadius!,
                  ),
                  if (i + 1 != data.length)
                    LegendItem(
                      color: Color.fromRGBO(
                        (255 - (255 / data.length) * (i + 1))
                            .toInt(), // Red component
                        ((255 / data.length) * (i + 1))
                            .toInt(), // Green component
                        ((255 / data.length) * (i + 2))
                            .toInt(), // Blue component
                        1,
                      ),
                      label: data[i + 1].keys.first.toString(),
                      width: width == null ? 16 : width!,
                      height: height == null ? 16 : height!,
                      colorRadius: colorRadius == null ? 0 : colorRadius!,
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class LegendItem extends StatelessWidget {
  const LegendItem({
    super.key,
    required this.color,
    required this.label,
    this.width = 16,
    this.height = 16,
    this.colorRadius = 0,
  });
  final Color color;
  final String label;
  final double width;
  final double height;
  final double colorRadius;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            width: 16.0,
            height: 16.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(colorRadius),
              color: color,
            ),
            margin: const EdgeInsets.only(right: 8.0)),
        Text(label),
      ],
    );
  }
}
