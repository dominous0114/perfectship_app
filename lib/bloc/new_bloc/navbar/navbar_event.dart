part of 'navbar_bloc.dart';

abstract class NavbarEvent extends Equatable {
  const NavbarEvent();

  @override
  List<Object> get props => [];
}

class NavbarInitialEvent extends NavbarEvent {}

class NavbarOrderScrollShowEvent extends NavbarEvent {}

class NavbarOrderScrollHideEvent extends NavbarEvent {}
