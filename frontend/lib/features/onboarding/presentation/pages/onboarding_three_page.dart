import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class OnboardingThreePage extends StatefulWidget {
  const OnboardingThreePage({
    super.key,
    this.onAnimationCompleted,
  });

  final VoidCallback? onAnimationCompleted;

  @override
  State<OnboardingThreePage> createState() => _OnboardingThreePageState();
}

class _OnboardingThreePageState extends State<OnboardingThreePage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _heartScale;
  late final Animation<double> _heartVerticalOffset;
  late final Animation<double> _heartOpacity;
  bool _hasTriggeredNavigation = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
    _heartScale = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 0.35, end: 1.25).chain(
          CurveTween(curve: Curves.easeOutBack),
        ),
        weight: 45,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1.25, end: 2.2).chain(
          CurveTween(curve: Curves.easeInCubic),
        ),
        weight: 55,
      ),
    ]).animate(_controller);
    _heartVerticalOffset = Tween<double>(
      begin: 0,
      end: -280,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.42, 1, curve: Curves.easeInOutCubic),
      ),
    );
    _heartOpacity = Tween<double>(
      begin: 1,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.72, 1, curve: Curves.easeOut),
      ),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _finishAnimationAndNavigate();
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _finishAnimationAndNavigate() {
    if (!mounted || _hasTriggeredNavigation) {
      return;
    }
    _hasTriggeredNavigation = true;
    widget.onAnimationCompleted?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.onboardingThreeBackground,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _finishAnimationAndNavigate,
        child: SafeArea(
          child: Center(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _heartVerticalOffset.value),
                  child: Opacity(
                    opacity: _heartOpacity.value,
                    child: Transform.scale(
                      scale: _heartScale.value,
                      child: child,
                    ),
                  ),
                );
              },
              child: const Icon(
                Icons.favorite_rounded,
                color: Colors.white,
                size: 56,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
