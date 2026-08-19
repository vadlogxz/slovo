import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashDoneNotifier extends Notifier<bool> {
  @override
  bool build() {
    return false;
  }

  void completeSplash() {
    state = true;
  }
}

final splashDoneProvider = NotifierProvider<SplashDoneNotifier, bool>(SplashDoneNotifier.new);
