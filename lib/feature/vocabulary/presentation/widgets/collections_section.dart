import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slovo/core/assets/app_assets.dart';
import 'package:slovo/core/theme/_.dart';
import 'package:slovo/core/theme/color_x.dart';
import 'package:slovo/feature/vocabulary/di/collection_provider.dart';
import 'package:slovo/feature/vocabulary/domain/models/collection.dart';
import 'package:slovo/feature/vocabulary/presentation/extensions/collection_color_x.dart';
import 'package:slovo/feature/vocabulary/presentation/extensions/collection_icon_x.dart';
import 'package:slovo/shared/widgets/_.dart';

class CollectionsSection extends ConsumerWidget {
  const CollectionsSection({super.key});

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
          ? AppIcon(
        path: AppAssets.checkCircle,
        color: context.colors.primary,
        size: 34,
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