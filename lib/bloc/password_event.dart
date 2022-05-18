part of 'password_bloc.dart';

@immutable
abstract class PasswordEvent {}

class Visible extends PasswordEvent {}

class Invisible extends PasswordEvent {}
