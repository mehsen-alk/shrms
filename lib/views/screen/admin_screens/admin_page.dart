import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shrms/bloc/password_bloc.dart';
import 'package:shrms/views/screen/admin_screens/admin_screen.dart';

class AdminPage extends StatelessWidget {
  static const String id = 'AdminPage';
  const AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PasswordBloc(),
      child: const AdminScreen(),
    );
  }
}
