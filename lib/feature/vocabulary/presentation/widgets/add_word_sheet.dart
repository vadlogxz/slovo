import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slovo/core/error/repository_exception.dart';
import 'package:slovo/core/theme/_.dart';
import 'package:slovo/feature/vocabulary/di/add_word_notifier.dart';
import 'package:slovo/feature/vocabulary/di/vocabulary_provider.dart';
import 'package:slovo/feature/vocabulary/domain/models/dictionary_entry.dart';
import 'package:slovo/feature/vocabulary/domain/models/word.dart';
import 'package:slovo/shared/widgets/_.dart';

/// Opens the add-word bottom sheet. The sheet stays open between words —
/// each successful add clears and refocuses the field for the next one.
Future<void> showAddWordSheet(
  BuildContext context, {
  required String collectionId,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => AddWordSheet(collectionId: collectionId),
  );
}

class AddWordSheet extends ConsumerStatefulWidget {
  const AddWordSheet({super.key, required this.collectionId});

  final String collectionId;

  @override
  ConsumerState<AddWordSheet> createState() => _AddWordSheetState();
}

class _AddWordSheetState extends ConsumerState<AddWordSheet> {
  static const _debounceDelay = Duration(milliseconds: 300);

  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  Timer? _debounce;

  String _query = '';
  String? _pendingTerm;
  bool _pendingIsAi = false;
  Word? _justAdded;

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    if (_justAdded != null || _pendingTerm != null) {
      setState(() {
        _justAdded = null;
        _pendingTerm = null;
      });
    }
    _debounce?.cancel();
    _debounce = Timer(_debounceDelay, () {
      if (mounted) setState(() => _query = value.trim());
    });
  }

  void _submitFreeText(String rawTerm) {
    final term = rawTerm.trim();
    if (term.isEmpty) return;
    _startSubmit(term, isKnownReady: false);
  }

  void _addFromSuggestion(DictionaryEntry entry) {
    _startSubmit(entry.term, isKnownReady: true);
  }

  void _startSubmit(String term, {required bool isKnownReady}) {
    _debounce?.cancel();
    _controller.clear();
    setState(() {
      _query = '';
      _justAdded = null;
      _pendingTerm = term;
      _pendingIsAi = !isKnownReady;
    });
    ref
        .read(addWordProvider.notifier)
        .submit(term: term, collectionId: widget.collectionId);
  }

  void _retry() {
    final term = _pendingTerm;
    if (term == null) return;
    ref
        .read(addWordProvider.notifier)
        .submit(term: term, collectionId: widget.collectionId);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final tt = Theme.of(context).textTheme;

    ref.listen<AsyncValue<Word?>>(addWordProvider, (previous, next) {
      if (next is AsyncData<Word?> && next.value != null) {
        setState(() {
          _pendingTerm = null;
          _justAdded = next.value;
        });
        _focusNode.requestFocus();
      }
    });

    final addState = ref.watch(addWordProvider);
    final isBusy = addState.isLoading;
    final hasError = addState.hasError && _pendingTerm != null;

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Container(
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(AppRadius.lg),
          ),
        ),
        // The bottom system inset (home indicator) is added as inner padding
        // so the surface color still reaches the screen edge — wrapping this
        // in a SafeArea instead leaves a transparent gap below the sheet
        // that exposes the modal scrim underneath.
        padding: EdgeInsets.fromLTRB(
          AppSpacing.md,
          AppSpacing.sm,
          AppSpacing.md,
          AppSpacing.lg + MediaQuery.paddingOf(context).bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 34,
                height: 4,
                margin: const EdgeInsets.only(bottom: AppSpacing.md),
                decoration: BoxDecoration(
                  color: colors.outline,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Row(
              children: [
                Text('Add a word', style: tt.titleMedium),
                const Spacer(),
                CircleIconBadge(
                  size: 26,
                  backgroundColor: colors.surfaceElevated,
                  onTap: () => Navigator.of(context).pop(),
                  icon: Icon(
                    Icons.close_rounded,
                    size: 14,
                    color: colors.textMuted,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm + 2),
            Stack(
              clipBehavior: Clip.none,
              children: [
                SegmentedControl(
                  tabs: const ['Type', 'Photo'],
                  selectedIndex: 0,
                  // Photo capture isn't built yet — the tab and its "SOON"
                  // badge are a placeholder, so taps are a no-op. A
                  // SnackBar here would render behind the modal barrier
                  // and never be visible.
                  onChanged: (_) {},
                ),
                const Positioned(top: -6, right: 12, child: _SoonTag()),
              ],
            ),
            const SizedBox(height: AppSpacing.sm + 2),
            TextField(
              controller: _controller,
              focusNode: _focusNode,
              autofocus: true,
              enabled: !isBusy,
              onChanged: _onChanged,
              onSubmitted: _submitFreeText,
              textInputAction: TextInputAction.search,
              style: tt.bodyMedium?.copyWith(color: colors.textPrimary),
              decoration: InputDecoration(
                isDense: true,
                filled: true,
                fillColor: colors.surfaceSubtle,
                hintText: 'Type a German word…',
                hintStyle: tt.bodyMedium?.copyWith(color: colors.textMuted),
                prefixIcon: Icon(
                  Icons.search_rounded,
                  size: 18,
                  color: colors.textMuted,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
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
                  borderSide: BorderSide(color: colors.primary),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            if (_pendingTerm != null)
              hasError
                  ? _ErrorRow(
                      term: _pendingTerm!,
                      message: _errorMessage(addState.error),
                      onRetry: _retry,
                    )
                  : _PendingRow(term: _pendingTerm!, isAi: _pendingIsAi)
            else if (_justAdded != null)
              _AddedRow(word: _justAdded!)
            else if (_query.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                child: Text(
                  'Search the shared dictionary, or add a brand-new word',
                  textAlign: TextAlign.center,
                  style: tt.bodySmall?.copyWith(color: colors.textMuted),
                ),
              )
            else
              _SuggestionList(
                query: _query,
                onSelect: _addFromSuggestion,
                onCreateNew: () => _submitFreeText(_query),
              ),
          ],
        ),
      ),
    );
  }

  String _errorMessage(Object? error) {
    if (error is RepositoryException) return error.message;
    return 'Something went wrong';
  }
}

// ── Suggestions ─────────────────────────────────────────────────────────────

class _SuggestionList extends ConsumerWidget {
  const _SuggestionList({
    required this.query,
    required this.onSelect,
    required this.onCreateNew,
  });

  final String query;
  final ValueChanged<DictionaryEntry> onSelect;
  final VoidCallback onCreateNew;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final tt = Theme.of(context).textTheme;
    final resultsAsync = ref.watch(dictionarySearchProvider(query));

    return resultsAsync.when(
      loading: () => const Padding(
        padding: EdgeInsets.symmetric(vertical: AppSpacing.lg),
        child: Center(
          child: SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      ),
      error: (_, _) => GestureDetector(
        onTap: onCreateNew,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
          child: Text(
            'Search failed — tap to add "$query" with AI',
            textAlign: TextAlign.center,
            style: tt.bodySmall?.copyWith(color: colors.textMuted),
          ),
        ),
      ),
      data: (results) {
        if (results.isEmpty) {
          return GestureDetector(
            onTap: onCreateNew,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
              child: Text(
                'No matches — tap to add "$query" with AI',
                textAlign: TextAlign.center,
                style: tt.bodySmall?.copyWith(color: colors.textMuted),
              ),
            ),
          );
        }
        return Column(
          children: [
            for (final entry in results)
              _SuggestionRow(entry: entry, onTap: () => onSelect(entry)),
          ],
        );
      },
    );
  }
}

