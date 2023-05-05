import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imagetopdf/feature/bottombar/navstate.dart';

class NavNotifier extends StateNotifier<NavState> {
  NavNotifier() : super(const NavState());

  void changeIndex(int index) {
    state = state.copyWith(index: index);
  }
}
final navProvider = StateNotifierProvider<NavNotifier, NavState>((ref) => NavNotifier());