import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedIndex =
    StateProvider.autoDispose<int>((ref) => 0, name: "selectedIndex");