class _SuggestionRow extends StatelessWidget {
  const _SuggestionRow({required this.entry, required this.onTap});

  final DictionaryEntry entry;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final tt = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.sm),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        child: Row(
          children: [
            if (entry.nounData != null)
              ArticleBadge(gender: entry.nounData!.gender)
            else
              const SizedBox(width: 36),
            const SizedBox(width: AppSpacing.sm + 2),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(entry.term, style: tt.titleSmall),
                  if (entry.definition != null)
                    Text(
                      entry.definition!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: tt.bodySmall?.copyWith(color: colors.textMuted),
                    ),
                ],
              ),
            ),
            CircleIconBadge(
              size: 22,
              backgroundColor: colors.primary12,
              icon: Icon(Icons.add_rounded, size: 13, color: colors.primary),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Result rows ──────────────────────────────────────────────────────────────

class _PendingRow extends StatelessWidget {
  const _PendingRow({required this.term, required this.isAi});

  final String term;
  final bool isAi;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final tt = Theme.of(context).textTheme;

    if (!isAi) {
      return Container(
        padding: const EdgeInsets.all(AppSpacing.sm + 2),
        decoration: BoxDecoration(
          color: colors.surfaceSubtle,
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: colors.primary,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(term, style: tt.titleSmall),
            const SizedBox(width: AppSpacing.xs),
            Text(
              '· Adding…',
              style: tt.bodySmall?.copyWith(color: colors.textMuted),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm + 2),
      decoration: BoxDecoration(
        gradient: AppGradients.aiCard,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 17,
            height: 17,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: colors.textOnBrandMuted,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  term,
                  style: tt.titleSmall?.copyWith(color: colors.textOnBrand),
                ),
                Text(
                  'Generating with AI…',
                  style: tt.bodySmall?.copyWith(color: colors.textOnBrandMuted),
                ),
              ],
            ),
          ),
          Icon(
            Icons.auto_awesome_rounded,
            size: 15,
            color: colors.textOnBrandMuted,
          ),
        ],
      ),
    );
  }
}

class _AddedRow extends StatelessWidget {
  const _AddedRow({required this.word});

  final Word word;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final tt = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm + 2),
      decoration: BoxDecoration(
        color: colors.success12,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Row(
        children: [
          CircleIconBadge(
            size: 21,
            backgroundColor: colors.success,
            icon: Icon(
              Icons.check_rounded,
              size: 13,
              color: colors.textOnBrand,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(word.term, style: tt.titleSmall),
                Text(
                  word.definition,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: tt.bodySmall?.copyWith(color: colors.textMuted),
                ),
              ],
            ),
          ),
          Text(
            'ADDED',
            style: tt.labelSmall?.copyWith(
              color: colors.success,
              letterSpacing: 0.6,
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorRow extends StatelessWidget {
  const _ErrorRow({
    required this.term,
    required this.message,
    required this.onRetry,
  });

  final String term;
  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final tt = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm + 2),
      decoration: BoxDecoration(
        color: colors.error.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline_rounded, size: 18, color: colors.error),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Couldn\'t add "$term"', style: tt.titleSmall),
                Text(
                  message,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: tt.bodySmall?.copyWith(color: colors.textMuted),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onRetry,
            child: Text(
              'Retry',
              style: tt.labelMedium?.copyWith(color: colors.primary),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Misc ─────────────────────────────────────────────────────────────────────

class _SoonTag extends StatelessWidget {
  const _SoonTag();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: colors.textPrimary,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        'SOON',
        style: TextStyle(
          fontSize: 8.5,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.4,
          color: colors.textInverse,
        ),
      ),
    );
  }
}
