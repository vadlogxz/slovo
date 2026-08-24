import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:slovo/core/assets/app_assets.dart';
import 'package:slovo/core/logging/app_logger.dart';
import 'package:slovo/core/theme/_.dart';
import 'package:slovo/core/theme/color_x.dart';
import 'package:slovo/feature/auth/di/auth_provider.dart';
import 'package:slovo/feature/vocabulary/di/collection_provider.dart';
import 'package:slovo/feature/vocabulary/di/dictionary_entry_provider.dart';
import 'package:slovo/feature/vocabulary/di/word_provider.dart';
import 'package:slovo/feature/vocabulary/domain/models/collection.dart';
import 'package:slovo/feature/vocabulary/domain/models/dictionary_entry.dart';
import 'package:slovo/feature/vocabulary/domain/models/word.dart';
import 'package:slovo/feature/vocabulary/presentation/collection_color_x.dart';
import 'package:slovo/feature/vocabulary/presentation/collection_icon_x.dart';
import 'package:slovo/feature/vocabulary/presentation/noun_gender_x.dart';
import 'package:slovo/shared/widgets/_.dart';

import '../../domain/models/dictionary_lookup_state.dart';

class AddWordSheet extends ConsumerStatefulWidget {
  const AddWordSheet({super.key});

  @override
  ConsumerState<AddWordSheet> createState() => _AddWordSheetState();
}

class _AddWordSheetState extends ConsumerState<AddWordSheet>
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

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  'Add Word Sheet',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
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
                        setState(() {});
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
                  AppButton(
                    isDisabled:
                        isGenerating ||
                        isSearching ||
                        _controller.text.trim().isEmpty,
                    width: 60,
                    contentPadding: EdgeInsets.zero,
                    style: AppButtonStyle(
                      background: context.colors.surfaceAccentTint,
                      border: Border.all(
                        width: 1.5,
                        color: context.colors.primary.withValues(alpha: 0.28),
                      ),
                      disabledBackground: context.colors.outline.withValues(
                        alpha: 0.5,
                      ),
                      disabledBorder: Border.all(
                        width: 1.5,
                        color: context.colors.outline,
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
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),

              if (lookupState is DictionaryLookupNotFound)
                _NoEntryFound(term: lookupState.term),

              if (lookupState is DictionaryLookupCandidates)
                _DictionaryEntryPicker(entries: lookupState.candidates),

              if (lookupState is DictionaryLookupReady)
                _DictionaryEntryPreview(entry: lookupState.entry),

              const SizedBox(height: AppSpacing.md),
              AppButton(
                isDisabled: isAddWordButtonDisabled,
                isLoading: isSearching,
                onTap: isAddWordButtonDisabled
                    ? null
                    : () async {
                        try {
                          if (_formKey.currentState?.validate() == true) {
                            final selected = ref.read(
                              selectedCollectionsProvider,
                            );
                            final userId = ref.read(currentUserIdProvider);
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
                              SnackBar(content: Text('Error adding word: $e')),
                            );
                          }
                        }
                      },

                text: 'Add Word',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Collections extends ConsumerWidget {
  const _Collections();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final collections = ref.watch(userCollectionsProvider);
    final selectedCollections = ref.watch(selectedCollectionsProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Add to collection',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        collections.when(
          data: (data) {
            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: data.length,
              separatorBuilder: (context, index) =>
                  const SizedBox(height: AppSpacing.xs),
              itemBuilder: (context, index) {
                final collection = data[index];
                return _CollectionItem(
                  collection: collection,
                  selected: selectedCollections.contains(collection),
                  onTap: () {
                    ref.read(selectedCollectionsProvider.notifier).update((
                      set,
                    ) {
                      final next = {...set};
                      next.contains(collection)
                          ? next.remove(collection)
                          : next.add(collection);
                      return next;
                    });
                  },
                );
              },
            );
          },
          error: (error, stackTrace) {
            return Text('Error loading collections: $error');
          },
          loading: () {
            return const CircularProgressIndicator();
          },
        ),
      ],
    );
  }
}

class _CollectionItem extends ConsumerWidget {
  const _CollectionItem({
    required this.collection,
    required this.onTap,
    required this.selected,
  });

  final Collection collection;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Text(
        collection.title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: Text(
        '${collection.wordCount} words',
        style: Theme.of(context).textTheme.bodySmall,
      ),
      leading: CircleAvatar(
        backgroundColor: collection.color.color.withValues(alpha: 0.13),
        child: AppIcon(
          path: collection.icon.asset,
          color: collection.color.color.contrastForeground,
        ),
      ),
      trailing: selected
          ? AppIcon(
              path: AppAssets.checkCircle,
              color: context.colors.primary,
              size: 34,
            )
          : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
        side: BorderSide(
          color: selected ? context.colors.primary : Colors.transparent,
          width: 2,
        ),
      ),
      selected: selected,
      onTap: onTap,
    );
  }
}

