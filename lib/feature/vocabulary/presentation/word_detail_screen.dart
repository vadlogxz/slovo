import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:slovo/core/theme/_.dart';
import 'package:slovo/feature/vocabulary/domain/models/word.dart';
import 'package:slovo/feature/vocabulary/presentation/mock_vocabulary_data.dart';
import 'package:slovo/feature/vocabulary/presentation/widgets/_.dart';
import 'package:slovo/shared/widgets/_.dart';

class WordDetailScreen extends StatelessWidget {
  const WordDetailScreen({
    super.key,
    required this.collectionId,
    required this.wordId,
  });

  final String collectionId;
  final String wordId;

  @override
  Widget build(BuildContext context) {
    final word = wordById(collectionId, wordId);
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.surfaceSubtle,
      body: SafeArea(
        child: Column(
          children: [
            const _WordDetailHeader(),
            Expanded(
              child: word == null
                  ? const _WordNotFound()
                  : SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(
                        AppSpacing.md,
                        0,
                        AppSpacing.md,
                        AppSpacing.md,
                      ),
                      child: _WordDetailBody(word: word),
                    ),
            ),
            if (word != null) const _WordDetailBottomBar(),
          ],
        ),
      ),
    );
  }
}

class _WordNotFound extends StatelessWidget {
  const _WordNotFound();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final tt = Theme.of(context).textTheme;
    return Center(
      child: Text(
        'This word no longer exists in this collection.',
        style: tt.bodyMedium?.copyWith(color: colors.textSecondary),
        textAlign: TextAlign.center,
      ),
    );
  }
}

// ── Header ────────────────────────────────────────────────────────────────────

class _WordDetailHeader extends StatelessWidget {
  const _WordDetailHeader();

  @override
  Widget build(BuildContext context) {
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
          ),
          const Spacer(),
          // Favorite / regenerate / more — visual stubs, no backing feature yet.
          HeaderIconButton(icon: Icons.star_border_rounded, onTap: () {}),
          const SizedBox(width: AppSpacing.sm),
          HeaderIconButton(icon: Icons.refresh_rounded, onTap: () {}),
          const SizedBox(width: AppSpacing.sm),
          HeaderIconButton(icon: Icons.more_horiz_rounded, onTap: () {}),
        ],
      ),
    );
  }
}

// ── Body ─────────────────────────────────────────────────────────────────────

class _WordDetailBody extends StatelessWidget {
  const _WordDetailBody({required this.word});

  final Word word;

  String _genderLabel(NounGender gender) => switch (gender) {
    NounGender.der => 'maskulin',
    NounGender.die => 'feminin',
    NounGender.das => 'neutral',
  };

  List<Widget> _infoRows(BuildContext context) {
    final rows = <Widget>[
      _DetailRow(label: 'Wortart', value: word.wordType.labelDe),
      if (word.level != null)
        _DetailRow(label: 'Niveau', value: word.level!.label),
    ];

    if (word.nounData != null) {
      final n = word.nounData!;
      rows.add(
        _DetailRow(
          label: 'Genus',
          valueWidget: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(_genderLabel(n.gender)),
              const SizedBox(width: AppSpacing.xs),
              ArticleBadge(gender: n.gender),
            ],
          ),
        ),
      );
      if (n.plural != null) {
        rows.add(_DetailRow(label: 'Plural', value: 'die ${n.plural}'));
      }
      if (n.genitive != null) {
        rows.add(_DetailRow(label: 'Genitiv', value: n.genitive!));
      }
    } else if (word.verbData != null) {
      final v = word.verbData!;
      rows.add(
        _DetailRow(
          label: 'Trennbar',
          value: v.isTrennbar
              ? 'Ja — Präfix "${v.trennbarPrefix ?? ''}"'
              : 'Nein',
        ),
      );
      rows.add(_DetailRow(label: 'Partizip II', value: v.partizip2));
      rows.add(
        _DetailRow(
          label: 'Hilfsverb',
          value: v.hilfsVerb == HilfsVerb.sein ? 'sein' : 'haben',
        ),
      );
      if (v.praeteritum != null) {
        rows.add(_DetailRow(label: 'Präteritum', value: v.praeteritum!));
      }
      if (v.conjugation != null) {
        rows.add(_ConjugationRow(conjugation: v.conjugation!));
      }
    } else if (word.adjectiveData != null) {
      final a = word.adjectiveData!;
      if (a.komparativ != null) {
        rows.add(_DetailRow(label: 'Komparativ', value: a.komparativ!));
      }
      if (a.superlativ != null) {
        rows.add(_DetailRow(label: 'Superlativ', value: a.superlativ!));
      }
    }

    return rows;
  }

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final colors = context.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppSpacing.sm),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: GenderedTerm(word: word, style: tt.headlineMedium)),
            const _SpeakerButton(),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          word.definition,
          style: tt.bodyLarge?.copyWith(color: colors.textSecondary),
        ),
        const SizedBox(height: AppSpacing.md),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            _InfoChip(label: word.wordType.labelDe, filled: true),
            if (word.nounData != null)
              _InfoChip(label: _genderLabel(word.nounData!.gender)),
            if (word.verbData != null)
              _InfoChip(
                label: word.verbData!.isTrennbar ? 'trennbar' : 'untrennbar',
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        _InfoCard(rows: _infoRows(context)),
        if (word.verbData?.isTrennbar == true &&
            word.verbData?.trennbarPrefix != null)
          _TrennbarNote(prefix: word.verbData!.trennbarPrefix!),
        if (word.example != null) ...[
          const SizedBox(height: AppSpacing.lg),
          Text(
            'EXAMPLE',
            style: tt.labelSmall?.copyWith(
              color: colors.textMuted,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          _ExampleCard(word: word),
        ],
      ],
    );
  }
}

