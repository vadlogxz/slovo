import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:slovo/core/theme/_.dart';
import 'package:slovo/feature/auth/di/auth_provider.dart';
import 'package:slovo/feature/vocabulary/di/collection_provider.dart';
import 'package:slovo/feature/vocabulary/domain/models/collection_color.dart';
import 'package:slovo/feature/vocabulary/domain/models/collection_icon.dart';
import 'package:slovo/feature/vocabulary/presentation/collection_color_x.dart';
import 'package:slovo/feature/vocabulary/presentation/collection_icon_x.dart';
import 'package:slovo/shared/widgets/_.dart';

class CreateCollectionScreen extends ConsumerStatefulWidget {
  const CreateCollectionScreen({super.key});

  @override
  ConsumerState<CreateCollectionScreen> createState() =>
      _CreateCollectionScreenState();
}

class _CreateCollectionScreenState
    extends ConsumerState<CreateCollectionScreen> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  CollectionIcon selectedIcon = CollectionIcon.none;
  CollectionColor selectedColor = CollectionColor.purple;
  bool isSubmitting = false;

  @override
  void initState() {
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void submitForm() async {
    try {
      setState(() {
        isSubmitting = true;
      });
      if (_formKey.currentState!.validate()) {
        final userId = ref.read(currentUserIdProvider);
        if (userId != null) {
          await ref.read(collectionRepositoryProvider).createCollection(
            userId: userId,
            title: _nameController.text,
            icon: selectedIcon,
            color: selectedColor,
            description: _descriptionController.text,
          );
        } else {
          throw Exception('User not logged in');
        }
        if (!mounted) return;
        context.pop();
      }
      setState(() {
        isSubmitting = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        isSubmitting = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error creating collection: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme tt = Theme
        .of(context)
        .textTheme;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton.filled(
          onPressed: () => context.pop(),
          icon: Icon(Icons.arrow_back_ios_new, color: context.colors.textMuted),
          style: IconButton.styleFrom(
            backgroundColor: context.colors.textOnBrand,
            foregroundColor: context.colors.textMuted,
            shape: CircleBorder(
              side: BorderSide(color: context.colors.outline),
            ),
            shadowColor: context.colors.shadow,
          ),
        ),
        title: Text(
          'Create Collection',
          style: tt.titleLarge?.copyWith(fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.md),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Collection name
                    Text('Collection name', style: tt.titleLarge),
                    SizedBox(height: AppSpacing.sm),
                    TextFormField(
                      controller: _nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a collection name';
                        }
                        return null;
                      },
                      style: tt.bodyLarge,
                      decoration: InputDecoration(
                        hintText: 'Enter collection name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(color: context.colors.outline),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.clear,
                              color: context.colors.textMuted),
                        ),
                      ),
                    ),

                    SizedBox(height: AppSpacing.md),

                    // Select icon
                    Text('Icon', style: tt.titleLarge),
                    SizedBox(height: AppSpacing.sm),
                    SizedBox(
                      height: 120,
                      child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: AppSpacing.sm,
                          crossAxisSpacing: AppSpacing.sm,
                        ),
                        itemCount: CollectionIcon.values.length,
                        itemBuilder: (context, i) =>
                            _IconItem(
                              iconPath: CollectionIcon.values[i].asset,
                              isSelected: selectedIcon ==
                                  CollectionIcon.values[i],
                              onTap: () {
                                setState(() {
                                  selectedIcon = CollectionIcon.values[i];
                                });
                              },
                            ),
                      ),
                    ),
                    SizedBox(height: AppSpacing.md),

                    // Choose color
                    Text('Color', style: tt.titleLarge),
                    SizedBox(height: AppSpacing.sm),
                    SizedBox(
                      height: 60,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: CollectionColor.values.length,
                        separatorBuilder: (context, i) =>
                            SizedBox(width: AppSpacing.sm),
                        itemBuilder: (context, i) =>
                            _ColorItem(
                              color: CollectionColor.values[i].color,
                              isSelected: selectedColor ==
                                  CollectionColor.values[i],
                              onTap: () {
                                setState(() {
                                  selectedColor = CollectionColor.values[i];
                                });
                              },
                            ),
                      ),
                    ),
                    SizedBox(height: AppSpacing.md),

                    // Description
                    Text('Description', style: tt.titleLarge),
                    SizedBox(height: AppSpacing.sm),
                    TextFormField(
                      controller: _descriptionController,
                      style: tt.bodyLarge,
                      maxLength: 120,
                      maxLines: 4,
                      buildCounter: (context,
                          {required currentLength, maxLength, required isFocused}) =>
                          Text(
                            '$currentLength/$maxLength',
                            style: tt.bodySmall,
                          ),
                      decoration: InputDecoration(
                        hintText: 'Enter collection description',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(color: context.colors.outline),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              AppButton(
                text: 'Create Collection',
                isLoading: isSubmitting,
                isDisabled: isSubmitting,
                onTap: isSubmitting ? null : submitForm,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IconItem extends StatelessWidget {
  const _IconItem({
    required this.iconPath,
    required this.isSelected,
    required this.onTap,
  });

  final String iconPath;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: isSelected
              ? context.colors.primary
              : context.colors.textOnBrand,
          border: Border.all(color: context.colors.outline),
          borderRadius: BorderRadius.all(Radius.circular(AppSpacing.md)),
        ),
        child: AppIcon(
          path: iconPath,
          color: isSelected
              ? context.colors.textOnBrand
              : context.colors.textMuted,
          size: 48,
        ),
      ),
    );
  }
}

class _ColorItem extends StatelessWidget {
  const _ColorItem({
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    double width = 60;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Container(
            width: width - 7,
            padding: EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: color,
              border: Border.all(
                  color: isSelected ? context.colors.surface : Colors
                      .transparent, width: 4),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
