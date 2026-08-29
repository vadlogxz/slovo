import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:slovo/app/router/app_routes.dart';
import 'package:slovo/core/theme/_.dart';
import 'package:slovo/core/theme/color_x.dart';
import 'package:slovo/feature/vocabulary/di/collection_provider.dart';
import 'package:slovo/feature/vocabulary/domain/models/collection_icon.dart';
import 'package:slovo/feature/vocabulary/presentation/extensions/collection_color_x.dart';
import 'package:slovo/feature/vocabulary/presentation/extensions/collection_icon_x.dart';
import 'package:slovo/shared/widgets/_.dart';
import 'package:slovo/shared/widgets/dash_border_painter.dart';

class VocabularyScreen extends StatelessWidget {
  const VocabularyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Column(
        children: [
          Text(
            'Vocabulary',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontSize: 24),
          ),
          _Collections(),
        ],
      ),
    );
  }
}

//TODO: Implement a search and filter section

class _Collections extends ConsumerWidget {
  const _Collections();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final collections = ref.watch(userCollectionsProvider);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Collections',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontSize: 20),
            ),
            TextButton(
              onPressed: () {
                // TODO: Go to Collections edit page.
              },
              child: Text(
                'Edit',
                style: Theme.of(
                  context,
                ).textTheme.labelLarge?.copyWith(color: context.colors.primary),
              ),
            ),
          ],
        ),
        collections.when(
          data: (collections) {
            final List<Widget> cards = collections.map<Widget>((collection) {
              return _CollectionCard(
                color: collection.color.color,
                title: collection.title,
                wordsCount: collection.wordCount,
                icon: collection.icon
              );
            }).toList();
            if (cards.length <= 5) {
              cards.add(
                _AddCollectionCard(
                  onTap: () => context.push(AppRoutes.createCollection.path),
                ),
              );
            }

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: cards.take(6).length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: AppSpacing.sm,
                crossAxisSpacing: AppSpacing.sm,
              ),
              itemBuilder: (context, index) {
                return cards[index];
              },
            );
          },
          error: (e, stackTrace) {
            return Text('Error: $e');
          },
          loading: () {
            return Text('Loading...');
          },
        ),
      ],
    );
  }
}

class _CollectionCardShell extends StatefulWidget {
  const _CollectionCardShell({
    required this.color,
    required this.child,
    this.onTap,
    this.dashed = false,
    this.dashColor,
  });

  final Color color;
  final Widget child;
  final VoidCallback? onTap;
  final bool? dashed;
  final Color? dashColor;

  @override
  State<_CollectionCardShell> createState() => _CollectionCardShellState();
}

class _CollectionCardShellState extends State<_CollectionCardShell> {
  bool isPressed = false;

  Widget _buildContent() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.lg,
      ),
      decoration: BoxDecoration(
        color: widget.color.withValues(alpha: 0.13),
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: widget.child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => isPressed = true),
      onTapUp: (_) => setState(() => isPressed = false),
      onTapCancel: () => setState(() => isPressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: isPressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 90),
        child: widget.dashed == true
            ? CustomPaint(
                painter: DashBorderPainter(
                  color: widget.dashColor ?? widget.color,
                  strokeWidth: 1,
                  dashGap: 3,
                  dashWidth: 3,
                ),
                child: _buildContent(),
              )
            : _buildContent(),
      ),
    );
  }
}

class _CollectionCard extends StatelessWidget {
  const _CollectionCard({
    required this.color,
    required this.title,
    required this.wordsCount,
    required this.icon,
  });

  final Color color;
  final String title;
  final int wordsCount;
  final CollectionIcon icon;

  @override
  Widget build(BuildContext context) {
    return _CollectionCardShell(
      color: color,
      onTap: () {
        // TODO: Go to collection details page.
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppIcon(path: icon.asset, color: color.contrastForeground, size: 24),
          SizedBox(height: AppSpacing.xs),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: color.contrastForeground,
            ),
          ),
          Text(
            wordsCount.toString(),
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontSize: 22, color: color.contrastForeground),
          ),
        ],
      ),
    );
  }
}

class _AddCollectionCard extends StatelessWidget {
  const _AddCollectionCard({required this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return _CollectionCardShell(
      color: context.colors.surface,
      onTap: onTap,
      dashColor: context.colors.textMuted,
      dashed: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.add, color: context.colors.textMuted, size: 28),
          Text(
            'Add collection',
            style: Theme.of(
              context,
            ).textTheme.labelMedium?.copyWith(fontSize: 15),
          ),
        ],
      ),
    );
  }
}
