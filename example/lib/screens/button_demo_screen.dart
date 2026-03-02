import 'package:dynamiclayer_flutter/dynamiclayer_flutter.dart';
import 'package:flutter/material.dart';

class ButtonDemoScreen extends StatelessWidget {
  const ButtonDemoScreen({super.key});

  static const String _longLabel =
      'This is a very long button label for ellipsis testing in the example app.';

  @override
  Widget build(BuildContext context) {
    final colors = context.dlColors;
    return Scaffold(
      backgroundColor: colors.white,
      appBar: AppBar(title: const Text('DlButton Demo')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(DlSpacingTokens.p_24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DlButton(label: 'Primary / Default', onPressed: () {}),
              const SizedBox(height: DlSpacingTokens.p_16),
              DlButton(
                label: 'Primary / Disabled',
                state: DlButtonState.disabled,
                onPressed: () {},
                iconLeft: const DlPlaceholderIcon(),
                iconRight: const DlPlaceholderIcon(),
              ),
              const SizedBox(height: DlSpacingTokens.p_16),
              DlButton(label: _longLabel, onPressed: () {}),
              const SizedBox(height: DlSpacingTokens.p_16),
              DlButton(
                label: 'Secondary / Default',
                type: DlButtonType.secondary,
                onPressed: () {},
              ),
              const SizedBox(height: DlSpacingTokens.p_16),
              DlButton(
                label: 'Secondary / Disabled',
                type: DlButtonType.secondary,
                state: DlButtonState.disabled,
                onPressed: () {},
                iconLeft: const DlPlaceholderIcon(),
                iconRight: const DlPlaceholderIcon(),
              ),
              const SizedBox(height: DlSpacingTokens.p_16),
              DlButton(
                label: _longLabel,
                type: DlButtonType.secondary,
                onPressed: () {},
              ),
              const SizedBox(height: DlSpacingTokens.p_16),
              DlButton(
                label: 'Tertiary / Default',
                type: DlButtonType.tertiary,
                onPressed: () {},
              ),
              const SizedBox(height: DlSpacingTokens.p_16),
              DlButton(
                label: 'Tertiary / Disabled',
                type: DlButtonType.tertiary,
                state: DlButtonState.disabled,
                onPressed: () {},
                iconLeft: const DlPlaceholderIcon(),
                iconRight: const DlPlaceholderIcon(),
              ),
              const SizedBox(height: DlSpacingTokens.p_16),
              DlButton(
                label: _longLabel,
                type: DlButtonType.tertiary,
                onPressed: () {},
              ),
              const SizedBox(height: DlSpacingTokens.p_16),
              DlButton(
                label: 'Ghost / Default',
                type: DlButtonType.ghost,
                onPressed: () {},
              ),
              const SizedBox(height: DlSpacingTokens.p_16),
              DlButton(
                label: 'Ghost / Disabled',
                type: DlButtonType.ghost,
                state: DlButtonState.disabled,
                onPressed: () {},
                iconLeft: const DlPlaceholderIcon(),
                iconRight: const DlPlaceholderIcon(),
              ),
              const SizedBox(height: DlSpacingTokens.p_16),
              DlButton(
                label: _longLabel,
                type: DlButtonType.ghost,
                onPressed: () {},
              ),
              const SizedBox(height: DlSpacingTokens.p_16),
              DlButton(
                label: 'With icons',
                onPressed: () {},
                iconLeft: const DlPlaceholderIcon(),
                iconRight: const DlPlaceholderIcon(),
              ),
              const SizedBox(height: DlSpacingTokens.p_32),
              const Text('Size md examples'),
              const SizedBox(height: DlSpacingTokens.p_16),
              DlButton(
                label: 'Primary md / Default',
                size: DlButtonSize.md,
                onPressed: () {},
              ),
              const SizedBox(height: DlSpacingTokens.p_16),
              DlButton(
                label: 'Primary md / Disabled',
                size: DlButtonSize.md,
                state: DlButtonState.disabled,
                onPressed: () {},
                iconLeft: const DlPlaceholderIcon(),
                iconRight: const DlPlaceholderIcon(),
              ),
              const SizedBox(height: DlSpacingTokens.p_16),
              DlButton(
                label: _longLabel,
                size: DlButtonSize.md,
                onPressed: () {},
              ),
              const SizedBox(height: DlSpacingTokens.p_16),
              DlButton(
                label: 'Secondary md / Default',
                type: DlButtonType.secondary,
                size: DlButtonSize.md,
                onPressed: () {},
              ),
              const SizedBox(height: DlSpacingTokens.p_16),
              DlButton(
                label: 'Secondary md / Disabled',
                type: DlButtonType.secondary,
                size: DlButtonSize.md,
                state: DlButtonState.disabled,
                onPressed: () {},
                iconLeft: const DlPlaceholderIcon(),
                iconRight: const DlPlaceholderIcon(),
              ),
              const SizedBox(height: DlSpacingTokens.p_16),
              DlButton(
                label: _longLabel,
                type: DlButtonType.secondary,
                size: DlButtonSize.md,
                onPressed: () {},
              ),
              const SizedBox(height: DlSpacingTokens.p_16),
              DlButton(
                label: 'Tertiary md / Default',
                type: DlButtonType.tertiary,
                size: DlButtonSize.md,
                onPressed: () {},
              ),
              const SizedBox(height: DlSpacingTokens.p_16),
              DlButton(
                label: 'Tertiary md / Disabled',
                type: DlButtonType.tertiary,
                size: DlButtonSize.md,
                state: DlButtonState.disabled,
                onPressed: () {},
                iconLeft: const DlPlaceholderIcon(),
                iconRight: const DlPlaceholderIcon(),
              ),
              const SizedBox(height: DlSpacingTokens.p_16),
              DlButton(
                label: _longLabel,
                type: DlButtonType.tertiary,
                size: DlButtonSize.md,
                onPressed: () {},
              ),
              const SizedBox(height: DlSpacingTokens.p_16),
              DlButton(
                label: 'Ghost md / Default',
                type: DlButtonType.ghost,
                size: DlButtonSize.md,
                onPressed: () {},
              ),
              const SizedBox(height: DlSpacingTokens.p_16),
              DlButton(
                label: 'Ghost md / Disabled',
                type: DlButtonType.ghost,
                size: DlButtonSize.md,
                state: DlButtonState.disabled,
                onPressed: () {},
                iconLeft: const DlPlaceholderIcon(),
                iconRight: const DlPlaceholderIcon(),
              ),
              const SizedBox(height: DlSpacingTokens.p_16),
              DlButton(
                label: _longLabel,
                type: DlButtonType.ghost,
                size: DlButtonSize.md,
                onPressed: () {},
              ),
              const SizedBox(height: DlSpacingTokens.p_32),
              const Text('Size sm examples'),
              const SizedBox(height: DlSpacingTokens.p_16),
              DlButton(
                label: 'Primary sm / Default',
                size: DlButtonSize.sm,
                onPressed: () {},
              ),
              const SizedBox(height: DlSpacingTokens.p_16),
              DlButton(
                label: 'Primary sm / Disabled',
                size: DlButtonSize.sm,
                state: DlButtonState.disabled,
                onPressed: () {},
                iconLeft: const DlPlaceholderIcon(),
                iconRight: const DlPlaceholderIcon(),
              ),
              const SizedBox(height: DlSpacingTokens.p_16),
              DlButton(
                label: _longLabel,
                size: DlButtonSize.sm,
                onPressed: () {},
              ),
              const SizedBox(height: DlSpacingTokens.p_16),
              DlButton(
                label: 'Secondary sm / Default',
                type: DlButtonType.secondary,
                size: DlButtonSize.sm,
                onPressed: () {},
              ),
              const SizedBox(height: DlSpacingTokens.p_16),
              DlButton(
                label: 'Secondary sm / Disabled',
                type: DlButtonType.secondary,
                size: DlButtonSize.sm,
                state: DlButtonState.disabled,
                onPressed: () {},
                iconLeft: const DlPlaceholderIcon(),
                iconRight: const DlPlaceholderIcon(),
              ),
              const SizedBox(height: DlSpacingTokens.p_16),
              DlButton(
                label: _longLabel,
                type: DlButtonType.secondary,
                size: DlButtonSize.sm,
                onPressed: () {},
              ),
              const SizedBox(height: DlSpacingTokens.p_16),
              DlButton(
                label: 'Tertiary sm / Default',
                type: DlButtonType.tertiary,
                size: DlButtonSize.sm,
                onPressed: () {},
              ),
              const SizedBox(height: DlSpacingTokens.p_16),
              DlButton(
                label: 'Tertiary sm / Disabled',
                type: DlButtonType.tertiary,
                size: DlButtonSize.sm,
                state: DlButtonState.disabled,
                onPressed: () {},
                iconLeft: const DlPlaceholderIcon(),
                iconRight: const DlPlaceholderIcon(),
              ),
              const SizedBox(height: DlSpacingTokens.p_16),
              DlButton(
                label: _longLabel,
                type: DlButtonType.tertiary,
                size: DlButtonSize.sm,
                onPressed: () {},
              ),
              const SizedBox(height: DlSpacingTokens.p_16),
              DlButton(
                label: 'Ghost sm / Default',
                type: DlButtonType.ghost,
                size: DlButtonSize.sm,
                onPressed: () {},
              ),
              const SizedBox(height: DlSpacingTokens.p_16),
              DlButton(
                label: 'Ghost sm / Disabled',
                type: DlButtonType.ghost,
                size: DlButtonSize.sm,
                state: DlButtonState.disabled,
                onPressed: () {},
                iconLeft: const DlPlaceholderIcon(),
                iconRight: const DlPlaceholderIcon(),
              ),
              const SizedBox(height: DlSpacingTokens.p_16),
              DlButton(
                label: _longLabel,
                type: DlButtonType.ghost,
                size: DlButtonSize.sm,
                onPressed: () {},
              ),
              const SizedBox(height: DlSpacingTokens.p_32),
              const Text('Size xs examples'),
              const SizedBox(height: DlSpacingTokens.p_16),
              DlButton(
                label: 'Primary xs / Default',
                size: DlButtonSize.xs,
                onPressed: () {},
              ),
              const SizedBox(height: DlSpacingTokens.p_16),
              DlButton(
                label: 'Primary xs / Disabled',
                size: DlButtonSize.xs,
                state: DlButtonState.disabled,
                onPressed: () {},
                iconLeft: const DlPlaceholderIcon(),
                iconRight: const DlPlaceholderIcon(),
              ),
              const SizedBox(height: DlSpacingTokens.p_16),
              DlButton(
                label: _longLabel,
                size: DlButtonSize.xs,
                onPressed: () {},
              ),
              const SizedBox(height: DlSpacingTokens.p_16),
              DlButton(
                label: 'Secondary xs / Default',
                type: DlButtonType.secondary,
                size: DlButtonSize.xs,
                onPressed: () {},
              ),
              const SizedBox(height: DlSpacingTokens.p_16),
              DlButton(
                label: 'Secondary xs / Disabled',
                type: DlButtonType.secondary,
                size: DlButtonSize.xs,
                state: DlButtonState.disabled,
                onPressed: () {},
                iconLeft: const DlPlaceholderIcon(),
                iconRight: const DlPlaceholderIcon(),
              ),
              const SizedBox(height: DlSpacingTokens.p_16),
              DlButton(
                label: _longLabel,
                type: DlButtonType.secondary,
                size: DlButtonSize.xs,
                onPressed: () {},
              ),
              const SizedBox(height: DlSpacingTokens.p_16),
              DlButton(
                label: 'Tertiary xs / Default',
                type: DlButtonType.tertiary,
                size: DlButtonSize.xs,
                onPressed: () {},
              ),
              const SizedBox(height: DlSpacingTokens.p_16),
              DlButton(
                label: 'Tertiary xs / Disabled',
                type: DlButtonType.tertiary,
                size: DlButtonSize.xs,
                state: DlButtonState.disabled,
                onPressed: () {},
                iconLeft: const DlPlaceholderIcon(),
                iconRight: const DlPlaceholderIcon(),
              ),
              const SizedBox(height: DlSpacingTokens.p_16),
              DlButton(
                label: _longLabel,
                type: DlButtonType.tertiary,
                size: DlButtonSize.xs,
                onPressed: () {},
              ),
              const SizedBox(height: DlSpacingTokens.p_16),
              DlButton(
                label: 'Ghost xs / Default',
                type: DlButtonType.ghost,
                size: DlButtonSize.xs,
                onPressed: () {},
              ),
              const SizedBox(height: DlSpacingTokens.p_16),
              DlButton(
                label: 'Ghost xs / Disabled',
                type: DlButtonType.ghost,
                size: DlButtonSize.xs,
                state: DlButtonState.disabled,
                onPressed: () {},
                iconLeft: const DlPlaceholderIcon(),
                iconRight: const DlPlaceholderIcon(),
              ),
              const SizedBox(height: DlSpacingTokens.p_16),
              DlButton(
                label: _longLabel,
                type: DlButtonType.ghost,
                size: DlButtonSize.xs,
                onPressed: () {},
              ),
              const SizedBox(height: DlSpacingTokens.p_32),
              _buildButtonIconSection(),
              const SizedBox(height: DlSpacingTokens.p_32),
              _buildSeparatorSection(),
              const SizedBox(height: DlSpacingTokens.p_32),
              _buildBadgeSection(),
              const SizedBox(height: DlSpacingTokens.p_32),
              _buildAccordionSection(),
              const SizedBox(height: DlSpacingTokens.p_32),
              _buildAlertSection(),
              const SizedBox(height: DlSpacingTokens.p_32),
              _buildAvatarSection(),
              const SizedBox(height: DlSpacingTokens.p_32),
              _buildCardSection(),
              const SizedBox(height: DlSpacingTokens.p_32),
              _buildBottomSheetSection(),
              const SizedBox(height: DlSpacingTokens.p_32),
              _buildBottomNavigationSection(),
              const SizedBox(height: DlSpacingTokens.p_32),
              _buildCheckboxSection(),
              const SizedBox(height: DlSpacingTokens.p_32),
              _buildRadioButtonSection(),
              const SizedBox(height: DlSpacingTokens.p_32),
              _buildChipSection(),
              const SizedBox(height: DlSpacingTokens.p_32),
              _buildInputSection(),
              const SizedBox(height: DlSpacingTokens.p_32),
              _buildSearchFieldSection(),
              const SizedBox(height: DlSpacingTokens.p_32),
              _buildTextareaSection(),
              const SizedBox(height: DlSpacingTokens.p_32),
              _buildOtpInputSection(),
              const SizedBox(height: DlSpacingTokens.p_32),
              _buildSwitchSection(),
              const SizedBox(height: DlSpacingTokens.p_32),
              _buildTagSection(),
              const SizedBox(height: DlSpacingTokens.p_32),
              _buildTopNavigationSection(),
              const SizedBox(height: DlSpacingTokens.p_32),
              _buildTopNavigationMessageSection(),
              const SizedBox(height: DlSpacingTokens.p_32),
              _buildMessageDockSection(),
              const SizedBox(height: DlSpacingTokens.p_32),
              _buildMessageLoadingSection(),
              const SizedBox(height: DlSpacingTokens.p_32),
              _buildLoadingDotsSection(),
              const SizedBox(height: DlSpacingTokens.p_32),
              _buildSnackbarSection(),
              const SizedBox(height: DlSpacingTokens.p_32),
              _buildSkeletonSection(),
              const SizedBox(height: DlSpacingTokens.p_32),
              _buildProgressSection(),
              const SizedBox(height: DlSpacingTokens.p_32),
              _buildSliderSection(),
              const SizedBox(height: DlSpacingTokens.p_32),
              _buildSegmentedControlSection(),
              const SizedBox(height: DlSpacingTokens.p_32),
              _buildTabControlSection(),
              const SizedBox(height: DlSpacingTokens.p_32),
              _buildPaginationSection(),
              const SizedBox(height: DlSpacingTokens.p_32),
              _buildPinKeyboardSection(),
              const SizedBox(height: DlSpacingTokens.p_32),
              _buildTooltipSection(),
              const SizedBox(height: DlSpacingTokens.p_32),
              _buildButtonDockSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtonIconSection() {
    return Column(
      children: [
        const Text('DlButtonIcon examples'),
        const SizedBox(height: DlSpacingTokens.p_16),
        _buildButtonIconSizeSection(DlButtonSize.lg),
        const SizedBox(height: DlSpacingTokens.p_24),
        _buildButtonIconSizeSection(DlButtonSize.md),
        const SizedBox(height: DlSpacingTokens.p_24),
        _buildButtonIconSizeSection(DlButtonSize.sm),
        const SizedBox(height: DlSpacingTokens.p_24),
        _buildButtonIconSizeSection(DlButtonSize.xs),
      ],
    );
  }

  Widget _buildButtonIconSizeSection(DlButtonSize size) {
    return Column(
      children: [
        Text('Size ${size.name}'),
        const SizedBox(height: DlSpacingTokens.p_12),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: DlSpacingTokens.p_12,
          runSpacing: DlSpacingTokens.p_16,
          children: [
            for (final type in DlButtonType.values) ...[
              _buildButtonIconExample(
                label: '${type.name} / default',
                child: DlButtonIcon(
                  icon: const DlPlaceholderIcon(),
                  type: type,
                  size: size,
                  onPressed: () {},
                ),
              ),
              _buildButtonIconExample(
                label: '${type.name} / pressed',
                child: DlButtonIcon(
                  icon: const DlPlaceholderIcon(),
                  type: type,
                  size: size,
                  state: DlButtonState.pressed,
                  onPressed: () {},
                ),
              ),
              _buildButtonIconExample(
                label: '${type.name} / disabled',
                child: DlButtonIcon(
                  icon: const DlPlaceholderIcon(),
                  type: type,
                  size: size,
                  state: DlButtonState.disabled,
                  onPressed: () {},
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildButtonIconExample({
    required String label,
    required Widget child,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label),
        const SizedBox(height: DlSpacingTokens.p_8),
        child,
      ],
    );
  }

  Widget _buildBottomSheetSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        Text('DlBottomSheet examples'),
        SizedBox(height: DlSpacingTokens.p_16),
        DlBottomSheet(
          headerTitle: 'Complete your profile',
          contentTitle: 'Add your details',
          contentDescription:
              'Finish your profile to unlock all Dynamic Layer features.',
          primaryButtonLabel: 'Continue',
          secondaryButtonLabel: 'Not now',
        ),
      ],
    );
  }

  Widget _buildBottomNavigationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('DlBottomNavigation examples'),
        const SizedBox(height: DlSpacingTokens.p_16),
        const Text('Badge sm + labels + separator'),
        const SizedBox(height: DlSpacingTokens.p_8),
        DlBottomNavigation(
          tabs: [
            DlBottomNavigationTab(
              text: 'Home',
              badge: DlBadge(size: DlBadgeSize.sm),
            ),
            DlBottomNavigationTab(text: 'Search'),
            DlBottomNavigationTab(text: 'Profile'),
          ],
        ),
        const SizedBox(height: DlSpacingTokens.p_16),
        const Text('Badge md + labels + separator'),
        const SizedBox(height: DlSpacingTokens.p_8),
        DlBottomNavigation(
          tabs: [
            DlBottomNavigationTab(
              text: 'Inbox',
              badge: DlBadge(size: DlBadgeSize.md, value: '12'),
            ),
            DlBottomNavigationTab(text: 'Updates'),
            DlBottomNavigationTab(text: 'Settings'),
          ],
        ),
        const SizedBox(height: DlSpacingTokens.p_16),
        const Text('No separator + mixed (sm + md) badges'),
        const SizedBox(height: DlSpacingTokens.p_8),
        DlBottomNavigation(
          showSeparator: false,
          tabs: [
            DlBottomNavigationTab(
              text: 'Alerts',
              badge: DlBadge(size: DlBadgeSize.sm),
            ),
            DlBottomNavigationTab(
              text: 'Messages',
              badge: DlBadge(size: DlBadgeSize.md, value: '3'),
            ),
            DlBottomNavigationTab(text: 'Profile'),
          ],
        ),
        const SizedBox(height: DlSpacingTokens.p_16),
        const Text('No separator + icon only tabs'),
        const SizedBox(height: DlSpacingTokens.p_8),
        DlBottomNavigation(
          showSeparator: false,
          tabs: [
            DlBottomNavigationTab(badge: DlBadge(size: DlBadgeSize.sm)),
            DlBottomNavigationTab(),
            DlBottomNavigationTab(
              badge: DlBadge(size: DlBadgeSize.md, value: '99'),
            ),
          ],
        ),
        const SizedBox(height: DlSpacingTokens.p_16),
        const Text('Very long tab labels'),
        const SizedBox(height: DlSpacingTokens.p_8),
        DlBottomNavigation(
          tabs: [
            DlBottomNavigationTab(
              text: 'Super long home tab label that should truncate',
            ),
            DlBottomNavigationTab(
              text: 'Another very very long profile label for testing',
            ),
            DlBottomNavigationTab(
              text: 'Extremely long settings tab label in one line',
            ),
          ],
        ),
        const SizedBox(height: DlSpacingTokens.p_16),
        const Text('5 tabs variation'),
        const SizedBox(height: DlSpacingTokens.p_8),
        DlBottomNavigation(
          showSeparator: false,
          tabs: [
            DlBottomNavigationTab(text: 'Home'),
            DlBottomNavigationTab(
              text: 'Inbox',
              badge: DlBadge(size: DlBadgeSize.md, value: '4'),
            ),
            DlBottomNavigationTab(text: 'Search'),
            DlBottomNavigationTab(text: 'Profile'),
            DlBottomNavigationTab(text: 'Settings'),
          ],
        ),
      ],
    );
  }

  Widget _buildSeparatorSection() {
    return Column(
      children: [
        const Text('DlSeparator examples'),
        const SizedBox(height: DlSpacingTokens.p_16),
        const Text('Horizontal in 80px container'),
        const SizedBox(height: DlSpacingTokens.p_8),
        Container(
          width: 80,
          color: Colors.transparent,
          child: const DlSeparator(),
        ),
        const SizedBox(height: DlSpacingTokens.p_24),
        const Text('Vertical in 80px container'),
        const SizedBox(height: DlSpacingTokens.p_8),
        Container(
          height: 80,
          color: Colors.transparent,
          child: const DlSeparator(
            orientation: DlSeparatorOrientation.vertical,
          ),
        ),
      ],
    );
  }

  Widget _buildBadgeSection() {
    return Column(
      children: [
        const Text('DlBadge examples'),
        const SizedBox(height: DlSpacingTokens.p_16),
        const Text('Size sm'),
        const SizedBox(height: DlSpacingTokens.p_8),
        const DlBadge(size: DlBadgeSize.sm),
        const SizedBox(height: DlSpacingTokens.p_24),
        const Text('Size md'),
        const SizedBox(height: DlSpacingTokens.p_8),
        const Wrap(
          alignment: WrapAlignment.center,
          spacing: DlSpacingTokens.p_12,
          children: [
            DlBadge(size: DlBadgeSize.md, value: '1'),
            DlBadge(size: DlBadgeSize.md, value: '9'),
            DlBadge(size: DlBadgeSize.md, value: '99'),
            DlBadge(size: DlBadgeSize.md, value: '999'),
          ],
        ),
      ],
    );
  }

  Widget _buildAccordionSection() {
    return Column(
      children: [
        const Text('DlAccordion examples'),
        const SizedBox(height: DlSpacingTokens.p_16),
        const DlAccordion(
          title: 'Accordion',
          content:
              'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.',
        ),
        const SizedBox(height: DlSpacingTokens.p_16),
        const DlAccordion(
          title: 'Accordion / No separator',
          content:
              'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.',
          showSeparator: false,
        ),
        const SizedBox(height: DlSpacingTokens.p_16),
        const DlAccordion(
          title: 'Accordion / Disabled',
          content:
              'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.',
          state: DlAccordionState.disabled,
        ),
      ],
    );
  }

  Widget _buildAlertSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('DlAlert examples'),
        const SizedBox(height: DlSpacingTokens.p_16),
        const DlAlert(
          title: 'Info alert',
          description:
              'This is an informational message in the alert component.',
          variant: DlAlertVariant.info,
        ),
        const SizedBox(height: DlSpacingTokens.p_12),
        const DlAlert(
          title: 'Success alert',
          description: 'This action has been completed successfully.',
          variant: DlAlertVariant.success,
        ),
        const SizedBox(height: DlSpacingTokens.p_12),
        const DlAlert(
          title: 'Warning alert',
          description: 'Please review this state before continuing.',
          variant: DlAlertVariant.warning,
        ),
        const SizedBox(height: DlSpacingTokens.p_12),
        DlAlert(
          title: 'Error alert (dismissible)',
          description: 'Something went wrong while processing your request.',
          variant: DlAlertVariant.error,
          onClose: () {},
        ),
      ],
    );
  }

