import 'package:flutter/material.dart';

import '../../../common/constants/app_color.dart';
import '../controller/timer_controller.dart';
import '../models/timer_data.dart';
import 'custom_indicator.dart';

class CustomTimerView extends StatelessWidget {
  const CustomTimerView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final data = Provider.of(context, listen: true).data;
    final timerPageController = Provider.of(context).timerPageController;

    return Center(
      child: PageView(
        restorationId: 'timer_view_restoration_id',
        controller: timerPageController,
        physics: const NeverScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        children: data
            .map<Widget>(
              (e) => Align(
                alignment: Alignment.center,
                child: SizedBox.square(
                  dimension: size.height * 0.33,
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                      color: AppColor.mainColor,
                      shape: BoxShape.circle,
                    ),
                    child: SizedBox.square(
                      dimension: 250,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: IndicatorView(item: e),
                      ),
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class IndicatorView extends StatelessWidget {
  const IndicatorView({
    required this.item,
    super.key,
  });

  final TimerData item;

  @override
  Widget build(BuildContext context) {
    final indicatorValue = Provider.of(context, listen: true).indicatorValue;

    return CustomIndicator(
      value: indicatorValue,
      width: 10,
      child: Center(
        child: Text(
          "${((item.selectedTime / 1000).ceil() ~/ 60).toString().padLeft(2, "0")}"
          ":"
          "${((item.selectedTime / 1000).ceil() % 60).toString().padLeft(2, "0")}",
          style: const TextStyle(
            color: AppColor.white,
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}
