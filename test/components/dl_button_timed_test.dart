import 'package:dynamic_layer_core/dynamic_layer_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpButtonTimed(
    WidgetTester tester, {
    required DlButtonTimed child,
    ThemeData? theme,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: theme ?? DlTheme.light(),
        home: Scaffold(body: Center(child: child)),
      ),
    );
  }

  testWidgets('renders initial countdown in label', (tester) async {
    await pumpButtonTimed(
      tester,
      child: const DlButtonTimed(label: 'Resend code', countdownInSeconds: 10),
    );

    expect(find.text('Resend code (0:10)'), findsOneWidget);
  });

  testWidgets('counts down every second to 0:00', (tester) async {
    await pumpButtonTimed(
      tester,
      child: const DlButtonTimed(label: 'Resend code', countdownInSeconds: 3),
    );

    expect(find.text('Resend code (0:03)'), findsOneWidget);
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('Resend code (0:02)'), findsOneWidget);
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('Resend code (0:01)'), findsOneWidget);
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('Resend code (0:00)'), findsOneWidget);
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('Resend code (0:00)'), findsOneWidget);
  });

  testWidgets('supports minute formatting', (tester) async {
    await pumpButtonTimed(
      tester,
      child: const DlButtonTimed(label: 'Timer', countdownInSeconds: 65),
    );

    expect(find.text('Timer (1:05)'), findsOneWidget);
  });

  testWidgets('calls onCountdownCompleted exactly once', (tester) async {
    var completedCount = 0;
    await pumpButtonTimed(
      tester,
      child: DlButtonTimed(
        label: 'Done',
        countdownInSeconds: 1,
        onCountdownCompleted: () => completedCount += 1,
      ),
    );

    await tester.pump(const Duration(seconds: 1));
    await tester.pump(const Duration(seconds: 1));
    expect(completedCount, 1);
  });

  testWidgets('passes through button type and size', (tester) async {
    await pumpButtonTimed(
      tester,
      child: const DlButtonTimed(
        label: 'Action',
        countdownInSeconds: 10,
        type: DlButtonType.secondary,
        size: DlButtonSize.sm,
      ),
    );

    final button = tester.widget<DlButton>(find.byType(DlButton));
    expect(button.type, DlButtonType.secondary);
    expect(button.size, DlButtonSize.sm);
  });

  testWidgets('is disabled during countdown and switches to default at 0:00', (
    tester,
  ) async {
    await pumpButtonTimed(
      tester,
      child: DlButtonTimed(
        label: 'Resend',
        countdownInSeconds: 2,
      ),
    );

    DlButton button() => tester.widget<DlButton>(find.byType(DlButton));

    expect(button().state, DlButtonState.disabled);
    expect(button().onPressed, isNull);

    await tester.pump(const Duration(seconds: 2));

    expect(find.text('Resend (0:00)'), findsOneWidget);
    expect(button().state, DlButtonState.defaultState);
    expect(button().onPressed, isNotNull);
  });

  testWidgets('clicking default restarts countdown cycle from initial value', (
    tester,
  ) async {
    var pressedCount = 0;
    await pumpButtonTimed(
      tester,
      child: DlButtonTimed(
        label: 'Resend',
        countdownInSeconds: 2,
        onPressed: () => pressedCount += 1,
      ),
    );

    DlButton button() => tester.widget<DlButton>(find.byType(DlButton));

    await tester.pump(const Duration(seconds: 2));
    expect(find.text('Resend (0:00)'), findsOneWidget);
    expect(button().state, DlButtonState.defaultState);

    await tester.tap(find.byType(DlButton));
    await tester.pump();

    expect(pressedCount, 1);
    expect(find.text('Resend (0:02)'), findsOneWidget);
    expect(button().state, DlButtonState.disabled);

    await tester.pump(const Duration(seconds: 2));
    expect(find.text('Resend (0:00)'), findsOneWidget);
    expect(button().state, DlButtonState.defaultState);
  });
}
