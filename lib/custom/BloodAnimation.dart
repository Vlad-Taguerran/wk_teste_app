import 'package:flutter/material.dart';
import 'package:teste_wk_app/custom/BloodFillPainter.dart';
import 'package:teste_wk_app/services/web/api.services.dart' as api;

class BloodAnimation extends StatefulWidget {
  @override
  _BloodAnimationState createState() => _BloodAnimationState();
}

class _BloodAnimationState extends State<BloodAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  String total = "";
  @override
  void initState() {
    super.initState();
    this.getTotal();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  getTotal() async {
    String _total = await api.getTotalCandidatos();
    setState(() {
      total = _total;
    });
  }

  @override
  Widget build(BuildContext context) {
    double circleSize = MediaQuery.of(context).size.width * 0.40;
    return Center(
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return CustomPaint(
            painter: BloodFillPainter(_animation.value, total),
            size: Size(circleSize, circleSize),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