  Widget _buildAvatarSection() {
    return Column(
      children: [
        const Text('DlAvatar examples'),
        const SizedBox(height: DlSpacingTokens.p_16),
        const DlAvatar(),
        const SizedBox(height: DlSpacingTokens.p_16),
        const DlAvatar(type: DlAvatarType.initials, initials: 'Aa'),
        const SizedBox(height: DlSpacingTokens.p_16),
        const DlAvatar(type: DlAvatarType.image),
        const SizedBox(height: DlSpacingTokens.p_16),
        const DlAvatar(state: DlAvatarState.online),
        const SizedBox(height: DlSpacingTokens.p_16),
        const DlAvatar(state: DlAvatarState.offline),
        const SizedBox(height: DlSpacingTokens.p_16),
        const DlAvatar(size: DlAvatarSize.md, state: DlAvatarState.online),
        const SizedBox(height: DlSpacingTokens.p_16),
        const DlAvatar(size: DlAvatarSize.sm, state: DlAvatarState.offline),
        const SizedBox(height: DlSpacingTokens.p_16),
        const DlAvatar(size: DlAvatarSize.xs, state: DlAvatarState.online),
      ],
    );
  }

  Widget _buildCardSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('DlCard examples'),
        const SizedBox(height: DlSpacingTokens.p_16),
        _buildCardPair(
          const DlCard(
            icon: DlPlaceholderIcon(),
            title: 'md / with description',
            description: 'Optional description text',
          ),
          const DlCard(icon: DlPlaceholderIcon(), title: 'md / title only'),
        ),
        const SizedBox(height: DlSpacingTokens.p_16),
        _buildCardPair(
          const DlCard(
            icon: DlPlaceholderIcon(),
            title: 'lg / with description',
            description: 'Optional description text',
            size: DlCardSize.lg,
          ),
          const DlCard(
            icon: DlPlaceholderIcon(),
            title: 'lg / title only',
            size: DlCardSize.lg,
          ),
        ),
        const SizedBox(height: DlSpacingTokens.p_16),
        _buildCardPair(
          const DlCard(
            icon: DlPlaceholderIcon(),
            title: 'md / active toggle',
            description: 'Tap to toggle 2px border',
            enableActiveState: true,
          ),
          const DlCard(
            icon: DlPlaceholderIcon(),
            title: 'lg / active toggle',
            description: 'Tap to toggle 2px border',
            size: DlCardSize.lg,
            enableActiveState: true,
          ),
        ),
        const SizedBox(height: DlSpacingTokens.p_16),
        _buildCardPair(
          const DlCard(
            icon: DlPlaceholderIcon(),
            title: 'md / disabled',
            description: 'Icon and text use grey500',
            state: DlCardState.disabled,
          ),
          const DlCard(
            icon: DlAssetIcon(assetPath: DlIcons.infoAsset),
            title: 'lg / custom icon',
            description: 'Icon is replaceable',
            size: DlCardSize.lg,
          ),
        ),
      ],
    );
  }

  Widget _buildCardPair(Widget left, Widget right) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: left),
        const SizedBox(width: DlSpacingTokens.p_16),
        Expanded(child: right),
      ],
    );
  }

  Widget _buildCheckboxSection() {
    return Column(
      children: [
        const Text('DlCheckbox examples'),
        const SizedBox(height: DlSpacingTokens.p_16),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DlCheckbox(),
            SizedBox(width: DlSpacingTokens.p_16),
            DlCheckbox(state: DlCheckboxState.disabled),
          ],
        ),
      ],
    );
  }

  Widget _buildRadioButtonSection() {
    return Column(
      children: [
        const Text('DlRadioButton examples'),
        const SizedBox(height: DlSpacingTokens.p_16),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DlRadioButton(),
            SizedBox(width: DlSpacingTokens.p_16),
            DlRadioButton(state: DlRadioButtonState.disabled),
          ],
        ),
      ],
    );
  }

  Widget _buildChipSection() {
    return Column(
      children: [
        const Text('DlChip examples'),
        const SizedBox(height: DlSpacingTokens.p_16),
        const Wrap(
          alignment: WrapAlignment.center,
          spacing: DlSpacingTokens.p_16,
          runSpacing: DlSpacingTokens.p_16,
          children: [
            DlChip(label: 'lg default', size: DlChipSize.lg),
            DlChip(
              label: 'lg disabled',
              size: DlChipSize.lg,
              state: DlChipState.disabled,
            ),
            DlChip(label: 'md default', size: DlChipSize.md),
            DlChip(
              label: 'md disabled',
              size: DlChipSize.md,
              state: DlChipState.disabled,
            ),
            DlChip(label: 'sm default', size: DlChipSize.sm),
            DlChip(
              label: 'sm disabled',
              size: DlChipSize.sm,
              state: DlChipState.disabled,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInputSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('DlInput examples'),
        const SizedBox(height: DlSpacingTokens.p_16),
        const Text('Default'),
        const SizedBox(height: DlSpacingTokens.p_8),
        const DlInput(placeholder: 'Placeholder'),
        const SizedBox(height: DlSpacingTokens.p_16),
        const Text('Size mg'),
        const SizedBox(height: DlSpacingTokens.p_8),
        const DlInput(placeholder: 'Placeholder mg', size: DlInputSize.mg),
        const SizedBox(height: DlSpacingTokens.p_16),
        const Text('Size sm'),
        const SizedBox(height: DlSpacingTokens.p_8),
        const DlInput(placeholder: 'Placeholder sm', size: DlInputSize.sm),
        const SizedBox(height: DlSpacingTokens.p_16),
        const Text('Default / long placeholder (ellipsis)'),
        const SizedBox(height: DlSpacingTokens.p_8),
        const DlInput(
          placeholder:
              'This is a very long placeholder text to test one-line ellipsis behavior in DlInput.',
        ),
        const SizedBox(height: DlSpacingTokens.p_16),
        const Text('Default / icon left'),
        const SizedBox(height: DlSpacingTokens.p_8),
        const DlInput(
          placeholder: 'Search',
          iconLeft: DlPlaceholderIcon(),
          size: DlInputSize.mg,
        ),
        const SizedBox(height: DlSpacingTokens.p_16),
        const Text('Default / icon left + icon right'),
        const SizedBox(height: DlSpacingTokens.p_8),
        const DlInput(
          placeholder: 'Input with icons',
          iconLeft: DlPlaceholderIcon(),
          iconRight: DlPlaceholderIcon(),
        ),
        const SizedBox(height: DlSpacingTokens.p_16),
        const Text('Error'),
        const SizedBox(height: DlSpacingTokens.p_8),
        const DlInput(
          placeholder: 'Error input',
          type: DlInputType.error,
          errorHelperText: 'This field has an error',
          size: DlInputSize.lg,
        ),
        const SizedBox(height: DlSpacingTokens.p_16),
        const Text('Error / long helper (ellipsis)'),
        const SizedBox(height: DlSpacingTokens.p_8),
        const DlInput(
          placeholder: 'Error input with long helper',
          type: DlInputType.error,
          errorHelperText:
              'This is a very long error helper text that should be truncated to one line with ellipsis.',
        ),
        const SizedBox(height: DlSpacingTokens.p_16),
        const Text('Success'),
        const SizedBox(height: DlSpacingTokens.p_8),
        const DlInput(
          placeholder: 'Success input',
          type: DlInputType.success,
          size: DlInputSize.sm,
        ),
        const SizedBox(height: DlSpacingTokens.p_16),
        const Text('Disabled / default'),
        const SizedBox(height: DlSpacingTokens.p_8),
        const DlInput(placeholder: 'Disabled input', enabled: false),
        const SizedBox(height: DlSpacingTokens.p_16),
        const Text('Disabled / error'),
        const SizedBox(height: DlSpacingTokens.p_8),
        const DlInput(
          placeholder: 'Disabled error input',
          type: DlInputType.error,
          enabled: false,
          errorHelperText: 'This field has an error',
        ),
        const SizedBox(height: DlSpacingTokens.p_16),
        const Text('Disabled / success'),
        const SizedBox(height: DlSpacingTokens.p_8),
        const DlInput(
          placeholder: 'Disabled success input',
          type: DlInputType.success,
          enabled: false,
        ),
      ],
    );
  }

  Widget _buildSearchFieldSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        Text('DlSearchField examples'),
        SizedBox(height: DlSpacingTokens.p_16),
        Text('Default'),
        SizedBox(height: DlSpacingTokens.p_8),
        DlSearchField(placeholder: 'Search...'),
        SizedBox(height: DlSpacingTokens.p_16),
        Text('Size md'),
        SizedBox(height: DlSpacingTokens.p_8),
        DlSearchField(placeholder: 'Search md...', size: DlSearchFieldSize.md),
        SizedBox(height: DlSpacingTokens.p_16),
        Text('Size sm'),
        SizedBox(height: DlSpacingTokens.p_8),
        DlSearchField(placeholder: 'Search sm...', size: DlSearchFieldSize.sm),
        SizedBox(height: DlSpacingTokens.p_16),
        Text('Type to show clear icon'),
        SizedBox(height: DlSpacingTokens.p_8),
        DlSearchField(placeholder: 'Type at least 1 character'),
        SizedBox(height: DlSpacingTokens.p_16),
        Text('Long placeholder'),
        SizedBox(height: DlSpacingTokens.p_8),
        DlSearchField(
          placeholder:
              'This is a long search placeholder text to test one-line ellipsis behavior.',
        ),
        SizedBox(height: DlSpacingTokens.p_16),
        Text('Disabled'),
        SizedBox(height: DlSpacingTokens.p_8),
        DlSearchField(placeholder: 'Search disabled', enabled: false),
      ],
    );
  }

  Widget _buildTextareaSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        Text('DlTextarea examples'),
        SizedBox(height: DlSpacingTokens.p_16),
        Text('Default'),
        SizedBox(height: DlSpacingTokens.p_8),
        DlTextarea(placeholder: 'Write your message...'),
        SizedBox(height: DlSpacingTokens.p_16),
        Text('Long placeholder'),
        SizedBox(height: DlSpacingTokens.p_8),
        DlTextarea(
          placeholder:
              'This is a long textarea placeholder to test line wrapping and typing behavior.',
        ),
        SizedBox(height: DlSpacingTokens.p_16),
        Text('Disabled'),
        SizedBox(height: DlSpacingTokens.p_8),
        DlTextarea(placeholder: 'Disabled textarea', enabled: false),
      ],
    );
  }

  Widget _buildOtpInputSection() {
    return Column(
      children: [
        const Text('DlOTPInput examples'),
        const SizedBox(height: DlSpacingTokens.p_16),
        const Text('Size lg'),
        const SizedBox(height: DlSpacingTokens.p_8),
        const Wrap(
          alignment: WrapAlignment.center,
          spacing: DlSpacingTokens.p_16,
          runSpacing: DlSpacingTokens.p_16,
          children: [
            DlOTPInput(size: DlOtpInputSize.lg),
            DlOTPInput(size: DlOtpInputSize.lg, state: DlOtpInputState.error),
            DlOTPInput(size: DlOtpInputSize.lg, state: DlOtpInputState.success),
            DlOTPInput(
              size: DlOtpInputSize.lg,
              state: DlOtpInputState.disabled,
            ),
          ],
        ),
        const SizedBox(height: DlSpacingTokens.p_16),
        const Text('Size md'),
        const SizedBox(height: DlSpacingTokens.p_8),
        const Wrap(
          alignment: WrapAlignment.center,
          spacing: DlSpacingTokens.p_16,
          runSpacing: DlSpacingTokens.p_16,
          children: [
            DlOTPInput(size: DlOtpInputSize.md),
            DlOTPInput(size: DlOtpInputSize.md, state: DlOtpInputState.error),
            DlOTPInput(size: DlOtpInputSize.md, state: DlOtpInputState.success),
            DlOTPInput(
              size: DlOtpInputSize.md,
              state: DlOtpInputState.disabled,
            ),
          ],
        ),
        const SizedBox(height: DlSpacingTokens.p_16),
        const Text('Size sm'),
        const SizedBox(height: DlSpacingTokens.p_8),
        const Wrap(
          alignment: WrapAlignment.center,
          spacing: DlSpacingTokens.p_16,
          runSpacing: DlSpacingTokens.p_16,
          children: [
            DlOTPInput(size: DlOtpInputSize.sm),
            DlOTPInput(size: DlOtpInputSize.sm, state: DlOtpInputState.error),
            DlOTPInput(size: DlOtpInputSize.sm, state: DlOtpInputState.success),
            DlOTPInput(
              size: DlOtpInputSize.sm,
              state: DlOtpInputState.disabled,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSwitchSection() {
    return Column(
      children: [
        const Text('DlSwitch examples'),
        const SizedBox(height: DlSpacingTokens.p_16),
        const DlSwitch(),
      ],
    );
  }

  Widget _buildTagSection() {
    return Column(
      children: [
        const Text('DlTag examples'),
        const SizedBox(height: DlSpacingTokens.p_16),
        const Wrap(
          alignment: WrapAlignment.center,
          spacing: DlSpacingTokens.p_16,
          runSpacing: DlSpacingTokens.p_16,
          children: [
            DlTag(label: 'Tag lg', size: DlTagSize.lg),
            DlTag(label: 'Tag md', size: DlTagSize.md),
            DlTag(label: 'Tag sm', size: DlTagSize.sm),
            DlTag(label: 'Tag / left icon', iconLeft: DlPlaceholderIcon()),
            DlTag(label: 'Tag / right icon', iconRight: DlPlaceholderIcon()),
            DlTag(
              label: 'Tag / left + right',
              iconLeft: DlPlaceholderIcon(),
              iconRight: DlPlaceholderIcon(),
            ),
            DlTag(
              label: 'Tag md / left icon',
              size: DlTagSize.md,
              iconLeft: DlPlaceholderIcon(),
            ),
            DlTag(
              label: 'Tag md / right icon',
              size: DlTagSize.md,
              iconRight: DlPlaceholderIcon(),
            ),
            DlTag(
              label: 'Tag sm / left + right',
              size: DlTagSize.sm,
              iconLeft: DlPlaceholderIcon(),
              iconRight: DlPlaceholderIcon(),
            ),
            DlTag(label: 'Tag dark', mode: DlTagMode.dark),
            DlTag(
              label: 'Tag dark / icons',
              mode: DlTagMode.dark,
              iconLeft: DlPlaceholderIcon(),
              iconRight: DlPlaceholderIcon(),
            ),
            DlTag(
              label: 'Tag dark / md',
              mode: DlTagMode.dark,
              size: DlTagSize.md,
              iconLeft: DlPlaceholderIcon(),
            ),
            DlTag(
              label: 'Tag dark / sm',
              mode: DlTagMode.dark,
              size: DlTagSize.sm,
              iconRight: DlPlaceholderIcon(),
            ),
            DlTag(
              label: 'Warning light',
              type: DlTagType.warning,
              iconLeft: DlPlaceholderIcon(),
            ),
            DlTag(
              label: 'Warning dark',
              type: DlTagType.warning,
              mode: DlTagMode.dark,
              iconLeft: DlPlaceholderIcon(),
              iconRight: DlPlaceholderIcon(),
            ),
            DlTag(
              label: 'Error light',
              type: DlTagType.error,
              iconLeft: DlPlaceholderIcon(),
            ),
            DlTag(
              label: 'Error dark',
              type: DlTagType.error,
              mode: DlTagMode.dark,
              iconLeft: DlPlaceholderIcon(),
              iconRight: DlPlaceholderIcon(),
            ),
            DlTag(
              label: 'Success light',
              type: DlTagType.success,
              iconLeft: DlPlaceholderIcon(),
            ),
            DlTag(
              label: 'Success dark',
              type: DlTagType.success,
              mode: DlTagMode.dark,
              iconLeft: DlPlaceholderIcon(),
              iconRight: DlPlaceholderIcon(),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTopNavigationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        Text('DlTopNavigation examples'),
        SizedBox(height: DlSpacingTokens.p_16),
        Text('Size md'),
        SizedBox(height: DlSpacingTokens.p_8),
        DlTopNavigation(
          title: 'Navigation title',
          iconLeft: DlPlaceholderIcon(),
          iconRight: DlPlaceholderIcon(),
        ),
        SizedBox(height: DlSpacingTokens.p_16),
        Text('Size lg'),
        SizedBox(height: DlSpacingTokens.p_8),
        DlTopNavigation(
          title: 'Large navigation title',
          size: DlTopNavigationSize.lg,
          iconLeft: DlPlaceholderIcon(),
          iconRight: DlPlaceholderIcon(),
        ),
        SizedBox(height: DlSpacingTokens.p_16),
        DlTopNavigation(
          title: 'Navigation without icons',
          showSeparator: false,
        ),
      ],
    );
  }

  Widget _buildTopNavigationMessageSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        Text('DlTopNavigationMessage examples'),
        SizedBox(height: DlSpacingTokens.p_16),
        DlTopNavigationMessage(
          title: 'Messages',
          avatar: DlAvatar(
            size: DlAvatarSize.xs,
            type: DlAvatarType.initials,
            initials: 'DL',
          ),
          iconLeft: DlPlaceholderIcon(),
          iconRight: DlPlaceholderIcon(),
        ),
        SizedBox(height: DlSpacingTokens.p_16),
        DlTopNavigationMessage(
          title: 'Messages without separator',
          avatar: DlAvatar(size: DlAvatarSize.xs),
          showSeparator: false,
        ),
      ],
    );
  }

  Widget _buildMessageDockSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        Text('DlMessageDock examples'),
        SizedBox(height: DlSpacingTokens.p_16),
        DlMessageDock(placeholder: 'Type a message...'),
        SizedBox(height: DlSpacingTokens.p_16),
        DlMessageDock(placeholder: 'Without separator', showSeparator: false),
      ],
    );
  }

  Widget _buildMessageLoadingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        Text('DlMessageLoading examples'),
        SizedBox(height: DlSpacingTokens.p_16),
        Align(alignment: Alignment.centerLeft, child: DlMessageLoading()),
      ],
    );
  }

  Widget _buildLoadingDotsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        Text('DlLoadingDots examples'),
        SizedBox(height: DlSpacingTokens.p_16),
        Align(alignment: Alignment.centerLeft, child: DlLoadingDots()),
      ],
    );
  }

  Widget _buildSnackbarSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        Text('DlSnackbar examples'),
        SizedBox(height: DlSpacingTokens.p_16),
        DlSnackbar(label: 'Saved successfully', type: DlSnackbarType.success),
        SizedBox(height: DlSpacingTokens.p_16),
        DlSnackbar(label: 'Something went wrong', type: DlSnackbarType.error),
        SizedBox(height: DlSpacingTokens.p_16),
        DlSnackbar(
          label: 'Please review this warning',
          type: DlSnackbarType.warning,
        ),
        SizedBox(height: DlSpacingTokens.p_16),
        DlSnackbar(
          label: 'New information available',
          type: DlSnackbarType.information,
        ),
        SizedBox(height: DlSpacingTokens.p_16),
        DlSnackbar(
          label: 'Very long snackbar message that should truncate in one line.',
        ),
      ],
    );
  }

  Widget _buildSkeletonSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        Text('DlSkeleton examples'),
        SizedBox(height: DlSpacingTokens.p_16),
        DlSkeleton(height: 16),
        SizedBox(height: DlSpacingTokens.p_16),
        DlSkeleton(width: 220, height: 24, rounded: DlRadiusTokens.roundedMd),
        SizedBox(height: DlSpacingTokens.p_16),
        DlSkeleton(width: 120, height: 40, rounded: DlRadiusTokens.roundedFull),
        SizedBox(height: DlSpacingTokens.p_16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DlSkeleton(
              width: 56,
              height: 56,
              rounded: DlRadiusTokens.roundedFull,
            ),
            SizedBox(width: DlSpacingTokens.p_16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DlSkeleton(height: 20, rounded: DlRadiusTokens.roundedFull),
                  SizedBox(height: DlSpacingTokens.p_16),
                  FractionallySizedBox(
                    widthFactor: 0.6,
                    alignment: Alignment.centerLeft,
                    child: DlSkeleton(
                      height: 20,
                      rounded: DlRadiusTokens.roundedFull,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSliderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        Text('DlSlider examples'),
        SizedBox(height: DlSpacingTokens.p_16),
        DlSlider(),
        SizedBox(height: DlSpacingTokens.p_16),
        DlSlider(initialValue: 0.5),
      ],
    );
  }

  Widget _buildProgressSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        Text('DlProgress examples'),
        SizedBox(height: DlSpacingTokens.p_16),
        DlProgress(value: 20),
        SizedBox(height: DlSpacingTokens.p_16),
        DlProgress(value: 50),
        SizedBox(height: DlSpacingTokens.p_16),
        DlProgress(value: 85),
      ],
    );
  }

  Widget _buildSegmentedControlSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('DlSegmentedControl examples'),
        const SizedBox(height: DlSpacingTokens.p_16),
        DlSegmentedControl(
          tabs: const [
            DlSegmentedControlTab(
              label: 'One',
              badge: DlBadge(size: DlBadgeSize.sm),
            ),
            DlSegmentedControlTab(label: 'Two'),
            DlSegmentedControlTab(label: 'Three'),
          ],
        ),
        const SizedBox(height: DlSpacingTokens.p_16),
        DlSegmentedControl(
          tabs: const [
            DlSegmentedControlTab(label: 'Profile'),
            DlSegmentedControlTab(
              label: 'Billing',
              state: DlSegmentedControlTabState.disabled,
            ),
            DlSegmentedControlTab(label: 'Security'),
          ],
        ),
      ],
    );
  }

  Widget _buildTabControlSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('DlTabControl examples'),
        const SizedBox(height: DlSpacingTokens.p_16),
        const Text('Count 3 / labels'),
        const SizedBox(height: DlSpacingTokens.p_8),
        DlTabControl(
          tabs: const [
            DlTabControlTab(label: 'Overview'),
            DlTabControlTab(label: 'Details'),
            DlTabControlTab(label: 'Activity'),
          ],
        ),
        const SizedBox(height: DlSpacingTokens.p_16),
        const Text('Count 4 / with badges'),
        const SizedBox(height: DlSpacingTokens.p_8),
        DlTabControl(
          tabs: const [
            DlTabControlTab(
              label: 'All',
              badge: DlBadge(size: DlBadgeSize.sm),
            ),
            DlTabControlTab(
              label: 'Open',
              badge: DlBadge(size: DlBadgeSize.md, value: '8'),
            ),
            DlTabControlTab(label: 'Done'),
            DlTabControlTab(
              label: 'Archived',
              badge: DlBadge(size: DlBadgeSize.md, value: '2'),
            ),
          ],
        ),
        const SizedBox(height: DlSpacingTokens.p_16),
        const Text('Count 3 / with disabled tab'),
        const SizedBox(height: DlSpacingTokens.p_8),
        DlTabControl(
          tabs: const [
            DlTabControlTab(label: 'Profile'),
            DlTabControlTab(
              label: 'Billing',
              state: DlTabControlTabState.disabled,
            ),
            DlTabControlTab(label: 'Security'),
          ],
        ),
        const SizedBox(height: DlSpacingTokens.p_16),
        const Text('Count 2 / simple tabs'),
        const SizedBox(height: DlSpacingTokens.p_8),
        DlTabControl(
          tabs: const [
            DlTabControlTab(label: 'Tab 1'),
            DlTabControlTab(label: 'Tab 2'),
          ],
        ),
      ],
    );
  }

  Widget _buildPaginationSection() {
    return Column(
      children: [
        const Text('DlPagination examples'),
        const SizedBox(height: DlSpacingTokens.p_16),
        const DlPagination(count: 4),
        const SizedBox(height: DlSpacingTokens.p_16),
        const DlPagination(count: 6, initialIndex: 2),
      ],
    );
  }

  Widget _buildPinKeyboardSection() {
    return Column(
      children: [
        const Text('DlPinKeyboard examples'),
        const SizedBox(height: DlSpacingTokens.p_16),
        const Wrap(
          alignment: WrapAlignment.center,
          spacing: DlSpacingTokens.p_16,
          runSpacing: DlSpacingTokens.p_16,
          children: [
            DlPinKeyboard(number: '1', alphabet: 'ABC'),
            DlPinKeyboard(number: '2', alphabet: 'DEF'),
            DlPinKeyboard(number: '3'),
            DlPinKeyboard(number: '4', state: DlPinKeyboardState.pressed),
            DlPinKeyboard(type: DlPinKeyboardType.icon),
            DlPinKeyboard(
              type: DlPinKeyboardType.icon,
              state: DlPinKeyboardState.pressed,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTooltipSection() {
    return Column(
      children: const [
        Text('DlTooltip examples'),
        SizedBox(height: DlSpacingTokens.p_16),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: DlSpacingTokens.p_16,
          runSpacing: DlSpacingTokens.p_16,
          children: [
            DlTooltip(label: 'Bottom', direction: DlTooltipDirection.bottom),
            DlTooltip(label: 'Top', direction: DlTooltipDirection.top),
            DlTooltip(label: 'Left', direction: DlTooltipDirection.left),
            DlTooltip(label: 'Right', direction: DlTooltipDirection.right),
          ],
        ),
      ],
    );
  }

  Widget _buildButtonDockSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('DlButtonDock examples'),
        const SizedBox(height: DlSpacingTokens.p_16),
        const Text('Horizontal / 1 button / separator on'),
        const SizedBox(height: DlSpacingTokens.p_8),
        DlButtonDock(
          buttons: [
            DlButton(
              label: 'Single Button',
              type: DlButtonType.primary,
              onPressed: () {},
            ),
          ],
          direction: Axis.horizontal,
          showSeparator: true,
        ),
        const SizedBox(height: DlSpacingTokens.p_16),
        const Text('Horizontal / 2 buttons / separator on'),
        const SizedBox(height: DlSpacingTokens.p_8),
        DlButtonDock(
          buttons: [
            DlButton(label: 'Button', onPressed: () {}),
            DlButton(
              label: 'Button',
              type: DlButtonType.secondary,
              onPressed: () {},
            ),
          ],
          direction: Axis.horizontal,
        ),
        const SizedBox(height: DlSpacingTokens.p_16),
        const Text('Vertical / 2 buttons / separator on'),
        const SizedBox(height: DlSpacingTokens.p_8),
        DlButtonDock(
          buttons: [
            DlButton(label: 'Button', onPressed: () {}),
            DlButton(
              label: 'Button',
              type: DlButtonType.secondary,
              onPressed: () {},
            ),
          ],
          direction: Axis.vertical,
          showSeparator: true,
        ),
        const SizedBox(height: DlSpacingTokens.p_16),
        const Text('Vertical / 2 buttons / separator off'),
        const SizedBox(height: DlSpacingTokens.p_8),
        DlButtonDock(
          buttons: [
            DlButton(
              label: 'Button',
              type: DlButtonType.primary,
              onPressed: () {},
            ),
            DlButton(
              label: 'Button',
              type: DlButtonType.secondary,
              onPressed: () {},
            ),
          ],
          direction: Axis.vertical,
          showSeparator: false,
        ),
      ],
    );
  }
}
