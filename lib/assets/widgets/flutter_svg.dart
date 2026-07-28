import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/animation.dart';

class AnimatedSVGContainer extends StatefulWidget {
  const AnimatedSVGContainer({super.key});

  @override
  _AnimatedSVGContainerState createState() => _AnimatedSVGContainerState();
}

class _AnimatedSVGContainerState extends State<AnimatedSVGContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 300,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.rotate(
            angle: _animation.value * 6.28, // Full rotation
            child: SvgPicture.asset(
              'assets/your_animated.svg',
              semanticsLabel: 'Animated SVG',
            ),
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