class _NoEntryFound extends StatelessWidget {
  const _NoEntryFound({required this.term});

  final String term;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          AppIcon(path: AppAssets.notFound, size: 200),
          Text(
            'No entry found for “$term”.',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
    );
  }
}

class _DictionaryEntryPicker extends StatelessWidget {
  const _DictionaryEntryPicker({required this.entries});

  final List<DictionaryEntry> entries;

  @override
  Widget build(BuildContext context) {
    return Column(children: [Text('${entries.length} matches in dictionary')]);
  }
}

class _DictionaryEntryPreview extends StatelessWidget {
  const _DictionaryEntryPreview({required this.entry});

  final DictionaryEntry entry;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;
    final gender = entry.nounData?.gender;

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
              Text.rich(
                TextSpan(
                  style: GoogleFonts.fraunces(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: colors.textPrimary,
                  ),
                  children: [
                    TextSpan(
                      text: gender != null ? '${gender.name} ' : '',
                      style: TextStyle(color: gender?.color),
                    ),
                    TextSpan(text: entry.term),
                  ],
                ),
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
                Row(
                  children: [
                    Container(
                      width: 4,
                      height: 40,
                      decoration: BoxDecoration(
                        color: colors.primary,
                        borderRadius: BorderRadius.circular(AppRadius.sm),
                      ),
                    ),
                    SizedBox(width: AppSpacing.sm),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entry.example!,
                          style: textTheme.bodyMedium?.copyWith(
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        if (entry.exampleTranslation != null)
                          Padding(
                            padding: const EdgeInsets.only(top: AppSpacing.xs),
                            child: Text(
                              entry.exampleTranslation!,
                              style: textTheme.bodySmall,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ],

              if (_hasGrammarDetails(entry)) ...[
                const SizedBox(height: AppSpacing.sm),
                Divider(height: 1, color: colors.outline),
                _GrammarDetails(entry: entry),
              ],
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        _Collections(),
      ],
    );
  }

  bool _hasGrammarDetails(DictionaryEntry entry) {
    final verb = entry.verbData;
    final noun = entry.nounData;
    final adj = entry.adjectiveData;
    return verb != null ||
        (noun != null && (noun.plural != null || noun.genitive != null)) ||
        (adj != null && (adj.komparativ != null || adj.superlativ != null));
  }
}

/// Collapsible "Grammar" section on [_DictionaryEntryPreview] — holds the
/// secondary details (Perfekt/Präteritum, trennbar, plural/genitive,
/// comparison forms) plus the present-tense conjugation table, so the card
/// itself stays short until the learner asks for more.
class _GrammarDetails extends StatefulWidget {
  const _GrammarDetails({required this.entry});

  final DictionaryEntry entry;

  @override
  State<_GrammarDetails> createState() => _GrammarDetailsState();
}

class _GrammarDetailsState extends State<_GrammarDetails> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          onTap: () => setState(() => _expanded = !_expanded),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
            child: Row(
              children: [
                Text(
                  'Grammar',
                  style: textTheme.labelLarge?.copyWith(
                    color: colors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                AnimatedRotation(
                  turns: _expanded ? 0.5 : 0,
                  duration: const Duration(milliseconds: 180),
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    size: 20,
                    color: colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
        AnimatedCrossFade(
          firstChild: const SizedBox(width: double.infinity),
          secondChild: _details(context),
          crossFadeState: _expanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 180),
          sizeCurve: Curves.easeInOut,
        ),
      ],
    );
  }

  Widget _details(BuildContext context) {
    final entry = widget.entry;
    final verb = entry.verbData;
    final noun = entry.nounData;
    final adj = entry.adjectiveData;

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
              _DetailRow(label: 'Präteritum', value: verb.praeteritum!),
            _DetailRow(
              label: 'Trennbar',
              value: verb.isTrennbar
                  ? 'Yes (${verb.trennbarPrefix ?? '?'}-)'
                  : 'No',
            ),
            if (verb.isIrregular) _DetailRow(label: 'Irregular', value: 'Yes'),
          ],
          if (noun != null) ...[
            if (noun.plural != null)
              _DetailRow(label: 'Plural', value: noun.plural!),
            if (noun.genitive != null)
              _DetailRow(label: 'Genitive', value: noun.genitive!),
          ],
          if (adj != null) ...[
            if (adj.komparativ != null)
              _DetailRow(label: 'Comparative', value: adj.komparativ!),
            if (adj.superlativ != null)
              _DetailRow(label: 'Superlative', value: adj.superlativ!),
          ],
          if (verb?.conjugation != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Präsens',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: context.colors.textSecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            _ConjugationTable(conjugation: verb!.conjugation!),
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
          Expanded(
            child: Text(value, style: textTheme.bodyMedium),
          ),
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
      border: TableBorder(
        horizontalInside: divider,
        verticalInside: divider,
      ),
      columnWidths: const {
        0: FlexColumnWidth(),
        1: FlexColumnWidth(),
      },
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
        color: colors.surfaceAccentTint,
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