class _SpeakerButton extends StatelessWidget {
  const _SpeakerButton();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Padding(
      padding: const EdgeInsets.only(left: AppSpacing.sm),
      child: CircleIconBadge(
        size: 34,
        backgroundColor: colors.primary12,
        // No TTS package is wired up yet — visual stub.
        onTap: () {},
        icon: Icon(Icons.volume_up_rounded, size: 16, color: colors.primary),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.label, this.filled = false});

  final String label;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final tt = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: filled ? colors.textPrimary : colors.surfaceElevated,
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Text(
        label,
        style: tt.labelMedium?.copyWith(
          color: filled ? colors.textInverse : colors.textSecondary,
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.rows});

  final List<Widget> rows;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: colors.outline),
      ),
      child: Column(
        children: [
          for (var i = 0; i < rows.length; i++) ...[
            if (i > 0) Divider(height: 1, color: colors.outline),
            rows[i],
          ],
        ],
      ),
    );
  }
}

class _ConjugationRow extends StatelessWidget {
  const _ConjugationRow({required this.conjugation});

  final VerbConjugation conjugation;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final colors = context.colors;
    final forms = [
      ('ich', conjugation.ich),
      ('du', conjugation.du),
      ('er/sie/es', conjugation.erSieEs),
      ('wir', conjugation.wir),
      ('ihr', conjugation.ihr),
      ('sie/Sie', conjugation.sieSie),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm + 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Konjugation',
            style: tt.bodySmall?.copyWith(color: colors.textMuted),
          ),
          const SizedBox(height: AppSpacing.xs),
          for (final (pronoun, form) in forms)
            Padding(
              padding: EdgeInsets.only(top: 2, left: AppSpacing.md),
              child: Row(
                children: [
                  SizedBox(
                    width: 76,
                    child: Text(
                      pronoun,
                      style: tt.bodySmall?.copyWith(color: colors.textMuted),
                    ),
                  ),
                  Text(
                    form,
                    style: tt.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, this.value, this.valueWidget});

  final String label;
  final String? value;
  final Widget? valueWidget;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final colors = context.colors;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm + 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              label,
              style: tt.bodySmall?.copyWith(color: colors.textMuted),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Flexible(
            flex: 2,
            child: DefaultTextStyle(
              textAlign: TextAlign.end,
              style:
                  tt.bodyMedium?.copyWith(fontWeight: FontWeight.w600) ??
                  const TextStyle(),
              child:
                  valueWidget ??
                  Text(value ?? '', textAlign: TextAlign.end),
            ),
          ),
        ],
      ),
    );
  }
}

class _TrennbarNote extends StatelessWidget {
  const _TrennbarNote({required this.prefix});

  final String prefix;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final colors = context.colors;
    return Container(
      margin: const EdgeInsets.only(top: AppSpacing.sm),
      padding: const EdgeInsets.all(AppSpacing.sm + 2),
      decoration: BoxDecoration(
        color: colors.primary12,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.bolt_rounded, size: 16, color: colors.primary),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              'In a main clause the prefix "$prefix" splits off and jumps '
              'to the end.',
              style: tt.bodySmall?.copyWith(color: colors.primaryDark),
            ),
          ),
        ],
      ),
    );
  }
}

class _ExampleCard extends StatelessWidget {
  const _ExampleCard({required this.word});

  final Word word;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final colors = context.colors;
    final example = word.example;
    if (example == null) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: colors.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _HighlightedExample(example: example, term: word.term),
          if (word.exampleTranslation != null) ...[
            const SizedBox(height: 4),
            Text(
              word.exampleTranslation!,
              style: tt.bodySmall?.copyWith(color: colors.textMuted),
            ),
          ],
        ],
      ),
    );
  }
}

class _HighlightedExample extends StatelessWidget {
  const _HighlightedExample({required this.example, required this.term});

  final String example;
  final String term;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final colors = context.colors;
    final baseStyle = tt.bodyMedium?.copyWith(color: colors.textPrimary);
    final boldStyle = baseStyle?.copyWith(
      fontWeight: FontWeight.w700,
      color: colors.primary,
    );

    final idx = example.toLowerCase().indexOf(term.toLowerCase());
    if (idx < 0) return Text(example, style: baseStyle);

    return RichText(
      text: TextSpan(
        style: baseStyle,
        children: [
          TextSpan(text: example.substring(0, idx)),
          TextSpan(
            text: example.substring(idx, idx + term.length),
            style: boldStyle,
          ),
          TextSpan(text: example.substring(idx + term.length)),
        ],
      ),
    );
  }
}

// ── Bottom bar ───────────────────────────────────────────────────────────────

class _WordDetailBottomBar extends StatelessWidget {
  const _WordDetailBottomBar();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final tt = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.md,
        AppSpacing.lg,
      ),
      child: AppButton(
        // Editing isn't in scope yet — visual stub.
        onTap: () {},
        backgroundColor: colors.surfaceSubtle,
        flat: true,
        border: Border.all(color: colors.outline),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.edit_outlined, size: 16, color: colors.textSecondary),
            const SizedBox(width: 6),
            Text(
              'Edit',
              style: tt.labelLarge?.copyWith(
                color: colors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
