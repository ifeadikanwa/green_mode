import 'package:flutter/material.dart';
import 'package:green_mode/core/common_widgets/themed_divider.dart';
import 'package:green_mode/core/constants/widget_constants.dart';

class InnerScreenAppBar extends StatelessWidget {
  final String? title;
  const InnerScreenAppBar({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_outlined),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Text(
              title ?? "",
              style: WidgetConstants.subHeadingTextStyle.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const ThemedDivider(),
      ],
    );
  }
}
