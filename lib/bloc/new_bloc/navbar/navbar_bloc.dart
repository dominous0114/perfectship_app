import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

part 'navbar_event.dart';
part 'navbar_state.dart';

class NavbarBloc extends Bloc<NavbarEvent, NavbarState> {
  NavbarBloc()
      : super(NavbarInitial(
            isShow: true,
            billScrollController: ScrollController(),
            homeScrollController: ScrollController(),
            orderScrollController: ScrollController())) {
    on<NavbarInitialEvent>(_onInitial);
    on<NavbarOrderScrollShowEvent>(_onOrderShow);
    on<NavbarOrderScrollHideEvent>(_onOrderHide);
  }

  void _onInitial(NavbarInitialEvent event, Emitter<NavbarState> emit) {
    emit(NavbarInitial(
        isShow: true, billScrollController: ScrollController(), homeScrollController: ScrollController(), orderScrollController: ScrollController()));
  }

  void _onOrderShow(NavbarOrderScrollShowEvent event, Emitter<NavbarState> emit) {
    var state = this.state;
    if (state is NavbarInitial) {
      emit(state.copyWith(isShow: true));
    }
  }

  void _onOrderHide(NavbarOrderScrollHideEvent event, Emitter<NavbarState> emit) {
    var state = this.state;
    if (state is NavbarInitial) {
      emit(state.copyWith(isShow: false));
    }
  }
}
