import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_mode/core/common_widgets/add_horizontal_space.dart';
import 'package:green_mode/core/data/carbon_aware_providers.dart';
import 'package:green_mode/core/data/models/emission.dart';
import 'package:green_mode/core/data/util/time_util.dart';
import 'package:green_mode/green_do/data/activity.dart';
import 'package:green_mode/green_do/data/util/can_perform_activity.dart';
import 'package:green_mode/core/data/util/date_time_extension.dart';

class ActivityDetailsListItem extends ConsumerWidget {
  final Activity activity;
  final Emission emission;
  const ActivityDetailsListItem({
    Key? key,
    required this.activity,
    required this.emission,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = ref.watch(locationProvider);

    final currentTime = TimeUtil.getCurrentUTCTime().toLocal();

    final appTheme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: (emission.time.minute == 0)
              ? Text(
                  "${TimeUtil.padTime(emission.time.hour)}:${TimeUtil.padTime(emission.time.minute)}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: (currentTime.hour == emission.time.hour)
                        ? appTheme.colorScheme.secondary
                        : null,
                  ),
                )
              : Text(
                  TimeUtil.padTime(emission.time.minute).padLeft(5, " "),
                  style: TextStyle(
                    color: (currentTime.minute == emission.time.minute &&
                            currentTime.hour == emission.time.hour)
                        ? appTheme.colorScheme.secondary
                        : null,
                  ),
                ),
        ),
        Expanded(
          flex: 6,
          child: Container(
            height: 30,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.white.withOpacity(
                    0.5,
                  ),
                ),
              ),
            ),
            child: Container(
              height: 50,
              margin: const EdgeInsets.only(left: 8.0),
              decoration: BoxDecoration(
                color: (canPerformActivity(
                  location: location,
                  emissionValue: emission.rating,
                  activityMinQuality: activity.minimumQuality,
                ))
                    ? Colors.green
                    : Colors.red,
              ),
            ),
          ),
        )
      ],
    );
  }
}
