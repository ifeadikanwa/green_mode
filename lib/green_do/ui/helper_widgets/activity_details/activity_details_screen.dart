import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_mode/core/common_widgets/inner_screen_app_bar.dart';
import 'package:green_mode/core/common_widgets/screen_container.dart';
import 'package:green_mode/green_do/data/activity.dart';
import 'package:green_mode/green_do/ui/helper_widgets/activity_details/activity_details_list.dart';

class ActivityDetailsScreen extends ConsumerWidget {
  final Activity activity;

  const ActivityDetailsScreen({Key? key, required this.activity})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenContainer(
      child: Column(
        children: [
          //bar
          InnerScreenAppBar(
            title: activity.presentationName,
          ),

          //details
          Expanded(
            child: ActivityDetailsList(
              activity: activity,
            ),
          ),
        ],
      ),
    );
  }
}
