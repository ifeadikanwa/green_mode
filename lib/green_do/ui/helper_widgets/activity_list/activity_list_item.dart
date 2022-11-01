import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_mode/core/data/carbon_aware_providers.dart';
import 'package:green_mode/core/routing/app_router.dart';
import 'package:green_mode/green_do/data/activity.dart';
import 'package:green_mode/green_do/data/util/can_perform_activity.dart';

class ActivityListItem extends ConsumerWidget {
  final Activity activity;
  final double currentEmission;

  const ActivityListItem({
    Key? key,
    required this.activity,
    required this.currentEmission,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = ref.watch(locationProvider);

    return ListTile(
      onTap: () => Navigator.push(
        context,
        AppRouter.activityDetailScreen(context, activity),
      ),
      leading: Container(
        width: 25,
        height: 25,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: canPerformActivity(
            location: location,
            emissionValue: currentEmission,
            activityMinQuality: activity.minimumQuality,
          )
              ? Colors.green
              : Colors.red,
        ),
      ),
      title: Text(activity.presentationName),
      trailing: const Icon(Icons.arrow_forward_ios),
    );
  }
}
