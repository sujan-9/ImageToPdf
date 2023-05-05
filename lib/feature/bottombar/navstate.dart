import 'package:equatable/equatable.dart';

class NavState extends Equatable{
  final int index;
  const NavState({this.index=0});
  
  NavState copyWith({int? index}) {
    return NavState(index: index ?? this.index);
  }

  @override
  List<Object?> get props => [index];
}