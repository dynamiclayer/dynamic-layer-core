import 'package:dynamiclayer_flutter/dynamiclayer_flutter.dart';
import 'package:flutter/material.dart';

import 'screens/button_demo_screen.dart';

void main() {
  runApp(const DynamicLayerExampleApp());
}

class DynamicLayerExampleApp extends StatelessWidget {
  const DynamicLayerExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dynamic Layer Example',
      theme: DlTheme.light(),
      darkTheme: DlTheme.dark(),
      themeMode: ThemeMode.system,
      home: const ButtonDemoScreen(),
    );
  }
}
