import 'package:dynamic_layer_core/dynamic_layer_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpSlider(
    WidgetTester tester, {
    required Widget child,
    ThemeData? theme,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: theme ?? DlTheme.light(),
        home: Scaffold(body: Center(child: child)),
      ),
    );
  }

  testWidgets('renders full width slider with 4px track theme', (tester) async {
    await pumpSlider(
      tester,
      child: const SizedBox(width: 300, child: DlSlider()),
    );

    final sliderTheme = tester.widget<SliderTheme>(find.byType(SliderTheme));
    expect(sliderTheme.data.trackHeight, 4);
    expect(sliderTheme.data.activeTrackColor, DlColorsLight.black);
    expect(sliderTheme.data.inactiveTrackColor, DlColorsLight.grey200);
  });

  testWidgets('thumb shape is 24x24 with custom border', (tester) async {
    await pumpSlider(
      tester,
      child: const DlSlider(),
    );

    final sliderTheme = tester.widget<SliderTheme>(find.byType(SliderTheme));
    final thumbShape = sliderTheme.data.thumbShape!;
    expect(thumbShape.getPreferredSize(true, false), const Size(24, 24));
  });

  testWidgets('dragging slider updates value and calls onChanged', (tester) async {
    double? latestValue;
    await pumpSlider(
      tester,
      child: DlSlider(
        initialValue: 0,
        onChanged: (value) => latestValue = value,
      ),
    );

    final slider = find.byKey(const Key('dl_slider_control'));
    await tester.drag(slider, const Offset(120, 0));
    await tester.pumpAndSettle();

    expect(latestValue, isNotNull);
    expect(latestValue, greaterThan(0));
  });
}
