import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slovo/core/theme/_.dart';

/// Standard loading/error/data handling for an [AsyncValue], so screens don't
/// each re-write the same spinner + error-message boilerplate.
///
/// Pass [errorMessage] to show a centered message on error; leave it null to
/// render nothing on error, for call sites that treat a failed load as
/// visually equivalent to "no data yet".
class AsyncValueView<T> extends StatelessWidget {
  const AsyncValueView({
    super.key,
    required this.value,
    required this.data,
    this.errorMessage,
  });

  final AsyncValue<T> value;
  final Widget Function(T data) data;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) {
        final message = errorMessage;
        if (message == null) return const SizedBox.shrink();
        return Center(
          child: Text(
            message,
            style: TextStyle(color: context.colors.textSecondary),
          ),
        );
      },
    );
  }
}
