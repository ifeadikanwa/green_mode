import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_mode/core/common_widgets/loading_indicator.dart';
import 'package:green_mode/core/data/carbon_aware_providers.dart';
import 'package:green_mode/green_do/data/activity.dart';
import 'package:green_mode/green_do/ui/helper_widgets/activity_details/activity_details_list_item.dart';

class ActivityDetailsList extends ConsumerWidget {
  final Activity activity;

  const ActivityDetailsList({
    Key? key,
    required this.activity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todaysEmissionAsync = ref.watch(todaysEmissionProvider);

    return todaysEmissionAsync.when(
      data: (todaysEmissionList) => ListView.builder(
        itemCount: todaysEmissionList.length,
        itemBuilder: (context, index) {
          return ActivityDetailsListItem(
            activity: activity,
            emission: todaysEmissionList[index],
          );
        },
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
