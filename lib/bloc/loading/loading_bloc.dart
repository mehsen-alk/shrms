import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'loading_event.dart';
part 'loading_state.dart';

class LoadingBloc extends Bloc<LoadingEvent, LoadingState> {
  LoadingBloc() : super(LoadingState(isLoadnig: false)) {
    on<LoadingOn>((event, emit) {
      emit(LoadingState(isLoadnig: true));
    });
    on<LoadingOff>((event, emit) {
      emit(LoadingState(isLoadnig: false));
    });
  }
}
