import 'package:flutter/material.dart';

import '../../../common/constants/app_color.dart';
import '../../../common/constants/app_icons.dart';
import '../controller/timer_controller.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "POMODORO",
          maxLines: 1,
          overflow: TextOverflow.fade,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: AppColor.mainColor,
          ),
        ),
        SizedBox(
          width: switch (size.width) {
            > 600 => size.width * 0.1,
            < 360 => size.width * 0.1,
            _ => size.width * 0.2,
          },
        ),
        const Center(
          child: SizedBox.square(
            dimension: 46,
            child: RefreshButton(),
          ),
        ),
      ],
    );
  }
}

class RefreshButton extends StatelessWidget {
  const RefreshButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isSettings = Provider.of(context, listen: true).isSettings;
    final onRefreshTapped = Provider.of(context).onRefreshTapped;

    return GestureDetector(
      onTap: isSettings ? null : onRefreshTapped,
      child: const Material(
        color: AppColor.restartIconBGColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: Center(
          child: Image(
            image: AssetImage(AppIcons.refreshIcon),
            height: 22,
            width: 22,
          ),
        ),
      ),
    );
  }
}

