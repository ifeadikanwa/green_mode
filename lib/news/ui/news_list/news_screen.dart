import 'package:green_mode/core/ui/add_horizontal_space.dart';
import 'package:green_mode/core/ui/screen_container.dart';
import 'package:green_mode/core/ui/themed_divider.dart';
import 'package:green_mode/core/ui/themed_dropdown.dart';
import 'package:green_mode/core/ui/widget_constants.dart';
import 'package:green_mode/news/data/constants/news_category.dart';
import 'package:green_mode/news/data/news_providers.dart';
import 'package:green_mode/news/ui/news_list/helper_widgets/news_list_screen.dart';
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
          headingRow(),
          const ThemedDivider(),
          categoryRow(ref, selectedNewsCategory),
          const ThemedDivider(),
          const NewsListScreen(),
        ],
      ),
    );
  }

  Row headingRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "NEWS",
          style: WidgetConstants.headingTextStyle,
        ),
        IconButton(
          icon: const Icon(Icons.menu_outlined),
          onPressed: () {},
        ),
      ],
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
