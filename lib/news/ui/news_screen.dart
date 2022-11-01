import 'package:green_mode/core/common_widgets/add_horizontal_space.dart';
import 'package:green_mode/core/common_widgets/screen_container.dart';
import 'package:green_mode/core/common_widgets/sub_app_bar.dart';
import 'package:green_mode/core/common_widgets/themed_divider.dart';
import 'package:green_mode/core/common_widgets/themed_dropdown.dart';
import 'package:green_mode/core/constants/text_constants.dart';
import 'package:green_mode/core/constants/widget_constants.dart';
import 'package:green_mode/news/data/constants/news_category.dart';
import 'package:green_mode/news/data/news_providers.dart';
import 'package:green_mode/news/ui/news_list/news_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewsScreen extends ConsumerWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedNewsCategory = ref.watch(newsCategoryProvider);
    return ScreenContainer(
      child: Column(
        children: [
          const SubAppBar(title: TextConstants.news),
          categoryRow(ref, selectedNewsCategory),
          const ThemedDivider(),
          const NewsListScreen(),
        ],
      ),
    );
  }

  Row categoryRow(
    WidgetRef ref,
    NewsCategory selectedNewsCategory,
  ) {
    return Row(
      children: [
        const Text(
          "Category:",
          style: WidgetConstants.subHeadingTextStyle,
        ),
        const AddHorizontalSpace(width: 12),
        Expanded(child: categoryDropdown(ref, selectedNewsCategory)),
      ],
    );
  }

  ThemedDropdown categoryDropdown(
    WidgetRef ref,
    NewsCategory selectedNewsCategory,
  ) {
    return ThemedDropdown<NewsCategory>(
      value: selectedNewsCategory,
      items: NewsCategory.values
          .map(
            (newsCategory) => DropdownMenuItem<NewsCategory>(
              value: newsCategory,
              child: Text(newsCategory.presentationName),
            ),
          )
          .toList(),
      onChanged: (value) =>
          ref.read(newsCategoryProvider.notifier).state = value!,
    );
  }
}
