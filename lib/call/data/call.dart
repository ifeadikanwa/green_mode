import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_mode/call/data/call_providers.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:uuid/uuid.dart';

class Call {
  static Future<void> joinCall(WidgetRef ref) async {
    try {
      final Map<FeatureFlagEnum, bool> featureFlags = {
        FeatureFlagEnum.CALL_INTEGRATION_ENABLED: false,
        FeatureFlagEnum.MEETING_NAME_ENABLED: false,
      };

      const uuid = Uuid();

      final callOptions =
          JitsiMeetingOptions(room: "green_mode_call_${uuid.v1()}")
            ..subject = "Call"
            ..userDisplayName = ref.read(usernameProvider)
            ..userEmail = ref.watch(userEmailProvider)
            ..audioMuted = ref.watch(startWithAudioProvider)
            ..videoMuted = ref.watch(startWithVideoProvider)
            ..featureFlags.addAll(featureFlags);

      await JitsiMeet.joinMeeting(callOptions);

    } catch (error) {
      debugPrint("Join call error: $error");
    }
  }
}
