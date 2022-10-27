import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_mode/call/data/call.dart';
import 'package:green_mode/call/data/call_providers.dart';
import 'package:green_mode/core/common_widgets/screen_container.dart';

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
    return ScreenContainer(
      child: Column(
        children: [
          TextField(
            
            controller: usernameController,
            onChanged: (value) =>
                ref.read(usernameProvider.notifier).state = value,
          ),
          TextField(
            controller: userEmailController,
            onChanged: (value) =>
                ref.read(userEmailProvider.notifier).state = value,
          ),
          OutlinedButton(
            onPressed: () {
              Call.joinCall(ref);
            },
            child: Text("Join Call"),
          ),
        ],
      ),
    );
  }
}
