import 'package:dynamiclayer_flutter/dynamiclayer_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpCoachMark(
    WidgetTester tester, {
    required DlCoachMark child,
    ThemeData? theme,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: theme ?? DlTheme.light(),
        home: Scaffold(body: Center(child: child)),
      ),
    );
  }

  testWidgets('uses tooltip-like background and arrow', (tester) async {
    await pumpCoachMark(
      tester,
      child: DlCoachMark(
        steps: const [
          DlCoachMarkStep(
            title: 'Coach title',
            description: 'Coach description',
          ),
        ],
      ),
    );

    final box = tester.widget<Container>(
      find.byKey(const Key('dl_coach_mark_box')),
    );
    final decoration = box.decoration as BoxDecoration;
    final radius = decoration.borderRadius as BorderRadius;

    expect(
      tester.getSize(find.byKey(const Key('dl_coach_mark'))).width > 300,
      isTrue,
    );
    expect(box.padding, const EdgeInsets.all(DlSpacingTokens.p_16));
    expect(decoration.color, const Color(0xFF1F1F1F));
    expect(radius.topLeft.x, DlRadiusTokens.roundedXl);
    expect(find.byKey(const Key('dl_coach_mark_arrow')), findsOneWidget);
    expect(
      tester.getSize(find.byKey(const Key('dl_coach_mark_arrow'))),
      const Size(20, 10),
    );
  });

  testWidgets(
    'title is textBase semiBold max one line, description is regular',
    (tester) async {
      await pumpCoachMark(
        tester,
        child: DlCoachMark(
          steps: const [
            DlCoachMarkStep(
              title: 'Coach title',
              description: 'Coach description',
            ),
          ],
        ),
      );

      final title = tester.widget<Text>(
        find.byKey(const Key('dl_coach_mark_title')),
      );
      final description = tester.widget<Text>(
        find.byKey(const Key('dl_coach_mark_description')),
      );

      expect(title.maxLines, 1);
      expect(title.overflow, TextOverflow.ellipsis);
      expect(
        title.style?.fontWeight,
        DlTextStyles.textBase.semiBold.fontWeight,
      );
      expect(title.style?.color, const Color(0xFFFFFFFF));

      expect(
        description.style?.fontWeight,
        DlTextStyles.textBase.regular.fontWeight,
      );
      expect(description.style?.color, const Color(0xFFFFFFFF));

      final titleToDescriptionGap = find.descendant(
        of: find.byKey(const Key('dl_coach_mark_box')),
        matching: find.byWidgetPredicate(
          (widget) =>
              widget is SizedBox && widget.height == DlSpacingTokens.p_8,
        ),
      );
      expect(titleToDescriptionGap, findsOneWidget);
    },
  );

  testWidgets('footer has pagination left and two xs secondary buttons right', (
    tester,
  ) async {
    await pumpCoachMark(
      tester,
      child: DlCoachMark(
        steps: const [
          DlCoachMarkStep(
            title: 'Coach title',
            description: 'Coach description',
          ),
        ],
      ),
    );

    expect(find.byType(DlPagination), findsOneWidget);

    final leftButton = tester.widget<DlButton>(
      find.byKey(const Key('dl_coach_mark_left_button')),
    );
    final rightButton = tester.widget<DlButton>(
      find.byKey(const Key('dl_coach_mark_right_button')),
    );

    expect(leftButton.type, DlButtonType.secondary);
    expect(leftButton.size, DlButtonSize.xs);
    expect(rightButton.type, DlButtonType.secondary);
    expect(rightButton.size, DlButtonSize.xs);
  });

  testWidgets('supports pagination callbacks and button callbacks', (
    tester,
  ) async {
    var page = -1;
    var leftTapped = false;
    var rightTapped = false;

    await pumpCoachMark(
      tester,
      child: DlCoachMark(
        steps: const [
          DlCoachMarkStep(title: 'Step 1', description: 'Desc 1'),
          DlCoachMarkStep(title: 'Step 2', description: 'Desc 2'),
          DlCoachMarkStep(title: 'Step 3', description: 'Desc 3'),
          DlCoachMarkStep(title: 'Step 4', description: 'Desc 4'),
        ],
        onPaginationChanged: (index) => page = index,
        onLeftButtonPressed: () => leftTapped = true,
        onRightButtonPressed: () => rightTapped = true,
      ),
    );

    await tester.tap(find.byKey(const Key('dl_pagination_item_1')));
    await tester.pump();
    expect(page, 1);

    await tester.tap(find.byKey(const Key('dl_coach_mark_left_button')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('dl_coach_mark_right_button')));
    await tester.pump();
    expect(rightTapped, isTrue);

    await tester.tap(find.byKey(const Key('dl_coach_mark_left_button')));
    await tester.pump();
    expect(leftTapped, isTrue);
  });

  testWidgets('back is disabled on first step and next disabled on last step', (
    tester,
  ) async {
    await pumpCoachMark(
      tester,
      child: DlCoachMark(
        steps: const [
          DlCoachMarkStep(title: 'Step 1', description: 'Desc 1'),
          DlCoachMarkStep(title: 'Step 2', description: 'Desc 2'),
        ],
      ),
    );

    DlButton leftButton() => tester.widget<DlButton>(
      find.byKey(const Key('dl_coach_mark_left_button')),
    );
    DlButton rightButton() => tester.widget<DlButton>(
      find.byKey(const Key('dl_coach_mark_right_button')),
    );

    expect(leftButton().state, DlButtonState.disabled);
    expect(rightButton().state, DlButtonState.defaultState);

    await tester.tap(find.byKey(const Key('dl_coach_mark_right_button')));
    await tester.pump();

    expect(leftButton().state, DlButtonState.defaultState);
    expect(rightButton().state, DlButtonState.disabled);
  });

  testWidgets('next/back update title and description per step', (
    tester,
  ) async {
    await pumpCoachMark(
      tester,
      child: DlCoachMark(
        steps: const [
          DlCoachMarkStep(title: 'Step 1', description: 'Description 1'),
          DlCoachMarkStep(title: 'Step 2', description: 'Description 2'),
        ],
      ),
    );

    expect(find.text('Step 1'), findsOneWidget);
    expect(find.text('Description 1'), findsOneWidget);

    await tester.tap(find.byKey(const Key('dl_coach_mark_right_button')));
    await tester.pump();
    expect(find.text('Step 2'), findsOneWidget);
    expect(find.text('Description 2'), findsOneWidget);

    await tester.tap(find.byKey(const Key('dl_coach_mark_left_button')));
    await tester.pump();
    expect(find.text('Step 1'), findsOneWidget);
    expect(find.text('Description 1'), findsOneWidget);
  });

  testWidgets('supports top, left, right arrow directions', (tester) async {
    Future<void> pumpWithDirection(DlCoachMarkDirection direction) async {
      await pumpCoachMark(
        tester,
        child: DlCoachMark(
          direction: direction,
          steps: const [
            DlCoachMarkStep(
              title: 'Coach title',
              description: 'Coach description',
            ),
          ],
        ),
      );
    }

    await pumpWithDirection(DlCoachMarkDirection.top);
    final topArrowRect = tester.getRect(
      find.byKey(const Key('dl_coach_mark_arrow')),
    );
    final topBoxRect = tester.getRect(
      find.byKey(const Key('dl_coach_mark_box')),
    );
    expect(topArrowRect.bottom <= topBoxRect.top, isTrue);

    await pumpWithDirection(DlCoachMarkDirection.left);
    final leftArrowRect = tester.getRect(
      find.byKey(const Key('dl_coach_mark_arrow')),
    );
    final leftBoxRect = tester.getRect(
      find.byKey(const Key('dl_coach_mark_box')),
    );
    expect(leftArrowRect.right <= leftBoxRect.left, isTrue);

    await pumpWithDirection(DlCoachMarkDirection.right);
    final rightArrowRect = tester.getRect(
      find.byKey(const Key('dl_coach_mark_arrow')),
    );
    final rightBoxRect = tester.getRect(
      find.byKey(const Key('dl_coach_mark_box')),
    );
    expect(rightArrowRect.left >= rightBoxRect.right, isTrue);
  });

  testWidgets('coach mark pagination uses fixed white colors', (tester) async {
    await pumpCoachMark(
      tester,
      child: DlCoachMark(
        steps: const [
          DlCoachMarkStep(title: 'Step 1', description: 'Desc 1'),
          DlCoachMarkStep(title: 'Step 2', description: 'Desc 2'),
          DlCoachMarkStep(title: 'Step 3', description: 'Desc 3'),
        ],
      ),
    );

    BoxDecoration dotDecoration(int index) =>
        tester
                .widget<Container>(find.byKey(Key('dl_pagination_dot_$index')))
                .decoration
            as BoxDecoration;

    expect(dotDecoration(0).color, Colors.white);
    expect(dotDecoration(1).color, Colors.white.withAlpha(102));
    expect(dotDecoration(2).color, Colors.white.withAlpha(102));
  });
}
