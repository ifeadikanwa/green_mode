import 'package:cached_network_image/cached_network_image.dart';
import 'package:green_mode/core/ui/loading_indicator.dart';
import 'package:green_mode/core/ui/widget_constants.dart';
import 'package:flutter/material.dart';

class ThemedExpansionTile extends StatelessWidget {
  final String tileTitle;
  final String imageUrl;

  const ThemedExpansionTile(
      {Key? key, required this.tileTitle, required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);

    return Theme(
      data: appTheme.copyWith(
        dividerColor: appTheme.colorScheme.secondary.withOpacity(0.2),
      ),
      child: ExpansionTile(
        controlAffinity: ListTileControlAffinity.leading,
        title: Text(
          tileTitle,
          style: WidgetConstants.newsContentTextStyle,
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CachedNetworkImage(
              fit: BoxFit.contain,
              imageUrl: imageUrl,
              placeholder: (context, url) => const LoadingIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}
