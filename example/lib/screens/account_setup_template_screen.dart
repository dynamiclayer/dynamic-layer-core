import 'package:dynamiclayer_flutter/dynamiclayer_flutter.dart';
import 'package:flutter/material.dart';

class AccountSetupTemplateScreen extends StatefulWidget {
  const AccountSetupTemplateScreen({super.key});

  @override
  State<AccountSetupTemplateScreen> createState() => _AccountSetupTemplateScreenState();
}

class _AccountSetupTemplateScreenState extends State<AccountSetupTemplateScreen> {
  final Map<String, bool> _chipSelection = <String, bool>{
    'Traveler': false,
    'Host': false,
    'Business': false,
    'Student': false,
    'Family': false,
  };

  bool get _hasActiveChip => _chipSelection.values.any((selected) => selected);

  @override
  Widget build(BuildContext context) {
    final colors = context.dlColors;
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    const dockBaseHeight = 89.0;
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
                  title: 'Create account',
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
                    child: Flex(
                      direction: Axis.vertical,
                      spacing: DlSpacingTokens.p_16,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const _SectionHeader(
                          title: 'Account type',
                          description:
                              'Choose at least one profile type to personalize your setup.',
                        ),
                        Wrap(
                          spacing: DlSpacingTokens.p_8,
                          runSpacing: DlSpacingTokens.p_8,
                          children: [
                            for (final entry in _chipSelection.entries)
                              DlChip(
                                label: entry.key,
                                size: DlChipSize.lg,
                                state: entry.value
                                    ? DlChipState.active
                                    : DlChipState.defaultState,
                                onStateChanged: (state) {
                                  setState(() {
                                    _chipSelection[entry.key] = state == DlChipState.active;
                                  });
                                },
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
                        label: 'Continue',
                        type: DlButtonType.primary,
                        state: _hasActiveChip
                            ? DlButtonState.defaultState
                            : DlButtonState.disabled,
                        onPressed: _hasActiveChip ? () {} : null,
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
