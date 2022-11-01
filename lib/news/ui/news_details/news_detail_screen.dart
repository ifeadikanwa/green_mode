import 'package:green_mode/core/common_widgets/add_vertical_space.dart';
import 'package:green_mode/core/common_widgets/inner_screen_app_bar.dart';
import 'package:green_mode/core/common_widgets/screen_container.dart';
import 'package:green_mode/core/common_widgets/themed_divider.dart';
import 'package:green_mode/core/common_widgets/themed_expansion_tile.dart';
import 'package:green_mode/core/common_widgets/themed_scrollbar.dart';
import 'package:green_mode/core/constants/widget_constants.dart';
import 'package:green_mode/news/data/models/news.dart';
import 'package:green_mode/news/data/util/news_util.dart';
import 'package:green_mode/news/ui/news_details/helper_widgets/news_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewsDetailScreen extends ConsumerWidget {
  final News news;
  const NewsDetailScreen({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appTheme = Theme.of(context);

    return ScreenContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //bar
          const InnerScreenAppBar(),

          //scrollable news details
          Expanded(
            child: ThemedScrollbar(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      news.title,
                      style: WidgetConstants.subHeadingTextStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        color: appTheme.colorScheme.secondary,
                      ),
                    ),
                    const AddVerticalSpace(height: 8.0),
                    Text(
                      NewsUtil.getPublishTimeAndAuthorString(
                        publishTime: news.publishedAt,
                        author: news.author,
                      ),
                    ),
                    const AddVerticalSpace(height: 8.0),

                    //image expansion tile
                    (news.urlToImage != null)
                        ? ThemedExpansionTile(
                            tileTitle: "View image",
                            imageUrl: news.urlToImage!,
                          )
                        : const SizedBox(),
                    const AddVerticalSpace(height: 8.0),

                    //news text
                    const NewsContent(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
