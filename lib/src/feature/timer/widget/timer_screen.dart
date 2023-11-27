import 'package:flutter/material.dart';

import '../../../common/constants/app_color.dart';
import '../../../common/constants/app_icons.dart';
import '../controller/timer_controller.dart';
import 'custom_appbar.dart';
import 'custom_bottom_appbar.dart';
import 'custom_timer.dart';
import 'section_maker.dart';
import 'setting_page.dart';

class TimerScreen extends StatelessWidget {
  const TimerScreen({super.key});

  @override
  Widget build(BuildContext context) => const Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(child: CustomAppBar()),
              Expanded(flex: 4, child: TimerBody()),
            ],
          ),
        ),
        floatingActionButton: SizedBox.square(
          dimension: 75,
          child: CustomFAB(),
        ),
        floatingActionButtonLocation: CustomFABLocation(),
        bottomNavigationBar: CustomBottomAppBar(),
      );
}

class TimerBody extends StatelessWidget {
  const TimerBody({super.key});

  @override
  Widget build(BuildContext context) {
    final isSettings = Provider.of(context, listen: true).isSettings;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: isSettings
          ? const SettingPage()
          : const Column(
              children: [
                Expanded(child: CustomTimerView()),
                Expanded(child: SectionMaker()),
              ],
            ),
    );
  }
}

class CustomFAB extends StatelessWidget {
  const CustomFAB({super.key});

  @override
  Widget build(BuildContext context) {
    final isTimerStarted = Provider.of(context, listen: true).isTimerStarted;
    final isSettings = Provider.of(context, listen: true).isSettings;
    final fABPressed = Provider.of(context).fABPressed;

    return FloatingActionButton(
      onPressed: isTimerStarted ? null : fABPressed,
      backgroundColor: AppColor.mainColor,
      shape: const CircleBorder(),
      child: Image(
        image: AssetImage(
          isSettings ? AppIcons.tickIcon : AppIcons.playIcon,
        ),
        height: 30,
        width: 30,
      ),
    );
  }
}

class CustomFABLocation extends FloatingActionButtonLocation {
  const CustomFABLocation();

  @override
  Offset getOffset(
    ScaffoldPrelayoutGeometry scaffoldGeometry,
  ) =>
      Offset(
        scaffoldGeometry.scaffoldSize.width - scaffoldGeometry.floatingActionButtonSize.width * 1.7,
        scaffoldGeometry.contentBottom - (scaffoldGeometry.floatingActionButtonSize / 2).height,
      );
}
