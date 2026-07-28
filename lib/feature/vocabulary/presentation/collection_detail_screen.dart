import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:slovo/app/router/app_routes.dart';
import 'package:slovo/core/assets/app_assets.dart';
import 'package:slovo/core/theme/_.dart';
import 'package:slovo/feature/vocabulary/domain/models/collection.dart';
import 'package:slovo/feature/vocabulary/domain/models/word.dart';
import 'package:slovo/feature/vocabulary/presentation/mock_vocabulary_data.dart';
import 'package:slovo/feature/vocabulary/presentation/widgets/_.dart';
import 'package:slovo/shared/widgets/_.dart';

class CollectionDetailScreen extends StatefulWidget {
  const CollectionDetailScreen({
    super.key,
    required this.collectionId,
    this.lastAddedWordTitle,
    this.lastAddedWordId,
  });

  final String collectionId;
  final String? lastAddedWordTitle;
  final String? lastAddedWordId;

  @override
  State<CollectionDetailScreen> createState() =>
      _CollectionDetailScreenState();
}

class _CollectionDetailScreenState extends State<CollectionDetailScreen> {
  bool _showBanner = false;
  Timer? _bannerTimer;
  late List<Word> _words;

  @override
  void initState() {
    super.initState();
    _words = List.of(wordsOf(widget.collectionId));
    if (widget.lastAddedWordTitle != null) {
      _showBanner = true;
      _bannerTimer = Timer(const Duration(seconds: 3), () {
        if (mounted) setState(() => _showBanner = false);
      });
    }
  }

  @override
  void dispose() {
    _bannerTimer?.cancel();
    super.dispose();
  }

  void _removeWord(String wordId) {
    setState(() => _words.removeWhere((w) => w.id == wordId));
  }

  @override
  Widget build(BuildContext context) {
    final collection = collectionById(widget.collectionId);
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.surfaceSubtle,
      body: SafeArea(
        child: Column(
          children: [
            _CollectionHeader(collection: collection),
            Expanded(
              child: _words.isEmpty
                  ? _EmptyState(collectionId: widget.collectionId)
                  : _WordsState(
                      collectionId: widget.collectionId,
                      collection: collection,
                      words: _words,
                      onDeleteWord: _removeWord,
                      showBanner: _showBanner,
                      lastAddedWordTitle: widget.lastAddedWordTitle,
                      lastAddedWordId: widget.lastAddedWordId,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Swipe-to-delete ──────────────────────────────────────────────────────────

class _DismissibleWordItem extends StatelessWidget {
  const _DismissibleWordItem({
    required this.word,
    required this.collectionId,
    required this.isJustAdded,
    required this.onDeleted,
  });

  final Word word;
  final String collectionId;
  final bool isJustAdded;
  final ValueChanged<String> onDeleted;

  Future<bool> _confirmDelete(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => _DeleteWordDialog(term: word.term),
    );
    if (confirmed != true) return false;
    onDeleted(word.id);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Dismissible(
      key: ValueKey(word.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) => _confirmDelete(context),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        color: colors.error,
        child: Icon(
          Icons.delete_outline_rounded,
          color: colors.textOnBrand,
          size: 20,
        ),
      ),
      child: WordListItem(
        word: word,
        isJustAdded: isJustAdded,
        onTap: () => context.pushNamed(
          AppRoutes.wordDetail.name,
          pathParameters: {'collectionId': collectionId, 'wordId': word.id},
        ),
      ),
    );
  }
}

class _DeleteWordDialog extends StatelessWidget {
  const _DeleteWordDialog({required this.term});

  final String term;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final tt = Theme.of(context).textTheme;

    return Dialog(
      backgroundColor: colors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Delete "$term"?', style: tt.titleMedium),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'This removes it from the collection. This can\'t be undone.',
              style: tt.bodyMedium?.copyWith(color: colors.textSecondary),
            ),
            const SizedBox(height: AppSpacing.lg),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(
                    'Cancel',
                    style: tt.labelLarge?.copyWith(color: colors.textSecondary),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text(
                    'Delete',
                    style: tt.labelLarge?.copyWith(color: colors.error),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ── Header ────────────────────────────────────────────────────────────────────

class _CollectionHeader extends StatelessWidget {
  const _CollectionHeader({required this.collection});

  final Collection? collection;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final colors = context.colors;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          HeaderIconButton(
            icon: Icons.chevron_left_rounded,
            onTap: () => context.pop(),
            size: 22,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(collection?.title ?? '', style: tt.titleMedium),
                if (collection != null)
                  Text(
                    '${collection!.wordCount} '
                    '${collection!.wordCount == 1 ? 'word' : 'words'} · '
                    '${collection!.isPublic ? 'public' : 'private'}',
                    style: tt.bodySmall?.copyWith(color: colors.textSecondary),
                  ),
              ],
            ),
          ),
          HeaderIconButton(icon: Icons.more_horiz_rounded, onTap: () {}),
        ],
      ),
    );
  }
}

// ── Empty state ───────────────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.collectionId});

  final String collectionId;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final colors = context.colors;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: Column(
        children: [
          const Spacer(),
          IconAvatar(
            size: 72,
            radius: AppRadius.lg,
            backgroundColor: colors.primary12,
            icon: AppIcon(
              path: AppAssets.appLogo,
              size: 32,
              color: colors.primary,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text('No words yet', style: tt.titleLarge),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Add the German words you want to learn. Verba fills in the grammar for you.',
            style: tt.bodyMedium?.copyWith(color: colors.textSecondary),
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          AppButton(
            onTap: () => showAddWordSheet(context, collectionId: collectionId),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add_rounded, size: 18, color: colors.textOnBrand),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  'Add a word',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: colors.textOnBrand,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
        ],
      ),
    );
  }
}

// ── Words state ───────────────────────────────────────────────────────────────

class _WordsState extends StatelessWidget {
  const _WordsState({
    required this.collectionId,
    required this.collection,
    required this.words,
    required this.onDeleteWord,
    required this.showBanner,
    required this.lastAddedWordTitle,
    required this.lastAddedWordId,
  });

