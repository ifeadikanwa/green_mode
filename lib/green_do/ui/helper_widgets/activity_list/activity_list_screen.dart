import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_mode/core/common_widgets/loading_indicator.dart';
import 'package:green_mode/core/common_widgets/themed_divider.dart';
import 'package:green_mode/core/common_widgets/themed_scrollbar.dart';
import 'package:green_mode/core/data/carbon_aware_providers.dart';
import 'package:green_mode/green_do/data/activity.dart';
import 'package:green_mode/green_do/ui/helper_widgets/activity_list/activity_list_item.dart';

class ActivityListScreen extends ConsumerWidget {
  const ActivityListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currEmissionProvider = ref.watch(currentEmissionProvider);

    return currEmissionProvider.when(
      data: (currentEmission) => Expanded(
        child: ListView.separated(
          itemCount: Activity.values.length,
          itemBuilder: (context, index) {
            return ActivityListItem(
              activity: Activity.values[index],
              currentEmission: currentEmission.rating,
            );
          },
          separatorBuilder: (context, index) => const ThemedDivider(),
        ),
      ),
      error: (error, stackTrace) => Text(error.toString()),
      loading: () => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          LoadingIndicator(),
        ],
      ),
    );
  }
}
