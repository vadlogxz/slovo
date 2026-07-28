import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:slovo/core/theme/_.dart';
import 'package:slovo/feature/vocabulary/domain/models/word.dart';
import 'package:slovo/feature/vocabulary/presentation/mock_vocabulary_data.dart';
import 'package:slovo/shared/widgets/_.dart';

class LearnSessionScreen extends StatefulWidget {
  const LearnSessionScreen({super.key, required this.collectionId});

  final String collectionId;

  @override
  State<LearnSessionScreen> createState() => _LearnSessionScreenState();
}

class _LearnSessionScreenState extends State<LearnSessionScreen> {
  late final List<Word> _queue;
  int _currentIndex = 0;
  bool _revealed = false;

  @override
  void initState() {
    super.initState();
    _queue = List.of(wordsOf(widget.collectionId));
  }

  void _reveal() {
    if (_revealed) return;
    setState(() => _revealed = true);
  }

  // No FSRS scheduling behind this session — either rating choice (or swipe
  // direction) just advances to the next card in the mock queue.
  void _advance() {
    setState(() {
      _currentIndex++;
      _revealed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.surfaceSubtle,
      body: SafeArea(
        child: _queue.isEmpty
            ? _EmptySession(onDone: () => context.pop())
            : _currentIndex >= _queue.length
            ? _SessionComplete(
                reviewed: _queue.length,
                onDone: () => context.pop(),
              )
            : _SessionBody(
                currentIndex: _currentIndex,
                total: _queue.length,
                word: _queue[_currentIndex],
                revealed: _revealed,
                onReveal: _reveal,
                onAdvance: _advance,
              ),
      ),
    );
  }
}

class _SessionBody extends StatelessWidget {
  const _SessionBody({
    required this.currentIndex,
    required this.total,
    required this.word,
    required this.revealed,
    required this.onReveal,
    required this.onAdvance,
  });

