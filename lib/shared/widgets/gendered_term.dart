import 'package:flutter/material.dart';
import 'package:slovo/core/theme/_.dart';
import 'package:slovo/feature/vocabulary/domain/models/word.dart';
import 'package:slovo/shared/widgets/article_badge.dart';

/// Renders a word's term, prefixed with its colored gender name (e.g.
/// "der Tisch") when the word is a noun. Non-nouns just render the term.
class GenderedTerm extends StatelessWidget {
  const GenderedTerm({
    super.key,
    required this.word,
    this.style,
    this.textAlign,
  });

  final Word word;
  final TextStyle? style;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Text.rich(
      TextSpan(
        style: style,
        children: [
          if (word.nounData != null)
            TextSpan(
              text: '${word.nounData!.gender.name} ',
              style: TextStyle(
                color: ArticleBadge.colorFor(colors, word.nounData!.gender),
              ),
            ),
          TextSpan(text: word.term),
        ],
      ),
      textAlign: textAlign,
    );
  }
}
