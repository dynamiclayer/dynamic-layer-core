import 'package:dynamic_layer_core/dynamic_layer_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpAccordion(
    WidgetTester tester, {
    required DlAccordion accordion,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: DlTheme.light(),
        home: Scaffold(
          body: Center(child: SizedBox(width: 343, child: accordion)),
        ),
      ),
    );
  }

  testWidgets('renders title and collapsed content by default', (tester) async {
    await pumpAccordion(
      tester,
      accordion: const DlAccordion(title: 'Accordion', content: 'Lorem ipsum'),
    );

    expect(find.byKey(const Key('dl_accordion_title')), findsOneWidget);
    expect(find.byKey(const Key('dl_accordion_content')), findsNothing);
    expect(find.byIcon(Icons.keyboard_arrow_down), findsOneWidget);
  });

  testWidgets('expands and collapses on tap', (tester) async {
    await pumpAccordion(
      tester,
      accordion: const DlAccordion(
        title: 'Accordion',
        content: 'Lorem ipsum dolor sit amet',
      ),
    );

    await tester.tap(find.byKey(const Key('dl_accordion_title')));
    await tester.pump();

    expect(find.byKey(const Key('dl_accordion_content')), findsOneWidget);
    expect(find.byIcon(Icons.keyboard_arrow_up), findsOneWidget);

    await tester.tap(find.byKey(const Key('dl_accordion_title')));
    await tester.pump();

    expect(find.byKey(const Key('dl_accordion_content')), findsNothing);
    expect(find.byIcon(Icons.keyboard_arrow_down), findsOneWidget);
  });

  testWidgets('can hide separator', (tester) async {
    await pumpAccordion(
      tester,
      accordion: const DlAccordion(
        title: 'Accordion',
        content: 'Lorem ipsum',
        showSeparator: false,
      ),
    );

    expect(find.byType(DlSeparator), findsNothing);
  });

  testWidgets('disabled is non-interactive and uses grey500 strike title', (
    tester,
  ) async {
    await pumpAccordion(
      tester,
      accordion: const DlAccordion(
        title: 'Accordion',
        content: 'Lorem ipsum',
        state: DlAccordionState.disabled,
      ),
    );

    final title = tester.widget<Text>(
      find.byKey(const Key('dl_accordion_title')),
    );
    final icon = tester.widget<Icon>(
      find.byKey(const Key('dl_accordion_icon')),
    );

    expect(title.style?.fontSize, DlTextStyles.textBase.strike.fontSize);
    expect(title.style?.fontWeight, DlTextStyles.textBase.strike.fontWeight);
    expect(title.style?.decoration, TextDecoration.lineThrough);
    expect(title.style?.color, DlColorsLight.grey500);
    expect(icon.color, DlColorsLight.grey500);

    await tester.tap(find.byKey(const Key('dl_accordion_title')));
    await tester.pump();

    expect(find.byKey(const Key('dl_accordion_content')), findsNothing);
    expect(find.byIcon(Icons.keyboard_arrow_down), findsOneWidget);
  });
}
