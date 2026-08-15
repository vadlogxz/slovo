import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slovo/core/theme/_.dart';
import 'package:slovo/core/theme/color_x.dart';
import 'package:slovo/feature/vocabulary/di/collection_provider.dart';
import 'package:slovo/feature/vocabulary/di/dictionary_entry_provider.dart';
import 'package:slovo/feature/vocabulary/domain/models/collection.dart';
import 'package:slovo/feature/vocabulary/presentation/collection_color_x.dart';
import 'package:slovo/feature/vocabulary/presentation/collection_icon_x.dart';
import 'package:slovo/shared/widgets/_.dart';

class AddWordSheet extends ConsumerStatefulWidget {
  const AddWordSheet({super.key});

  @override
  ConsumerState<AddWordSheet> createState() => _AddWordSheetState();
}

class _AddWordSheetState extends ConsumerState<AddWordSheet> {
  late TextEditingController _controller;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isSearching = false;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  'Add Word Sheet',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              TextFormField(
                controller: _controller,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a word';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hint: Text('Enter a word'),
                  hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      _controller.clear();
                    },
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),

              // User Collections
              _Collections(),

              const SizedBox(height: AppSpacing.md),
              AppButton(
                isDisabled: _isSearching,
                isLoading: _isSearching,
                onTap: () {
                  if (_formKey.currentState?.validate() == true) {
                    // final selected = ref.read(selectedCollectionsProvider);
                    final addWordProv = ref.read(addWordProvider.notifier);
                    addWordProv.search(_controller.text.trim());
                  }
                },
                text: 'Add Word',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Collections extends ConsumerWidget {
  const _Collections();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final collections = ref.watch(userCollectionsProvider);
    final selectedCollections = ref.watch(selectedCollectionsProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Add to collection',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        collections.when(
          data: (data) {
            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: data.length,
              separatorBuilder: (context, index) =>
                  const SizedBox(height: AppSpacing.xs),
              itemBuilder: (context, index) {
                final collection = data[index];
                return _CollectionItem(
                  collection: collection,
                  selected: selectedCollections.contains(collection),
                  onTap: () {
                    ref.read(selectedCollectionsProvider.notifier).update((
                      set,
                    ) {
                      final next = {...set};
                      next.contains(collection)
                          ? next.remove(collection)
                          : next.add(collection);
                      return next;
                    });
                  },
                );
              },
            );
          },
          error: (error, stackTrace) {
            return Text('Error loading collections: $error');
          },
          loading: () {
            return const CircularProgressIndicator();
          },
        ),
      ],
    );
  }
}

class _CollectionItem extends ConsumerWidget {
  const _CollectionItem({
    required this.collection,
    required this.onTap,
    required this.selected,
  });

  final Collection collection;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Text(
        collection.title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: Text(
        '${collection.wordCount} words',
        style: Theme.of(context).textTheme.bodySmall,
      ),
      leading: CircleAvatar(
        backgroundColor: collection.color.color.withValues(alpha: 0.13),
        child: AppIcon(
          path: collection.icon.asset,
          color: collection.color.color.contrastForeground,
        ),
      ),
      trailing: selected
          ? Icon(
              Icons.check_circle,
              color: Theme.of(context).colorScheme.primary,
            )
          : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
        side: BorderSide(
          color: selected ? context.colors.primary : Colors.transparent,
          width: 2,
        ),
      ),
      selected: selected,
      onTap: onTap,
    );
  }
}
