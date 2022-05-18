import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'password_event.dart';
part 'password_state.dart';

class PasswordBloc extends Bloc<PasswordEvent, PasswordState> {
  PasswordBloc()
      : super(
            PasswordState(obscureText: true, iconData: Icons.visibility_off)) {
    on<Invisible>((event, emit) {
      emit(PasswordState(obscureText: true, iconData: Icons.visibility));
    });
    on<Visible>((event, emit) {
      emit(PasswordState(obscureText: false, iconData: Icons.visibility_off));
    });
  }
}
