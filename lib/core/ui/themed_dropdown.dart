import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:green_mode/core/ui/widget_constants.dart';
import 'package:flutter/material.dart';

class ThemedDropdown<T> extends StatelessWidget {
  final T value;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?)? onChanged;
  const ThemedDropdown({
    Key? key,
    required this.value,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);

    final BorderSide dropDownBorder = BorderSide(
      width: 0.5,
      color: (appTheme.brightness == Brightness.light)
          ? Colors.black.withOpacity(0.5)
          : Colors.white.withOpacity(0.5),
    );

    return DropdownButtonHideUnderline(
      child: DropdownButton2<T>(
        scrollbarAlwaysShow: true,
        isExpanded: true,
        icon: Icon(
          Icons.arrow_drop_down_outlined,
          color: appTheme.colorScheme.secondary,
          size: 30.0,
        ),
        style: WidgetConstants.dropdownDefaultTextStyle.copyWith(
          color: appTheme.colorScheme.secondary,
        ),
        // dropdownMaxHeight: WidgetConstants.dropdownMenuMaxHeight,
        dropdownDecoration: BoxDecoration(
          color: appTheme.scaffoldBackgroundColor,
          border: Border(
            left: dropDownBorder,
            right: dropDownBorder,
            bottom: dropDownBorder,
          ),
        ),
        value: value,
        items: items,
        onChanged: onChanged,
      ),
    );
  }
}
