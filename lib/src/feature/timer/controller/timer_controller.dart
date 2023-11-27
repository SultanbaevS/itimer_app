import 'dart:async';

import 'package:flutter/material.dart';

import '../models/timer_data.dart';

class MainController with ChangeNotifier {
  MainController({
    required this.timerPageController,
    required this.minuteAddTimer,
    required this.timer,
  });

  double indicatorValue = 1.0;
  int pageCount = 0;
  bool isSettings = false;
  bool isTimerStarted = false;

  PageController timerPageController;

  Timer? timer;
  Timer? minuteAddTimer;

  List<TimerData> data = [
    const TimerData(
      id: 0,
      constTime: 60000,
      sectionName: "short break",
      selectedTime: 60000,
    ),
    const TimerData(
      id: 1,
      constTime: 1500000,
      sectionName: "pomodoro",
      selectedTime: 1500000,
    ),
    const TimerData(
      id: 2,
      constTime: 2400000,
      sectionName: "long break",
      selectedTime: 2400000,
    ),
  ];

  void fABPressed() async {
    if (isSettings) {
      for (int i = 0; i < data.length; i++) {
        data[i] = data[i].copyWith(constTime: data[i].selectedTime);
      }

      isSettings = false;

      notifyListeners();

      await Future.delayed(const Duration(milliseconds: 50), () {
        timerPageController.jumpToPage(pageCount);
      });
    } else {
      for (int i = 0; i < data.length; i++) {
        data[i] = data[i].copyWith(selectedTime: data[i].constTime);
      }

      isTimerStarted = true;

      notifyListeners();

      timer = Timer.periodic(const Duration(milliseconds: 20), (t) {
        if (indicatorValue == 0.0) {
          onRefreshTapped();
          return;
        }

        data[pageCount] = data[pageCount].copyWith(selectedTime: data[pageCount].selectedTime - 20);
        int timerTime = data[pageCount].selectedTime;
        indicatorValue = timerTime / data[pageCount].constTime;

        notifyListeners();
      });
    }
  }

  void bottomPressed(bool isSettingsTapped) async {
    isSettings = isSettingsTapped;

    for (int i = 0; i < data.length; i++) {
      data[i] = data[i].copyWith(selectedTime: data[i].constTime);
    }

    notifyListeners();

    if (!isSettings) {
      await Future.delayed(const Duration(milliseconds: 50), () {
        timerPageController.jumpToPage(pageCount);
      });
    }
  }

  void onRefreshTapped() {
    timer?.cancel();

    data[pageCount] =  data[pageCount].copyWith(selectedTime: data[pageCount].constTime);
    indicatorValue = 1.0;
    isTimerStarted = false;

    notifyListeners();
  }

  void onSettingsClosed() async {
    isSettings = false;

    for (int i = 0; i < data.length; i++) {
      data[i] = data[i].copyWith(selectedTime: data[i].constTime);
    }

    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 50), () {
      timerPageController.jumpToPage(pageCount);
    });
  }

  void onSectionChanged(int value, int itemLocation) {
    if (value == itemLocation) {
      return;
    } else {
      pageCount = itemLocation;
      timerPageController.animateToPage(
        itemLocation,
        duration: const Duration(milliseconds: 200),
        curve: Curves.linear,
      );

      notifyListeners();
    }
  }

  void onTapDownDecrement(int itemId) {
    if (data[itemId].selectedTime > 60000) {
      data[itemId] = data[itemId].copyWith(selectedTime: data[itemId].selectedTime - 60000);
      notifyListeners();
    }

    minuteAddTimer = Timer.periodic(
      const Duration(milliseconds: 200),
      (t) {
        if (data[itemId].selectedTime > 60000) {
          data[itemId] = data[itemId].copyWith(selectedTime: data[itemId].selectedTime - 60000);
          notifyListeners();
        }
      },
    );
  }

  void onTapDownIncrement(int itemId) {
    if (data[itemId].selectedTime < 3600000) {
      data[itemId] = data[itemId].copyWith(selectedTime: data[itemId].selectedTime + 60000);
      notifyListeners();
    }

    minuteAddTimer = Timer.periodic(
      const Duration(milliseconds: 200),
      (t) {
        if (data[itemId].selectedTime < 3600000) {
          data[itemId] = data[itemId].copyWith(selectedTime: data[itemId].selectedTime + 60000);
          notifyListeners();
        }
      },
    );
  }
}

class Provider extends InheritedNotifier<MainController> {
  const Provider({
    required super.child,
    required final MainController controller,
    super.key,
  }) : super(notifier: controller);

  static MainController of(BuildContext context, {bool listen = false}) =>
      maybeOf(context, listen: listen)?.notifier ?? _noInheritedWidgetError();

  static Provider? maybeOf(BuildContext context, {bool listen = false}) => listen
      ? context.dependOnInheritedWidgetOfExactType<Provider>()
      : context.getElementForInheritedWidgetOfExactType<Provider>()?.widget as Provider?;

  static Never _noInheritedWidgetError() => throw ArgumentError(
        'Not found InheritedWidget of type Provider',
        'out_of_scope',
      );
}
