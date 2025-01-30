import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:teste_wk_app/models/IMCFaixaEtaria.dart';

class BarChartSample7 extends StatefulWidget {
  BarChartSample7(List<IMCFaixaEtaria> imcFaixaEtariaList, this.colors,
      {super.key}) {
    faixaEtariaList = this.convertToBarData(imcFaixaEtariaList);
  }

  late List<_BarData> faixaEtariaList;
  final List<Color> colors;
  final Color shadowColor = const Color(0xFFCCCCCC);

  List<_BarData> convertToBarData(List<IMCFaixaEtaria> apiData) {
    return apiData.asMap().entries.map((entry) {
      int index = entry.key;
      IMCFaixaEtaria data = entry.value;

      return _BarData(
        colors[index % colors.length], // Gera uma cor para cada barra
        data.imcMedio,
        data.faixaEtaria,
      );
    }).toList();
  }

  @override
  State<BarChartSample7> createState() => _BarChartSample7State();
}

class _BarChartSample7State extends State<BarChartSample7> {
  BarChartGroupData generateBarGroup(
    int x,
    Color color,
    double value,
    double shadowValue,
  ) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: value,
          color: color,
          width: 6,
        ),
        BarChartRodData(
          toY: shadowValue.toDouble(),
          color: widget.shadowColor,
          width: 6,
        ),
      ],
      showingTooltipIndicators: touchedGroupIndex == x ? [0] : [],
    );
  }

  int touchedGroupIndex = -1;

  int rotationTurns = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.indigo.shade900,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: Container()),
                const Text(
                  'IMC por faixa eteria',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                Expanded(
                    child: Align(
                  alignment: Alignment.centerRight,
                  child: Tooltip(
                    message: 'Rotate the chart 90 degrees (cw)',
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          rotationTurns += 1;
                        });
                      },
                      icon: RotatedBox(
                        quarterTurns: rotationTurns - 1,
                        child: const Icon(
                          Icons.rotate_90_degrees_cw,
                        ),
                      ),
                    ),
                  ),
                )),
              ],
            ),
            const SizedBox(height: 18),
            AspectRatio(
              aspectRatio: 1.2,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  rotationQuarterTurns: rotationTurns,
                  borderData: FlBorderData(
                    show: true,
                    border: const Border.symmetric(
                      horizontal: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    leftTitles: AxisTitles(
                      drawBelowEverything: true,
                      sideTitles: SideTitles(
                        interval: 10,
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return SideTitleWidget(
                            meta: meta,
                            child: Text(
                              meta.formattedValue,
                            ),
                          );
                        },
                        reservedSize: 35,
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 36,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          return SideTitleWidget(
                            meta: meta,
                            child: _IconWidget(
                              color: widget.faixaEtariaList[index].color,
                              isSelected: touchedGroupIndex == index,
                            ),
                          );
                        },
                      ),
                    ),
                    rightTitles: const AxisTitles(),
                    topTitles: const AxisTitles(),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: true,
                    getDrawingHorizontalLine: (value) => FlLine(
                      color: Colors.white,
                      strokeWidth: 1,
                    ),
                  ),
                  barGroups: widget.faixaEtariaList.asMap().entries.map((e) {
                    final index = e.key;
                    final data = e.value;
                    return generateBarGroup(
                      index,
                      data.color,
                      data.imc,
                      data.faixa_etaria.toDouble(),
                    );
                  }).toList(),
                  maxY: 100,
                  barTouchData: BarTouchData(
                    enabled: true,
                    handleBuiltInTouches: false,
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipColor: (group) => Colors.transparent,
                      tooltipMargin: 0,
                      getTooltipItem: (
                        BarChartGroupData group,
                        int groupIndex,
                        BarChartRodData rod,
                        int rodIndex,
                      ) {
                        return BarTooltipItem(
                          rod.toY.toString(),
                          TextStyle(
                            fontWeight: FontWeight.bold,
                            color: rod.color,
                            fontSize: 18,
                            shadows: const [
                              Shadow(
                                color: Colors.black26,
                                blurRadius: 12,
                              )
                            ],
                          ),
                        );
                      },
                    ),
                    touchCallback: (event, response) {
                      if (event.isInterestedForInteractions &&
                          response != null &&
                          response.spot != null) {
                        setState(() {
                          touchedGroupIndex =
                              response.spot!.touchedBarGroupIndex;
                        });
                      } else {
                        setState(() {
                          touchedGroupIndex = -1;
                        });
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BarData {
  const _BarData(this.color, this.imc, this.faixa_etaria);

  final Color color;
  final double imc;
  final int faixa_etaria;
}

class _IconWidget extends ImplicitlyAnimatedWidget {
  const _IconWidget({
    required this.color,
    required this.isSelected,
  }) : super(duration: const Duration(milliseconds: 300));
  final Color color;
  final bool isSelected;

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() =>
      _IconWidgetState();
}

class _IconWidgetState extends AnimatedWidgetBaseState<_IconWidget> {
  Tween<double>? _rotationTween;

  @override
  Widget build(BuildContext context) {
    final rotation = math.pi * 4 * _rotationTween!.evaluate(animation);
    final scale = 1 + _rotationTween!.evaluate(animation) * 0.5;
    return Transform(
      transform: Matrix4.rotationZ(rotation).scaled(scale, scale),
      origin: const Offset(14, 14),
      child: Icon(
        widget.isSelected ? Icons.face_retouching_natural : Icons.face,
        color: widget.color,
        size: 28,
      ),
    );
  }

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _rotationTween = visitor(
      _rotationTween,
      widget.isSelected ? 1.0 : 0.0,
      (dynamic value) => Tween<double>(
        begin: value as double,
        end: widget.isSelected ? 1.0 : 0.0,
      ),
    ) as Tween<double>?;
  }
}
