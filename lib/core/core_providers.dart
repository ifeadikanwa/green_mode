import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:green_mode/core/constants/sub_app.dart';

final currentSubAppLocationProvider =
    StateProvider<SubApp>((ref) => SubApp.mainMenu);
