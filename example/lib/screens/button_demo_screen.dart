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
          const DlCard(
            icon: DlPlaceholderIcon(),
            title: 'md / title only',
          ),
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
