import 'package:green_mode/core/ui/loading_indicator.dart';
import 'package:green_mode/core/ui/widget_constants.dart';
import 'package:green_mode/news/data/news_providers.dart';
import 'package:green_mode/news/data/util/news_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewsContent extends ConsumerWidget {
  const NewsContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final content = ref.watch(contentNotifierProvider);

    return content.when(
      data: (contentList) {
        final String content = NewsUtil.prepareContentForDisplay(contentList);
        return Text(
          content,
          style: WidgetConstants.newsContentTextStyle,
        );
      },
      error: (error, stackTrace) => Text(error.toString()),
      loading: () => const LoadingIndicator(),
    );
  }
}
