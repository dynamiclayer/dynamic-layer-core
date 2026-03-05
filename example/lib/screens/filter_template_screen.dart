import 'package:dynamiclayer_flutter/dynamiclayer_flutter.dart';
import 'package:flutter/material.dart';

class FilterTemplateScreen extends StatelessWidget {
  const FilterTemplateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.dlColors;
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    const dockBaseHeight = 89.0; // separator + p16 padding + button height
    final contentBottomPadding = dockBaseHeight + bottomInset + DlSpacingTokens.p_16;

    return Scaffold(
      backgroundColor: colors.white,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Column(
              children: [
                DlTopNavigation(
                  title: 'Filters',
                  showSeparator: true,
                  iconLeft: const DlPlaceholderIcon(),
                  onIconLeftTap: () => Navigator.of(context).maybePop(),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(
                      DlSpacingTokens.p_16,
                      DlSpacingTokens.p_16,
                      DlSpacingTokens.p_16,
                      contentBottomPadding,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _SectionHeader(
                          title: 'Accomodation type',
                          description: 'Total prices for the duration of your travel',
                        ),
                        const SizedBox(height: DlSpacingTokens.p_16),
                        const Wrap(
                          spacing: DlSpacingTokens.p_8,
                          runSpacing: DlSpacingTokens.p_8,
                          children: [
                            DlChip(label: 'Stays', size: DlChipSize.lg),
                            DlChip(label: 'Hostel', size: DlChipSize.lg),
                            DlChip(label: 'Guesthouse', size: DlChipSize.lg),
                            DlChip(label: 'Home', size: DlChipSize.lg),
                            DlChip(label: 'Appartment', size: DlChipSize.lg),
                          ],
                        ),
                        const SizedBox(height: DlSpacingTokens.p_16),
                        const DlSeparator(),
                        const SizedBox(height: DlSpacingTokens.p_16),
                        const _SectionHeader(
                          title: 'Price range',
                          description: 'Total prices for the duration of your travel',
                        ),
                        const SizedBox(height: DlSpacingTokens.p_8),
                        const DlSlider(initialValue: 0.35),
                        const SizedBox(height: DlSpacingTokens.p_16),
                        const DlSeparator(),
                        const SizedBox(height: DlSpacingTokens.p_16),
                        const _SectionHeaderLg(
                          title: 'Guest rating',
                          description: 'Total prices for the duration of your travel',
                        ),
                        const SizedBox(height: DlSpacingTokens.p_16),
                        const Column(
                          children: [
                            DlLineItem(
                              title: 'Excellent (9+)',
                              type: DlLineItemType.radioButton,
                              showSeparator: false,
                            ),
                            DlLineItem(
                              title: 'Very good (8+)',
                              type: DlLineItemType.radioButton,
                              showSeparator: false,
                            ),
                            DlLineItem(
                              title: 'Good (7+)',
                              type: DlLineItemType.radioButton,
                              showSeparator: false,
                            ),
                          ],
                        ),
                        const SizedBox(height: DlSpacingTokens.p_16),
                        const DlSeparator(),
                        const SizedBox(height: DlSpacingTokens.p_16),
                        const _SectionHeaderLg(
                          title: 'Guest rating',
                          description: 'Total prices for the duration of your travel',
                        ),
                        const SizedBox(height: DlSpacingTokens.p_16),
                        const Column(
                          children: [
                            DlLineItem(
                              title: 'Free cancellation',
                              type: DlLineItemType.checkbox,
                              showSeparator: false,
                            ),
                            DlLineItem(
                              title: 'Breakfast included',
                              type: DlLineItemType.checkbox,
                              showSeparator: false,
                            ),
                            DlLineItem(
                              title: 'Pay at property',
                              type: DlLineItemType.checkbox,
                              showSeparator: false,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: ColoredBox(
                color: colors.white,
                child: SafeArea(
                  top: false,
                  child: DlButtonDock(
                    buttons: [
                      DlButton(
                        label: 'Show results',
                        type: DlButtonType.primary,
                        onPressed: () {},
                      ),
                    ],
                    direction: Axis.horizontal,
                    showSeparator: true,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeaderLg extends StatelessWidget {
  const _SectionHeaderLg({
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final colors = context.dlColors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: DlTextStyles.textLg.semiBold.copyWith(color: colors.black),
        ),
        const SizedBox(height: DlSpacingTokens.p_8),
        Text(
          description,
          style: DlTextStyles.textSm.regular.copyWith(color: colors.grey.c500),
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final colors = context.dlColors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: DlTextStyles.textLg.semiBold.copyWith(color: colors.black),
        ),
        const SizedBox(height: DlSpacingTokens.p_8),
        Text(
          description,
          style: DlTextStyles.textSm.regular.copyWith(color: colors.grey.c500),
        ),
      ],
    );
  }
}
