import 'package:flutter/material.dart';

import '../../../common/constants/app_color.dart';
import '../../../common/constants/app_icons.dart';
import '../controller/timer_controller.dart';
import 'custom_notch.dart';

class CustomBottomAppBar extends StatelessWidget {
  const CustomBottomAppBar({super.key});

  @override
  Widget build(BuildContext context) => const BottomAppBar(
        color: AppColor.mainColor,
        height: 90,
        shape: CustomNotch(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        notchMargin: 20,
        padding: EdgeInsets.only(top: 1),
        child: BottomAppBar(
          color: Colors.white,
          height: 90,
          shape: CustomNotch(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          notchMargin: 20,
          child: Row(
            children: [
              Expanded(flex: 3, child: BottomIcons()),
              Expanded(flex: 2, child: SizedBox.shrink()),
            ],
          ),
        ),
      );
}

class BottomIcons extends StatelessWidget {
  const BottomIcons({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isSettings = Provider.of(context, listen: true).isSettings;
    final isTimerStarted = Provider.of(context, listen: true).isTimerStarted;
    final bottomPressed = Provider.of(context).bottomPressed;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconBuilder(
          icon: isSettings ? AppIcons.homeOutlinedIcon : AppIcons.homeFilledIcon,
          opacityValue: isSettings ? 0.0 : 1.0,
          onPressed: isTimerStarted
              ? null
              : () {
                  if (!isSettings) return;
                  bottomPressed(false);
                },
        ),
        SizedBox(width: size.width > 360 ? 40 : 20),
        IconBuilder(
          icon: isSettings ? AppIcons.settingFilledIcon : AppIcons.settingsOutlinedIcon,
          opacityValue: isSettings ? 1.0 : 0.0,
          onPressed: isTimerStarted
              ? null
              : () {
                  if (isSettings) return;
                  bottomPressed(true);
                },
        ),
      ],
    );
  }
}

class IconBuilder extends StatelessWidget {
  const IconBuilder({
    required this.icon,
    required this.opacityValue,
    required this.onPressed,
    super.key,
  });

  final String icon;
  final double opacityValue;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: onPressed,
            icon: Image(
              image: AssetImage(icon),
              height: 30,
              width: 30,
            ),
          ),
          AnimatedOpacity(
            opacity: opacityValue,
            duration: const Duration(
              milliseconds: 400,
            ),
            child: const DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.mainColor,
              ),
              child: SizedBox(height: 10, width: 10),
            ),
          ),
        ],
      );
}
