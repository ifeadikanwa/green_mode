import 'package:cached_network_image/cached_network_image.dart';
import 'package:green_mode/core/common_widgets/add_horizontal_space.dart';
import 'package:green_mode/core/common_widgets/list_image_loader.dart';
import 'package:green_mode/core/data/carbon_aware_providers.dart';
import 'package:green_mode/core/routing/app_router.dart';
import 'package:green_mode/core/common_widgets/add_vertical_space.dart';
import 'package:green_mode/core/constants/widget_constants.dart';
import 'package:green_mode/news/data/models/news.dart';
import 'package:green_mode/news/data/news_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_mode/news/data/util/news_util.dart';

class NewsListItem extends ConsumerWidget {
  final News news;
  const NewsListItem({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canAutoLoadImages = ref.watch(canAutoLoadImageProvider);

    return GestureDetector(
      //on tap set news url and navigate
      onTap: () {
        ref.read(contentUrlProvider.notifier).state = news.url;

        Navigator.push(
          context,
          AppRouter.newsDetailScreen(context, news),
        );
      },

      //padding surounding the news item column
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 8.0,
        ),
        child: Row(
          children: [
            ListImageLoader(
              imageHeight: 70,
              imageWidth: 70,
              imageUrl: news.urlToImage,
            ),
            const AddHorizontalSpace(width: 8.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    news.title,
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: WidgetConstants.listItemTitleTextStyle,
                  ),
                  const AddVerticalSpace(height: 6.0),
                  Text(
                    NewsUtil.getValidDescription(news.description),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
