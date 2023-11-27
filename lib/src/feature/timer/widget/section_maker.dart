import 'package:flutter/material.dart';

import '../../../common/constants/app_color.dart';
import '../controller/timer_controller.dart';
import '../models/timer_data.dart';

class SectionMaker extends StatelessWidget {
  const SectionMaker({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final data = Provider.of(context).data;
    final pageCount = Provider.of(context, listen: true).pageCount;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: size.height * 0.1),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: data
              .map(
                (e) => _Buttons(item: e, page: pageCount),
              )
              .toList(),
        ),
        Center(
          child: SizedBox(
            width: size.width > 360 ? 250 : 215,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
              child: SizedBox(
                height: 6,
                width: double.infinity,
                child: ColoredBox(
                  color: AppColor.restartIconBGColor,
                  child: AnimatedAlign(
                    alignment: switch (pageCount) {
                      1 => Alignment.center,
                      2 => Alignment.centerRight,
                      _ => Alignment.centerLeft,
                    },
                    duration: const Duration(milliseconds: 200),
                    child: const ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      child: SizedBox(
                        height: 6,
                        width: 55,
                        child: ColoredBox(
                          color: AppColor.mainColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Buttons extends StatelessWidget {
  const _Buttons({
    required this.page,
    required this.item,
  });

  final int page;
  final TimerData item;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final onSectionChanged = Provider.of(context).onSectionChanged;
    final isTimerStarted = Provider.of(context, listen: true).isTimerStarted;

    return TextButton(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all<Color>(
          AppColor.transparent,
        ),
      ),
      onPressed: isTimerStarted ? null : () => onSectionChanged(page, item.id),
      child: (page == item.id)
          ? Text(
              item.sectionName,
              style: TextStyle(
                color: AppColor.mainColor,
                fontSize: size.width > 360 ? 20 : 14,
              ),
            )
          : Text(
              item.sectionName,
              style: TextStyle(
                fontSize: size.width > 360 ? 14 : 10,
              ),
            ),
    );
  }
}
