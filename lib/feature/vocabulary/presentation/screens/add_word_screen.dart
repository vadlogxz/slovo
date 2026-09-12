import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:slovo/core/assets/app_assets.dart';
import 'package:slovo/core/logging/app_logger.dart';
import 'package:slovo/core/theme/_.dart';
import 'package:slovo/feature/auth/di/auth_provider.dart';
import 'package:slovo/feature/learning/di/due_words_provider.dart';
import 'package:slovo/feature/vocabulary/di/collection_provider.dart';
import 'package:slovo/feature/vocabulary/di/dictionary_entry_provider.dart';
import 'package:slovo/feature/vocabulary/di/word_provider.dart';
import 'package:slovo/feature/vocabulary/domain/models/dictionary_entry.dart';
import 'package:slovo/feature/vocabulary/domain/models/word.dart';
import 'package:slovo/feature/vocabulary/presentation/widgets/collections_section.dart';
import 'package:slovo/feature/vocabulary/presentation/widgets/grammar_details.dart';
import 'package:slovo/feature/vocabulary/presentation/widgets/grammar_section.dart';
import 'package:slovo/feature/vocabulary/presentation/widgets/word_example.dart';
import 'package:slovo/shared/widgets/_.dart';

import '../../domain/models/dictionary_lookup_state.dart';
import '../widgets/gendered_text_term.dart';

class AddWordScreen extends ConsumerStatefulWidget {
  const AddWordScreen({super.key});

  @override
  ConsumerState<AddWordScreen> createState() => _AddWordSheetState();
}

class _AddWordSheetState extends ConsumerState<AddWordScreen>
    with SingleTickerProviderStateMixin {
  late TextEditingController _controller;
  late AnimationController _lottieController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _controller = TextEditingController();

    _lottieController = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _lottieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lookupState = ref.watch(dictionaryLookupProvider);
    final isSearching = lookupState is DictionaryLookupSearching;
    final isGenerating = lookupState is DictionaryLookupGenerating;

    bool isAddWordButtonDisabled =
        isGenerating ||
        isSearching ||
        _controller.text.trim().isEmpty ||
        ref.watch(selectedCollectionsProvider).isEmpty;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  spacing: AppSpacing.md,
                  children: [
                    PopButton(),
                    Text(
                      'Add Word',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: AppSpacing.sm,
                  children: [
                    Flexible(
                      child: TextFormField(
                        controller: _controller,
                        onChanged: (value) {
                          ref
                              .read(dictionaryLookupProvider.notifier)
                              .onQueryChanged(value);
                        },
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter a word';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hint: Text('Enter a word'),
                          hintStyle: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                              ),
                          border: OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              _controller.clear();
                            },
                          ),
                        ),
                      ),
                    ),
                    AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return AppButton(
                          isDisabled:
                              isGenerating ||
                              isSearching ||
                              _controller.text.trim().isEmpty,
                          width: 60,
                          contentPadding: EdgeInsets.zero,
                          style: AppButtonStyle(
                            background: context.colors.surfaceAccent,
                            border: Border.all(
                              width: 1.5,
                              color: context.colors.primary.withValues(
                                alpha: 0.28,
                              ),
                            ),
                            disabledBackground: context.colors.outline
                                .withValues(alpha: 0.5),
                            disabledBorder: Border.all(
                              width: 1.5,
                              color: context.colors.textMuted,
                            ),
                          ),
                          child: LottieBuilder.asset(
                            AppAssets.sparklesLoaderAI,
                            fit: BoxFit.contain,
                            controller: _lottieController,
                          ),
                          onTap: () {
                            if (_formKey.currentState?.validate() == true) {
                              ref
                                  .read(dictionaryLookupProvider.notifier)
                                  .generate(_controller.text.trim());
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),

                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: switch (lookupState) {
                      DictionaryLookupNotFound() => _NoEntryFound(
                        key: const ValueKey('not_found'),
                        term: lookupState.term,
                      ),
                      DictionaryLookupCandidates() => _DictionaryEntryPicker(
                        key: const ValueKey('candidates'),
                        entries: lookupState.candidates,
                      ),
                      DictionaryLookupReady() => _DictionaryEntryPreview(
                        key: const ValueKey('ready'),
                        entry: lookupState.entry,
                      ),
                      DictionaryLookupIdle() => const _SearchIdleHint(
                        key: ValueKey('idle'),
                      ),
                      _ => const SizedBox.shrink(),
                    },
                  ),
                ),
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return AppButton(
                      isDisabled: isAddWordButtonDisabled,
                      isLoading: isSearching,
                      style: AppButtonStyle.outline(context.colors).copyWith(
                      background: context.colors.surfaceAccent,
                      border: BoxBorder.all(color: context.colors.primary, width: 2),
                        disabledBackground: context.colors.surface,
                      disabledBorder: BoxBorder.all(color: context.colors.textMuted, width: 2),
                    ),
                      onTap: isAddWordButtonDisabled
                          ? null
                          : () async {
                              try {
                                if (_formKey.currentState?.validate() == true) {
                                  final selected = ref.read(
                                    selectedCollectionsProvider,
                                  );
                                  final userId = ref.read(
                                    currentUserIdProvider,
                                  );
                                  if (lookupState is DictionaryLookupReady) {
                                    final entry = lookupState.entry;
                                    if (userId != null && selected.isNotEmpty) {
                                      await ref
                                          .read(wordRepositoryProvider)
                                          .addWordToCollections(
                                            userId: userId,
                                            entry: entry,
                                            collectionIds: selected
                                                .map((e) => e.id)
                                                .toList(),
                                          );
                                      ref.invalidate(dueWordsProvider);
                                      if (context.mounted) context.pop();
                                    } else {
                                      throw Exception(
                                        'User ID is null or no collections selected',
                                      );
                                    }
                                  }
                                }
                              } catch (e) {
                                AppLogger.error('Error adding word: $e');
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Error adding word: $e'),
                                    ),
                                  );
                                }
                              }
                            },

                      child: Row(
                        spacing: AppSpacing.sm,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add, color: isAddWordButtonDisabled ? context.colors.textMuted : context.colors.primary,),
                          Text(
                            'Add Word',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: isAddWordButtonDisabled ? context.colors.textMuted : context.colors.primary,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SearchIdleHint extends StatelessWidget {
  const _SearchIdleHint({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.travel_explore, size: 96, color: colors.textMuted),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Search for a German word above,\nor tap ✨ to generate one with AI.',
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: colors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}

class _NoEntryFound extends StatelessWidget {
  const _NoEntryFound({required this.term, super.key});

  final String term;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(bottom: 80),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppIcon(path: AppAssets.notFound, size: 250),
            Text(
              'No entry found for “$term”.',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      ),
    );
  }
}

