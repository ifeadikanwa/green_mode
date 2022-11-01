import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_mode/core/common_widgets/loading_indicator.dart';
import 'package:green_mode/core/data/carbon_aware_providers.dart';
import 'package:green_mode/core/data/models/emission.dart';

class TestUI extends ConsumerWidget {
  const TestUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<Emission>> todaysEmission =
        ref.watch(todaysEmissionProvider);

    return todaysEmission.when(
      data: (data) => Text(data.toString()),
      error: (error, stackTrace) {
        print(error);
        return Text(error.toString());
      },
      loading: () => const LoadingIndicator(),
    );
  }
}
