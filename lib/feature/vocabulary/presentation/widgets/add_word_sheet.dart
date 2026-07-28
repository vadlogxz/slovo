import 'package:flutter/material.dart';
import 'package:slovo/core/theme/_.dart';
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

class AddWordSheet extends StatefulWidget {
  const AddWordSheet({super.key, required this.collectionId});

  final String collectionId;

  @override
  State<AddWordSheet> createState() => _AddWordSheetState();
}

class _AddWordSheetState extends State<AddWordSheet> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  String? _pendingTerm;
  Word? _justAdded;

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  // No backend behind this sheet — adding a word simulates a short delay and
  // fabricates a placeholder entry, then clears the field for the next word.
  Future<void> _submit(String rawTerm) async {
    final term = rawTerm.trim();
    if (term.isEmpty || _pendingTerm != null) return;
    _controller.clear();
    setState(() {
      _justAdded = null;
      _pendingTerm = term;
    });
    await Future<void>.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;
    setState(() {
      _pendingTerm = null;
      _justAdded = Word(
        id: 'mock-word-${DateTime.now().millisecondsSinceEpoch}',
        collectionId: widget.collectionId,
        term: term,
        createdAt: DateTime.now(),
        linguistics: const WordLinguistics(definition: 'Definition coming soon'),
      );
    });
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final tt = Theme.of(context).textTheme;
    final isBusy = _pendingTerm != null;

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
                  // badge are a placeholder, so taps are a no-op.
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
              onSubmitted: _submit,
              textInputAction: TextInputAction.done,
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
              _PendingRow(term: _pendingTerm!)
            else if (_justAdded != null)
              _AddedRow(word: _justAdded!)
            else
              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                child: Text(
                  'Type a German word and press enter to add it',
                  textAlign: TextAlign.center,
                  style: tt.bodySmall?.copyWith(color: colors.textMuted),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ── Result rows ──────────────────────────────────────────────────────────────

class _PendingRow extends StatelessWidget {
  const _PendingRow({required this.term});

  final String term;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final tt = Theme.of(context).textTheme;

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