class _DictionaryEntryPicker extends StatelessWidget {
  const _DictionaryEntryPicker({required this.entries, super.key});

  final List<DictionaryEntry> entries;

  @override
  Widget build(BuildContext context) {
    return Column(children: [Text('${entries.length} matches in dictionary')]);
  }
}

class _DictionaryEntryPreview extends StatelessWidget {
  const _DictionaryEntryPreview({required this.entry, super.key});

  final DictionaryEntry entry;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;
    final linguistics = entry.linguistics;
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            border: Border.all(width: 3, color: colors.outline),
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Term (+ noun gender article, when known)
              GenderedTextTerm(
                term: entry.term,
                gender: entry.nounData?.gender,
              ),

              // Word type / CEFR level badges
              if (entry.wordType != null || entry.level != null) ...[
                const SizedBox(height: AppSpacing.xs),
                Wrap(
                  spacing: AppSpacing.xs,
                  children: [
                    if (entry.wordType != null) _InfoChip(entry.wordType.label),
                    if (entry.level != null) _InfoChip(entry.level!.label),
                  ],
                ),
              ],

              const SizedBox(height: AppSpacing.sm),

              // Definition
              Text(
                entry.definition ?? 'No definition available',
                style: textTheme.bodyMedium,
              ),

              // Example sentence + translation
              if (entry.example != null) ...[
                const SizedBox(height: AppSpacing.sm),
                WordExample(
                  example: entry.example!,
                  exampleTranslation: entry.exampleTranslation,
                ),
              ],

              if (linguistics != null && hasGrammarDetails(linguistics)) ...[
                const SizedBox(height: AppSpacing.sm),
                Divider(height: 1, color: colors.outline),
                GrammarSection(linguistics: linguistics),
              ],
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        CollectionsSection(),
      ],
    );
  }
}

/// Small rounded label — used for word-type / CEFR-level tags on
/// [_DictionaryEntryPreview].
class _InfoChip extends StatelessWidget {
  const _InfoChip(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs / 2,
      ),
      decoration: BoxDecoration(
        color: colors.surfaceAccent,
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Text(
        label,
        style: Theme.of(
          context,
        ).textTheme.labelMedium?.copyWith(color: colors.primary),
      ),
    );
  }
}
