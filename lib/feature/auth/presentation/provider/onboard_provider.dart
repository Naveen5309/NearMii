import 'package:flutter_riverpod/flutter_riverpod.dart';

final onboardIndicatorIndex = StateProvider.autoDispose<int>((ref) => 0);
