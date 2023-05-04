import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';

import 'router.dart';
import 'theme/palette.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox('NOTE_DB');
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      theme: ref.watch(themeNotifierProvider),
      routerConfig: ref.watch(routerProvider),
    );
  }
}
