import 'package:flutter/material.dart';
import 'package:slovo/core/theme/app_colors.dart';
import 'package:slovo/core/theme/app_spacing.dart';
import 'package:slovo/feature/vocabulary/domain/models/word.dart';

/// Returns true if the given [WordLinguistics] has any grammar details to display.
/// This is used to determine whether to show the grammar section in the word card.
///

bool hasGrammarDetails(WordLinguistics linguistics) {
  final verb = linguistics.verbData;
  final noun = linguistics.nounData;
  final adj = linguistics.adjectiveData;
  return verb != null ||
      (noun != null && (noun.plural != null || noun.genitive != null)) ||
      (adj != null && (adj.komparativ != null || adj.superlativ != null));
}

class GrammarDetails extends StatelessWidget {
  const GrammarDetails({super.key, required this.linguistics});

  final WordLinguistics linguistics;

  @override
  Widget build(BuildContext context) {
    final verb = linguistics.verbData;
    final verbConjugation = verb?.conjugation;
    final noun = linguistics.nounData;
    final adj = linguistics.adjectiveData;
    
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.xs, bottom: AppSpacing.xs),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (verb != null) ...[
            _DetailRow(
              label: 'Perfekt',
              value:
                  '${verb.hilfsVerb == HilfsVerb.sein ? 'ist' : 'hat'} ${verb.partizip2}',
            ),
            if (verb.praeteritum != null)
              _DetailRow(
                label: 'Präteritum',
                value: verb.praeteritum!,
              ),
            _DetailRow(
              label: 'Trennbar',
              value: verb.isTrennbar
                  ? 'Yes (${verb.trennbarPrefix ?? '?'}-)'
                  : 'No',
            ),
            if (verb.isIrregular)
              _DetailRow(label: 'Irregular', value: 'Yes'),
          ],
          if (noun != null) ...[
            if (noun.plural != null)
              _DetailRow(label: 'Plural', value: noun.plural!),
            if (noun.genitive != null)
              _DetailRow(
                label: 'Genitive',
                value: noun.genitive!,
              ),
          ],
          if (adj != null) ...[
            if (adj.komparativ != null)
              _DetailRow(
                label: 'Comparative',
                value: adj.komparativ!,
              ),
            if (adj.superlativ != null)
              _DetailRow(
                label: 'Superlative',
                value: adj.superlativ!,
              ),
          ],
          if (verbConjugation != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Präsens',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: context.colors.textSecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            _ConjugationTable(conjugation: verbConjugation),
          ],
        ],
      ),
    );
  }
}

/// One "label — value" line inside [_GrammarDetails].
class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(
            width: 90,
            child: Text(
              label,
              style: textTheme.bodySmall?.copyWith(color: colors.textMuted),
            ),
          ),
          Expanded(child: Text(value, style: textTheme.bodyMedium)),
        ],
      ),
    );
  }
}

/// Present-tense conjugation table — two columns (singular / plural),
/// each row pairing a pronoun with its conjugated form.
class _ConjugationTable extends StatelessWidget {
  const _ConjugationTable({required this.conjugation});

  final VerbConjugation conjugation;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final divider = BorderSide(color: colors.outline);

    return Table(
      border: TableBorder(horizontalInside: divider, verticalInside: divider),
      columnWidths: const {0: FlexColumnWidth(), 1: FlexColumnWidth()},
      children: [
        _row(context, 'ich', conjugation.ich, 'wir', conjugation.wir),
        _row(context, 'du', conjugation.du, 'ihr', conjugation.ihr),
        _row(
          context,
          'er/sie/es',
          conjugation.erSieEs,
          'sie/Sie',
          conjugation.sieSie,
        ),
      ],
    );
  }

  TableRow _row(
    BuildContext context,
    String leftPronoun,
    String leftForm,
    String rightPronoun,
    String rightForm,
  ) {
    return TableRow(
      children: [
        _ConjugationCell(pronoun: leftPronoun, form: leftForm),
        _ConjugationCell(pronoun: rightPronoun, form: rightForm),
      ],
    );
  }
}

class _ConjugationCell extends StatelessWidget {
  const _ConjugationCell({required this.pronoun, required this.form});

  final String pronoun;
  final String form;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 62,
            child: Text(
              pronoun,
              style: textTheme.bodySmall?.copyWith(color: colors.textMuted),
            ),
          ),
          Expanded(
            child: Text(
              form,
              style: textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
