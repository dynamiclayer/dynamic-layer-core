import 'package:dynamic_layer_core/dynamic_layer_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpSwitch(WidgetTester tester, {ThemeData? theme}) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: theme ?? DlTheme.light(),
        home: const Scaffold(
          body: Center(
            child: DlSwitch(),
          ),
        ),
      ),
    );
  }

  testWidgets('default state has 50x32 grey200 track and left white thumb', (
    tester,
  ) async {
    await pumpSwitch(tester);

    final track = tester.widget<AnimatedContainer>(
      find.byKey(const Key('dl_switch_track')),
    );
    final trackSize = tester.getSize(find.byKey(const Key('dl_switch_track')));
    final thumbSize = tester.getSize(find.byKey(const Key('dl_switch_thumb')));
    final thumbLeft = tester.getTopLeft(find.byKey(const Key('dl_switch_thumb'))).dx;
    final trackLeft = tester.getTopLeft(find.byKey(const Key('dl_switch_track'))).dx;
    final decoration = track.decoration as BoxDecoration;

    expect(trackSize.width, 50);
    expect(trackSize.height, 32);
    expect(decoration.color, DlColorsLight.grey200);
    expect(thumbSize.width, 28);
    expect(thumbSize.height, 28);
    expect(thumbLeft - trackLeft, 2);
  });

  testWidgets('tap toggles to active with black track and right aligned thumb', (
    tester,
  ) async {
    await pumpSwitch(tester);

    await tester.tap(find.byKey(const Key('dl_switch_tap_area')));
    await tester.pumpAndSettle();

    final track = tester.widget<AnimatedContainer>(
      find.byKey(const Key('dl_switch_track')),
    );
    final decoration = track.decoration as BoxDecoration;

    final thumbLeft = tester.getTopLeft(find.byKey(const Key('dl_switch_thumb'))).dx;
    final trackLeft = tester.getTopLeft(find.byKey(const Key('dl_switch_track'))).dx;
    final thumbWidth = tester.getSize(find.byKey(const Key('dl_switch_thumb'))).width;
    final trackWidth = tester.getSize(find.byKey(const Key('dl_switch_track'))).width;
    final rightInset = trackWidth - (thumbLeft - trackLeft) - thumbWidth;

    expect(decoration.color, DlColorsLight.black);
    expect(rightInset, 2);
  });
}
