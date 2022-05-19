part of 'loading_bloc.dart';

@immutable
abstract class LoadingEvent {}

class LoadingOn extends LoadingEvent {}

class LoadingOff extends LoadingEvent {}
