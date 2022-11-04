import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_mode/core/common_widgets/themed_expansion_tile.dart';
import 'package:green_mode/core/data/carbon_aware_providers.dart';

class ContentImageLoader extends ConsumerWidget {
  final double? imageHeight;
  final double? imageWidth;
  final String? imageUrl;

  const ContentImageLoader({
    Key? key,
    this.imageHeight,
    this.imageWidth,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canAutoLoadImage = ref.watch(canAutoLoadImageProvider);
    
    return canAutoLoadImage.when(
      data: (canAutoLoad) {
        if (canAutoLoad) {
          return (imageUrl != null)
              ? CachedNetworkImage(
                  imageUrl: imageUrl!,
                  width: imageWidth,
                  height: imageHeight,
                )
              : const SizedBox();
        } else {
          return (imageUrl != null)
              ? ThemedExpansionTile(
                  tileTitle: "View image",
                  imageUrl: imageUrl!,
                )
              : const SizedBox();
        }
      },
      error: (error, stackTrace) => const SizedBox(),
      loading: () => const SizedBox(),
    );
  }
}
