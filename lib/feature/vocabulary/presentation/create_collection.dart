import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slovo/core/theme/_.dart';
import 'package:slovo/feature/auth/di/auth_provider.dart';
import 'package:slovo/feature/vocabulary/di/vocabulary_provider.dart';
import 'package:slovo/feature/vocabulary/domain/models/collection_color.dart';
import 'package:slovo/feature/vocabulary/presentation/widgets/_.dart';
import 'package:slovo/shared/widgets/_.dart';

enum _Visibility { private, sharedViaLink }

class CreateCollection extends ConsumerStatefulWidget {
  const CreateCollection({super.key});

  @override
  ConsumerState<CreateCollection> createState() => _CreateCollectionState();
}

class _CreateCollectionState extends ConsumerState<CreateCollection> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  CollectionColor _selectedColor = CollectionColor.violet;
  _Visibility _visibility = _Visibility.private;
  bool _isLoading = false;

  Future<void> _submit() async {
    final title = _nameController.text.trim();
    if (title.isEmpty) return;

    final userId = ref.read(currentUserIdProvider);
    if (userId == null) return;

    setState(() => _isLoading = true);
    try {
      await ref.read(collectionRepositoryProvider).createCollection(
            userId: userId,
            title: title,
            description: _descriptionController.text.trim().isEmpty
                ? null
                : _descriptionController.text.trim(),
            color: _selectedColor,
            isPublic: _visibility == _Visibility.sharedViaLink,
          );
      if (!mounted) return;
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Collection "$title" created'),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Failed to create collection. Please try again.'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: context.colors.error,
          duration: const Duration(seconds: 3),
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.surfaceSubtle,
      appBar: AppBar(
        backgroundColor: colors.surfaceSubtle,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.chevron_left_rounded, color: colors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('New collection', style: tt.titleMedium),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Cancel',
              style: tt.labelLarge?.copyWith(color: colors.primary),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionLabel('Name'),
                  const SizedBox(height: AppSpacing.xs),
                  _AppTextField(controller: _nameController, autofocus: true),
                  const SizedBox(height: AppSpacing.md),
                  _SectionLabel('Description (optional)'),
                  const SizedBox(height: AppSpacing.xs),
                  _AppTextField(controller: _descriptionController),
                  const SizedBox(height: AppSpacing.md),
                  _SectionLabel('Color'),
                  const SizedBox(height: AppSpacing.sm),
                  _ColorPicker(
                    selected: _selectedColor,
                    onSelected: (c) => setState(() => _selectedColor = c),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _SectionLabel('Visibility'),
                  const SizedBox(height: AppSpacing.sm),
                  _VisibilityPicker(
                    value: _visibility,
                    onChanged: (v) => setState(() => _visibility = v),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.sm,
              AppSpacing.lg,
              AppSpacing.lg,
            ),
            child: AppButton(
              onTap: _isLoading ? null : _submit,
              text: 'Create collection',
              isLoading: _isLoading,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Text(
      text,
      style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: colors.textSecondary,
          ),
    );
  }
}

class _AppTextField extends StatelessWidget {
  const _AppTextField({required this.controller, this.autofocus = false});

  final TextEditingController controller;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final colors = context.colors;

    return TextField(
      controller: controller,
      autofocus: autofocus,
      style: tt.bodyLarge,
      decoration: InputDecoration(
        filled: true,
        fillColor: colors.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: BorderSide(color: colors.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: BorderSide(color: colors.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: BorderSide(color: colors.primary, width: 1.5),
        ),
      ),
    );
  }
}

class _ColorPicker extends StatelessWidget {
  const _ColorPicker({required this.selected, required this.onSelected});

  final CollectionColor selected;
  final ValueChanged<CollectionColor> onSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: AppSpacing.sm,
      children: CollectionColor.values.map((c) {
        final isSelected = c == selected;
        return GestureDetector(
          onTap: () => onSelected(c),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(
                color: isSelected ? c.value : Colors.transparent,
                width: 3,
              ),
            ),
            child: Center(
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: c.value,
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: isSelected
                    ? Icon(
                        Icons.check_rounded,
                        color: context.colors.textOnBrand,
                        size: 20,
                      )
                    : null,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

typedef _VisibilityOptionData = ({
  _Visibility value,
  IconData icon,
  String title,
  String subtitle,
});

class _VisibilityPicker extends StatelessWidget {
  const _VisibilityPicker({required this.value, required this.onChanged});

  final _Visibility value;
  final ValueChanged<_Visibility> onChanged;

  static const _options = <_VisibilityOptionData>[
    (
      value: _Visibility.private,
      icon: Icons.lock_outline_rounded,
      title: 'Private',
      subtitle: 'Only you can see and edit it',
    ),
    (
      value: _Visibility.sharedViaLink,
      icon: Icons.share_outlined,
      title: 'Shared via link',
      subtitle: 'Anyone with the link can add it',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Column(
      children: [
        ...List.generate(_options.length, (i) {
          final item = _options[i];
          final isFirst = i == 0;
          final isLast = i == _options.length - 1;
          final side = BorderSide(color: colors.outline, width: 2);
          return Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: value == item.value ? colors.primary12 : Colors.transparent,
              border: Border(
                top: side,
                left: side,
                right: side,
                bottom: isLast ? side : BorderSide.none,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(isFirst ? AppRadius.md : 0),
                topRight: Radius.circular(isFirst ? AppRadius.md : 0),
                bottomLeft: Radius.circular(isLast ? AppRadius.md : 0),
                bottomRight: Radius.circular(isLast ? AppRadius.md : 0),
              ),
            ),
            child: _VisibilityOption(
              icon: item.icon,
              title: item.title,
              subtitle: item.subtitle,
              selected: value == item.value,
              onTap: () => onChanged(item.value),
            ),
          );
        }),
      ],
    );
  }
}

class _VisibilityOption extends StatelessWidget {
  const _VisibilityOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final colors = context.colors;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        children: [
          Icon(icon, size: 20, color: selected ? colors.primary : colors.textSecondary),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: tt.labelLarge),
                Text(
                  subtitle,
                  style: tt.bodySmall?.copyWith(color: colors.textSecondary),
                ),
              ],
            ),
          ),
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: selected ? colors.primary : colors.outline,
                width: 2,
              ),
            ),
            child: selected
                ? Center(
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: colors.primary,
                      ),
                    ),
                  )
                : null,
          ),
        ],
      ),
    );
  }
}