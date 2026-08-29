import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:slovo/core/theme/app_radius.dart';
import 'package:slovo/core/theme/app_spacing.dart';
import 'package:slovo/feature/vocabulary/domain/models/word.dart';
import 'package:slovo/feature/vocabulary/presentation/widgets/gendered_text_term.dart';
import 'package:slovo/feature/vocabulary/presentation/widgets/grammar_details.dart';
import 'package:slovo/feature/vocabulary/presentation/widgets/word_example.dart';

import '../../../../core/theme/app_colors.dart';

class WordCard extends StatefulWidget {
  const WordCard({super.key, required this.word});

  final Word word;

  @override
  State<WordCard> createState() => _WordCardState();
}

class _WordCardState extends State<WordCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _flipController;

  @override
  void initState() {
    _flipController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _flipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (_flipController.isCompleted) {
            _flipController.reverse();
          } else {
            _flipController.forward();
          }
        },
        child: AnimatedBuilder(
          animation: _flipController,
          builder: (context, child) {
            final isBack = _flipController.value >= 0.5;
            final angle = isBack
                ? _flipController.value * math.pi - math.pi
                : _flipController.value * math.pi;
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(angle),
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: context.colors.outline, width: 3),
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                ),
                child: isBack
                    ? _WordCardBack(word: widget.word)
                    : _WordCardFront(
                        term: widget.word.term,
                        gender: widget.word.nounData?.gender,
                      ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _WordCardFront extends StatelessWidget {
  const _WordCardFront({this.gender, required this.term});

  final NounGender? gender;
  final String term;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(),
        GenderedTextTerm(gender: gender, term: term, fontSize: 38),
        Padding(
          padding: EdgeInsets.only(bottom: AppSpacing.md),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: AppSpacing.sm,
            children: [
              Icon(
                Icons.arrow_downward_rounded,
                color: context.colors.textMuted,
              ),
              Text(
                'TAP TO REVEAL',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontStyle: FontStyle.italic,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _WordCardBack extends StatelessWidget {
  const _WordCardBack({required this.word});

  final Word word;

  @override
  Widget build(BuildContext context) {
    final wordExample = word.linguistics.example;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GenderedTextTerm(
          gender: word.nounData?.gender,
          term: word.term,
          fontSize: 32,
        ),
        // Word detail pills
        Row(children: []),
        Divider(color: context.colors.outline, thickness: 2),
        SizedBox(height: AppSpacing.md),
        Text(
          word.linguistics.definition,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontSize: 22),
        ),
        SizedBox(height: AppSpacing.md),
        wordExample != null
            ? WordExample(
                example: wordExample,
                exampleTranslation: word.linguistics.exampleTranslation,
              )
            : SizedBox(),

        SizedBox(height: AppSpacing.md),
        Divider(color: context.colors.outline, thickness: 2),
        SizedBox(height: AppSpacing.md),
        if (hasGrammarDetails(word.linguistics))
          GrammarDetails(linguistics: word.linguistics),
      ],
    );
  }
}