  final String collectionId;
  final Collection? collection;
  final List<Word> words;
  final ValueChanged<String> onDeleteWord;
  final bool showBanner;
  final String? lastAddedWordTitle;
  final String? lastAddedWordId;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final colors = context.colors;

    return Column(
      children: [
        if (collection != null) _ProgressSummary(collection: collection!),
        AnimatedSize(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          child: showBanner && lastAddedWordTitle != null
              ? Container(
                  margin: const EdgeInsets.fromLTRB(
                    AppSpacing.md,
                    AppSpacing.xs,
                    AppSpacing.md,
                    0,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm + 2,
                  ),
                  decoration: BoxDecoration(
                    color: colors.primary,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_rounded,
                        color: colors.textOnBrand,
                        size: 18,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        'Added "$lastAddedWordTitle"',
                        style: tt.labelLarge?.copyWith(
                          color: colors.textOnBrand,
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              AppSpacing.md,
              AppSpacing.md,
              0,
            ),
            itemCount: words.length + 1,
            separatorBuilder: (_, index) => index == 0
                ? const SizedBox.shrink()
                : Divider(height: 1, color: colors.outline),
            itemBuilder: (context, index) {
              if (index == 0) {
                return _WordsHeader(
                  count: words.length,
                  onAddAnother: () =>
                      showAddWordSheet(context, collectionId: collectionId),
                );
              }
              final word = words[index - 1];
              return _DismissibleWordItem(
                word: word,
                collectionId: collectionId,
                onDeleted: onDeleteWord,
                isJustAdded:
                    showBanner &&
                    lastAddedWordId != null &&
                    word.id == lastAddedWordId,
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.md,
            AppSpacing.md,
            AppSpacing.md,
            AppSpacing.lg,
          ),
          child: Column(
            children: [
              AppButton(
                onTap: () => context.pushNamed(
                  AppRoutes.learnSession.name,
                  pathParameters: {'collectionId': collectionId},
                ),
                text: 'Train these words',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Progress summary + share row ────────────────────────────────────────────

class _ProgressSummary extends StatelessWidget {
  const _ProgressSummary({required this.collection});

  final Collection collection;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final colors = context.colors;
    final percent = collection.masteryFraction;
    final dueCount = collection.wordCount - collection.wordsLearned;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.md,
        AppSpacing.md,
      ),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              ArcProgress(
                value: percent,
                color: colors.success,
                size: 56,
                strokeWidth: 5,
              ),
              Text(
                '${(percent * 100).round()}%',
                style: tt.labelMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${collection.wordCount} words · ${collection.wordsLearned} mastered',
                  style: tt.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 2),
                Text(
                  '$dueCount due for review today',
                  style: tt.bodyMedium?.copyWith(
                    color: colors.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WordsHeader extends StatelessWidget {
  const _WordsHeader({required this.count, required this.onAddAnother});

  final int count;
  final VoidCallback onAddAnother;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final colors = context.colors;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        children: [
          Text(
            'WORDS ($count)',
            style: tt.labelSmall?.copyWith(
              color: colors.textMuted,
              letterSpacing: 1.2,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: onAddAnother,
            child: Row(
              children: [
                Icon(Icons.add_rounded, size: 14, color: colors.primary),
                const SizedBox(width: 2),
                Text(
                  'Add another',
                  style: tt.labelMedium?.copyWith(color: colors.primary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
