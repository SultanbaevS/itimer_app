import 'dart:async';

import 'package:flutter/material.dart';

import '../../feature/timer/controller/timer_controller.dart';
import '../../feature/timer/widget/timer_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Timer App G7",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: "Poppins",
      ),
      home: const AppTimer(),
    );
  }
}

class AppTimer extends StatefulWidget {
  const AppTimer({super.key});

  @override
  State<AppTimer> createState() => _AppTimerState();
}

class _AppTimerState extends State<AppTimer> {
  late MainController controller;
  late PageController pageController;
  Timer? _timer;
  Timer? _minuteAddTimer;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    controller = MainController(
      timer: _timer,
      minuteAddTimer: _minuteAddTimer,
      timerPageController: pageController,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    pageController.dispose();
    _timer?.cancel();
    _minuteAddTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      controller: controller,
      child: const TimerScreen(),
    );
  }
}

