import 'package:flutter/material.dart';
import 'package:green_mode/core/common_widgets/screen_container.dart';
import 'package:green_mode/core/common_widgets/sub_app_bar.dart';
import 'package:green_mode/core/constants/text_constants.dart';
import 'package:green_mode/green_do/ui/helper_widgets/activity_list/activity_list_screen.dart';
import 'package:green_mode/green_do/ui/helper_widgets/activity_search_delegate.dart';

class GreenDoScreen extends StatefulWidget {
  const GreenDoScreen({Key? key}) : super(key: key);

  @override
  State<GreenDoScreen> createState() => _GreenDoScreenState();
}

class _GreenDoScreenState extends State<GreenDoScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenContainer(
        child: Column(
      children: [
        //top bar
        const SubAppBar(title: TextConstants.greenDo),

        //search bar
        TextField(
          readOnly: true,
          onTap: () => showSearch(
            context: context,
            delegate: ActivitySearchDelegate(),
          ),
          decoration: InputDecoration(
            hintText: "Find an activity",
            prefixIcon: Icon(
              Icons.search,
              color: Colors.white.withOpacity(0.5),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white.withOpacity(0.5),
              ),
            ),
          ),
        ),

        //activities
        const ActivityListScreen(),
      ],
    ));
  }
}
