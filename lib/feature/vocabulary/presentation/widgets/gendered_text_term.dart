import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slovo/core/theme/_.dart';
import 'package:slovo/feature/vocabulary/domain/models/word.dart';

import '../extensions/noun_gender_x.dart';

class GenderedTextTerm extends StatelessWidget {
  const GenderedTextTerm({super.key, required this.gender, required this.term, this.fontSize});

  final NounGender? gender;
  final String term;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: GoogleFonts.fraunces(
          fontSize: fontSize ?? 28,
          fontWeight: FontWeight.bold,
          color: context.colors.textPrimary,
        ),
        children: [
          TextSpan(
            text: gender != null ? '${gender?.name} ' : '',
            style: TextStyle(color: gender?.color),
          ),
          TextSpan(text: term),
        ],
      ),
    );
  }
}
