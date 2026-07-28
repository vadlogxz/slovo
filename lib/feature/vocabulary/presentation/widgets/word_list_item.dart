import 'package:flutter/material.dart';
import 'package:slovo/core/theme/_.dart';
import 'package:slovo/feature/vocabulary/domain/models/word.dart';
import 'package:slovo/shared/widgets/_.dart';

class WordListItem extends StatelessWidget {
  const WordListItem({
    super.key,
    required this.word,
    this.isJustAdded = false,
    this.onTap,
  });

  final Word word;
  final bool isJustAdded;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final colors = context.colors;
    final typeLabel = word.wordType.abbreviation;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm + 2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (word.nounData != null)
              ArticleBadge(gender: word.nounData!.gender)
            else if (typeLabel != null)
              BadgePill(
                backgroundColor: colors.textMuted.withValues(alpha: 0.12),
                child: Text(
                  typeLabel,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: colors.textMuted,
                    letterSpacing: 0.1,
                  ),
                ),
              )
            else
              const SizedBox(width: 36),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(word.term, style: tt.titleSmall),
                  const SizedBox(height: 2),
                  Text(
                    word.definition,
                    style: tt.bodySmall?.copyWith(color: colors.textSecondary),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (isJustAdded) ...[
              const SizedBox(width: AppSpacing.sm),
              BadgePill(
                backgroundColor: colors.surfaceSubtle,
                child: Text(
                  'just added',
                  style: tt.labelMedium?.copyWith(color: colors.textMuted),
                ),
              ),
            ],
            const SizedBox(width: AppSpacing.sm),
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: colors.primary,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
