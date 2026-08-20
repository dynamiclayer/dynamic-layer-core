import 'package:dynamic_layer_core/dynamic_layer_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpLoadingDots(
    WidgetTester tester, {
    required DlLoadingDots loadingDots,
    ThemeData? theme,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: theme ?? DlTheme.light(),
        home: Scaffold(body: Center(child: loadingDots)),
      ),
    );
  }

  AnimatedAlign alignFor(WidgetTester tester, int index) {
    return tester.widget<AnimatedAlign>(
      find.byKey(Key('dl_loading_dot_align_$index')),
    );
  }

  testWidgets('renders 48x16 container and three 10x10 black dots', (
    tester,
  ) async {
    await pumpLoadingDots(tester, loadingDots: const DlLoadingDots());

    expect(
      tester.getSize(find.byKey(const Key('dl_loading_dots'))),
      const Size(48, 16),
    );
    expect(
      tester.getSize(find.byKey(const Key('dl_loading_dot_0'))),
      const Size(10, 10),
    );
    expect(
      tester.getSize(find.byKey(const Key('dl_loading_dot_1'))),
      const Size(10, 10),
    );
    expect(
      tester.getSize(find.byKey(const Key('dl_loading_dot_2'))),
      const Size(10, 10),
    );

    final dot = tester.widget<Container>(
      find.byKey(const Key('dl_loading_dot_0')),
    );
    final decoration = dot.decoration as BoxDecoration;
    expect(decoration.color, DlColorsLight.black);
  });

  testWidgets('animation loops 1->2->3 with alternating up/down', (
    tester,
  ) async {
    const step = Duration(milliseconds: 180);
    await pumpLoadingDots(
      tester,
      loadingDots: const DlLoadingDots(stepDuration: step),
    );

    // Initial: all bottom before first activation.
    expect(alignFor(tester, 0).alignment, Alignment.bottomCenter);
    expect(alignFor(tester, 1).alignment, Alignment.bottomCenter);
    expect(alignFor(tester, 2).alignment, Alignment.bottomCenter);

    // First dot goes up.
    await tester.pump();
    expect(alignFor(tester, 0).alignment, Alignment.topCenter);
    expect(alignFor(tester, 1).alignment, Alignment.bottomCenter);
    expect(alignFor(tester, 2).alignment, Alignment.bottomCenter);

    // Then second dot goes up while first goes down.
    await tester.pump(step);
    expect(alignFor(tester, 0).alignment, Alignment.bottomCenter);
    expect(alignFor(tester, 1).alignment, Alignment.topCenter);
    expect(alignFor(tester, 2).alignment, Alignment.bottomCenter);

    // Then third dot goes up while second goes down.
    await tester.pump(step);
    expect(alignFor(tester, 0).alignment, Alignment.bottomCenter);
    expect(alignFor(tester, 1).alignment, Alignment.bottomCenter);
    expect(alignFor(tester, 2).alignment, Alignment.topCenter);

    // Loop: first goes up while third goes down.
    await tester.pump(step);
    expect(alignFor(tester, 0).alignment, Alignment.topCenter);
    expect(alignFor(tester, 1).alignment, Alignment.bottomCenter);
    expect(alignFor(tester, 2).alignment, Alignment.bottomCenter);
  });
}
