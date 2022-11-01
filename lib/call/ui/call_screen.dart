import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_mode/call/data/call.dart';
import 'package:green_mode/call/data/call_providers.dart';
import 'package:green_mode/core/common_widgets/add_horizontal_space.dart';
import 'package:green_mode/core/common_widgets/add_vertical_space.dart';
import 'package:green_mode/core/common_widgets/screen_container.dart';
import 'package:green_mode/core/common_widgets/sub_app_bar.dart';
import 'package:green_mode/core/common_widgets/themed_divider.dart';
import 'package:green_mode/core/constants/text_constants.dart';
import 'package:green_mode/core/constants/widget_constants.dart';

class CallScreen extends ConsumerStatefulWidget {
  const CallScreen({Key? key}) : super(key: key);

  @override
  CallScreenState createState() => CallScreenState();
}

class CallScreenState extends ConsumerState<CallScreen> {
  late TextEditingController usernameController;
  late TextEditingController userEmailController;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController(
      text: ref.read(usernameProvider),
    );
    userEmailController = TextEditingController(
      text: ref.read(userEmailProvider),
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final callResolution = ref.watch(callResolutionProvider);

    return ScreenContainer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            //top bar
            const SubAppBar(title: TextConstants.call),
            const AddVerticalSpace(height: 8.0),

            //image
            Image.asset("assets/images/connect.png"),
            const AddVerticalSpace(
              height: WidgetConstants.defaultVerticalWidgetSpacing,
            ),

            //call quality indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: callResolution.presentationColor,
                  ),
                ),
                const AddHorizontalSpace(width: 8.0),
                Text(callResolution.presentationName),
              ],
            ),
            const AddVerticalSpace(
              height: WidgetConstants.defaultVerticalWidgetSpacing,
            ),

            //text fields
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter your name",
              ),
              onChanged: (value) =>
                  ref.read(usernameProvider.notifier).state = value,
            ),
            const AddVerticalSpace(
                height: WidgetConstants.defaultVerticalWidgetSpacing),
            TextField(
              controller: userEmailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter your email",
              ),
              onChanged: (value) =>
                  ref.read(userEmailProvider.notifier).state = value,
            ),
            const AddVerticalSpace(
                height: WidgetConstants.defaultVerticalWidgetSpacing),

            //call to action
            ElevatedButton(
              onPressed: () async{
                await Call.joinCall(ref);
              },
              child: const Text("START CALL"),
            ),
          ],
        ),
      ),
    );
  }
}