  final int currentIndex;
  final int total;
  final Word word;
  final bool revealed;
  final VoidCallback onReveal;
  final VoidCallback onAdvance;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final tt = Theme.of(context).textTheme;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.md,
            AppSpacing.sm,
            AppSpacing.md,
            0,
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => context.pop(),
                child: Icon(Icons.close_rounded, color: colors.textSecondary),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(child: ProgressBar(value: currentIndex / total)),
              const SizedBox(width: AppSpacing.sm),
              Text(
                '${currentIndex + 1}/$total',
                style: tt.labelMedium?.copyWith(color: colors.textMuted),
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: _SwipeableCard(
              word: word,
              revealed: revealed,
              onTap: onReveal,
              onSwipeLeft: onAdvance,
              onSwipeRight: onAdvance,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.md,
            0,
            AppSpacing.md,
            AppSpacing.lg,
          ),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onAdvance,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: colors.outline),
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.md,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                  ),
                  child: Text(
                    'Still learning',
                    style: tt.labelLarge?.copyWith(
                      color: colors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: AppButton(onTap: onAdvance, text: 'Know it'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Swipeable card ───────────────────────────────────────────────────────────
//
// Tap reveals the card. Dragging horizontally past the threshold rates it —
// left = "Still learning" (Again), right = "Know it" (Good) — mirroring the
// two buttons below, which stay as the non-gesture alternative.

class _SwipeableCard extends StatefulWidget {
  const _SwipeableCard({
    required this.word,
    required this.revealed,
    required this.onTap,
    required this.onSwipeLeft,
    required this.onSwipeRight,
  });

  final Word word;
  final bool revealed;
  final VoidCallback onTap;
  final VoidCallback onSwipeLeft;
  final VoidCallback onSwipeRight;

  @override
  State<_SwipeableCard> createState() => _SwipeableCardState();
}

class _SwipeableCardState extends State<_SwipeableCard> {
  static const _swipeThreshold = 96.0;

  double _dragX = 0;
  bool _dragging = false;

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() => _dragX += details.delta.dx);
  }

  void _onPanEnd(DragEndDetails details) {
    if (_dragX > _swipeThreshold) {
      widget.onSwipeRight();
    } else if (_dragX < -_swipeThreshold) {
      widget.onSwipeLeft();
    }
    setState(() {
      _dragging = false;
      _dragX = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final progress = (_dragX / _swipeThreshold).clamp(-1.0, 1.0);

    return GestureDetector(
      onTap: widget.onTap,
      onPanStart: (_) => setState(() => _dragging = true),
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: AnimatedContainer(
        duration: _dragging ? Duration.zero : const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        transform: Matrix4.identity()
          ..translateByDouble(_dragX, 0.0, 0.0, 1.0)
          ..rotateZ(_dragX / 900),
        transformAlignment: Alignment.center,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            _FlashCard(word: widget.word, revealed: widget.revealed),
            if (progress.abs() > 0.15)
              Positioned(
                top: AppSpacing.md,
                child: _SwipeBadge(
                  knowIt: progress > 0,
                  opacity: progress.abs(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _SwipeBadge extends StatelessWidget {
  const _SwipeBadge({required this.knowIt, required this.opacity});

  final bool knowIt;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Opacity(
      opacity: opacity,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: knowIt ? colors.success : colors.warning,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          knowIt ? 'KNOW IT' : 'STILL LEARNING',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
            color: colors.textOnBrand,
          ),
        ),
      ),
    );
  }
}

// ── Flash card ───────────────────────────────────────────────────────────────

class _FlashCard extends StatelessWidget {
  const _FlashCard({required this.word, required this.revealed});

  final Word word;
  final bool revealed;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: colors.outline),
      ),
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: revealed
            ? _CardBack(key: const ValueKey('back'), word: word)
            : _CardFront(key: const ValueKey('front'), word: word),
      ),
    );
  }
}

class _CardFront extends StatelessWidget {
  const _CardFront({super.key, required this.word});

  final Word word;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final colors = context.colors;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: colors.surfaceElevated,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            word.wordType.label,
            style: tt.labelMedium?.copyWith(color: colors.textSecondary),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        GenderedTerm(
          word: word,
          style: tt.headlineLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.lg),
        CircleIconBadge(
          size: 40,
          backgroundColor: colors.primary12,
          icon: Icon(Icons.volume_up_rounded, color: colors.primary, size: 18),
        ),
        const Spacer(),
        Text(
          'Tap the card to reveal the meaning',
          style: tt.bodyMedium?.copyWith(
            color: colors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _CardBack extends StatelessWidget {
  const _CardBack({super.key, required this.word});

  final Word word;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GenderedTerm(word: word, style: tt.titleMedium),
        const SizedBox(height: AppSpacing.sm),
        Text(word.definition, style: tt.headlineSmall),
        if (word.example != null) ...[
          const SizedBox(height: AppSpacing.lg),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: colors.surfaceSubtle,
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(word.example!, style: tt.bodyMedium),
                if (word.exampleTranslation != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    word.exampleTranslation!,
                    style: tt.bodySmall?.copyWith(color: colors.textMuted),
                  ),
                ],
              ],
            ),
          ),
        ],
      ],
    );
  }
}

// ── Empty / complete states ──────────────────────────────────────────────────

class _EmptySession extends StatelessWidget {
  const _EmptySession({required this.onDone});

  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    return _SessionEndState(
      icon: Icons.check_circle_outline_rounded,
      iconColor: context.colors.success,
      title: 'Nothing due right now',
      subtitle: 'Come back later, or add more words to this collection.',
      onDone: onDone,
    );
  }
}

class _SessionComplete extends StatelessWidget {
  const _SessionComplete({required this.reviewed, required this.onDone});

  final int reviewed;
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    return _SessionEndState(
      icon: Icons.celebration_rounded,
      iconColor: context.colors.primary,
      title: 'Session complete',
      subtitle: 'You reviewed $reviewed ${reviewed == 1 ? 'word' : 'words'}.',
      onDone: onDone,
    );
  }
}

// Shared shape for both "nothing to review" and "session finished" states —
// same icon/title/subtitle/button layout, only the copy and icon differ.
class _SessionEndState extends StatelessWidget {
  const _SessionEndState({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onDone,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final colors = context.colors;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 48, color: iconColor),
            const SizedBox(height: AppSpacing.md),
            Text(title, style: tt.titleLarge),
            const SizedBox(height: AppSpacing.sm),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: tt.bodyMedium?.copyWith(color: colors.textSecondary),
            ),
            const SizedBox(height: AppSpacing.lg),
            AppButton(onTap: onDone, text: 'Done'),
          ],
        ),
      ),
    );
  }
}
