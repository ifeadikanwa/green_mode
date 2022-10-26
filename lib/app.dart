import 'package:green_mode/core/theme/app_theme.dart';
import 'package:green_mode/core/ui/main_menu_screen.dart';
import 'package:green_mode/news/ui/news_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.darkTheme,
      home: const MainMenuScreen(),
    );
  }
}
