import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:slovo/app/router/app_routes.dart';
import 'package:slovo/core/theme/_.dart';
import 'package:slovo/feature/vocabulary/domain/models/collection.dart';
import 'package:slovo/feature/vocabulary/presentation/mock_vocabulary_data.dart';
import 'package:slovo/feature/vocabulary/presentation/widgets/_.dart';
import 'package:slovo/shared/widgets/_.dart';

class VocabularyScreen extends StatefulWidget {
  const VocabularyScreen({super.key});

  @override
  State<VocabularyScreen> createState() => _VocabularyScreenState();
}

class _VocabularyScreenState extends State<VocabularyScreen> {
  int _tabIndex = 0;
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(
      () => setState(() => _query = _searchController.text.toLowerCase()),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colors.surfaceSubtle,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Header(onNew: () => context.push(AppRoutes.createCollectionPath)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: SegmentedControl(
                tabs: ['Mine (${mockCollections.length})', 'Discover'],
                selectedIndex: _tabIndex,
                onChanged: (i) => setState(() => _tabIndex = i),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: _SearchBar(controller: _searchController),
            ),
            const SizedBox(height: AppSpacing.sm),
            Expanded(
              child: _tabIndex == 0
                  ? Builder(
                      builder: (context) {
                        final filtered = _query.isEmpty
                            ? mockCollections
                            : mockCollections
                                .where((c) => c.title
                                    .toLowerCase()
                                    .contains(_query))
                                .toList();
                        if (filtered.isEmpty) {
                          return Center(
                            child: Text(
                              _query.isEmpty
                                  ? 'No collections yet'
                                  : 'No results for "$_query"',
                              style: tt.bodyMedium
                                  ?.copyWith(color: colors.textSecondary),
                            ),
                          );
                        }
                        return ListView.separated(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.md,
                            vertical: AppSpacing.xs,
                          ),
                          itemCount: filtered.length,
                          separatorBuilder: (context, i) =>
                              const SizedBox(height: AppSpacing.xs),
                          itemBuilder: (context, i) =>
                              _CollectionTile(collection: filtered[i]),
                        );
                      },
                    )
                  : Center(
                      child: Text(
                        'Coming soon',
                        style:
                            tt.bodyMedium?.copyWith(color: colors.textSecondary),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.onNew});

  final VoidCallback onNew;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final tt = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.md,
      ),
      child: Row(
        children: [
          Text('Library', style: tt.headlineMedium),
          const Spacer(),
          FilledButton.icon(
            onPressed: onNew,
            icon: const Icon(Icons.add, size: 18),
            label: const Text('New'),
            style: FilledButton.styleFrom(
              backgroundColor: colors.primary,
              foregroundColor: colors.textOnBrand,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              textStyle: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(fontWeight: FontWeight.w600),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return TextField(
      controller: controller,
      style: Theme.of(context).textTheme.bodyMedium,
      decoration: InputDecoration(
        hintText: 'Search your collections...',
        hintStyle: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: colors.textMuted),
        prefixIcon: Icon(Icons.search_rounded, color: colors.textMuted, size: 20),
        filled: true,
        fillColor: colors.surface,
        contentPadding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: BorderSide(color: colors.outline, width: 1.5),
        ),
      ),
    );
  }
}

class _CollectionTile extends StatelessWidget {
  const _CollectionTile({required this.collection});

  final Collection collection;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final tt = Theme.of(context).textTheme;
    final accent = collection.color.value;
    final progress = collection.masteryFraction;
    final percent = (progress * 100).round();

    return Material(
      color: colors.surface,
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.md),
        onTap: () => context.pushNamed(
          AppRoutes.collectionDetail.name,
          pathParameters: {'collectionId': collection.id},
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.md,
          ),
          child: Row(
            children: [
              _CollectionIcon(color: accent),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      collection.title,
                      style: tt.titleSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${collection.wordCount} ${collection.wordCount == 1 ? 'word' : 'words'} · $percent%',
                      style: tt.bodySmall
                          ?.copyWith(color: colors.textSecondary),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              ArcProgress(
                value: progress,
                color: accent,
                size: 36,
                strokeWidth: 3.5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CollectionIcon extends StatelessWidget {
  const _CollectionIcon({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return IconAvatar(
      backgroundColor: color.withAlpha(26),
      icon: Icon(Icons.layers_rounded, color: color, size: 22),
    );
  }
}
