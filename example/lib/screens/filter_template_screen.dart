import 'package:dynamiclayer_flutter/dynamiclayer_flutter.dart';
import 'package:flutter/material.dart';

class FilterTemplateScreen extends StatelessWidget {
  const FilterTemplateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.dlColors;

    return Scaffold(
      backgroundColor: colors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            DlTopNavigation(
              title: 'Filters',
              showSeparator: true,
              iconLeft: const DlPlaceholderIcon(),
              onIconLeftTap: () => Navigator.of(context).maybePop(),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(DlSpacingTokens.p_16),
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
                    const _SectionHeader(
                      title: 'Price range',
                      description: 'Total prices for the duration of your travel',
                    ),
                    const SizedBox(height: DlSpacingTokens.p_8),
                    const DlSlider(initialValue: 0.35),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
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
