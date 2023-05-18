part of 'navbar_bloc.dart';

abstract class NavbarState extends Equatable {
  const NavbarState();

  @override
  List<Object> get props => [];
}

class NavbarInitial extends NavbarState {
  final ScrollController orderScrollController;
  final ScrollController billScrollController;
  final ScrollController homeScrollController;
  final bool isShow;
  NavbarInitial({
    required this.orderScrollController,
    required this.billScrollController,
    required this.homeScrollController,
    required this.isShow,
  });

  @override
  List<Object> get props => [orderScrollController, billScrollController, homeScrollController, isShow];

  NavbarInitial copyWith({
    ScrollController? orderScrollController,
    ScrollController? billScrollController,
    ScrollController? homeScrollController,
    bool? isShow,
  }) {
    return NavbarInitial(
        billScrollController: billScrollController ?? this.billScrollController,
        homeScrollController: homeScrollController ?? this.homeScrollController,
        isShow: isShow ?? this.isShow,
        orderScrollController: orderScrollController ?? this.orderScrollController);
  }
}

// class NavbarShowState extends NavbarState {
//   @override
//   List<Object> get props => [];
// }

// class NavbarHideState extends NavbarState {
//   @override
//   List<Object> get props => [];
// }
