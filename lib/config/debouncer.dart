import 'dart:async';
import 'package:flutter/widgets.dart';

class Debouncer {
  Timer? _timer;

  Debouncer();

  void run(VoidCallback action) {
    _timer?.cancel(); // Cancel the previous timer if still running
    _timer = Timer(const Duration(milliseconds: 300), action);
  }

  void cancel() {
    _timer?.cancel();
  }
}
