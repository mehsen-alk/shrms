import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shrms/bloc/loading/loading_bloc.dart';
import 'package:shrms/bloc/loading/loading_bloc.dart';
import 'package:shrms/bloc/password_bloc.dart';
import 'package:shrms/data/firestore/admin_firestore_helper.dart';
import 'package:shrms/models/admin.dart';
import 'package:shrms/views/components/box_button.dart';
import 'package:shrms/views/components/employee_form_field.dart';
import 'package:shrms/views/screen/home_screen.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    Admin admin = Admin(password: '', email: '');
    AdminFirestoreHelper _helper = AdminFirestoreHelper();
    return ScreenUtilInit(builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("SHRMS"),
        ),
        body: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  EmployeeFormField(
                    obscureText: false,
                    labelText: 'Email',
                    prefixIcon: Icons.email,
                    onChange: (value) {
                      admin.email = value;
                    },
                    validator: (String? email) {
                      if (email == null || email == '' || email.isEmpty) {
                        return 'Can\'t be empty';
                      } else if (!email.contains('@') || !email.contains('.')) {
                        return 'Invalid email format';
                      } else if (email.length < 12) {
                        return 'too short';
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.singleLineFormatter
                    ],
                  ),
                  BlocBuilder<PasswordBloc, PasswordState>(
                    builder: (context, state) {
                      return EmployeeFormField(
                        obscureText: state.obscureText,
                        labelText: 'Password',
                        prefixIcon: Icons.lock,
                        suffixIcon: IconButton(
                            onPressed: () {
                              state.obscureText
                                  ? context.read<PasswordBloc>().add(Visible())
                                  : context
                                      .read<PasswordBloc>()
                                      .add(Invisible());
                            },
                            icon: Icon(
                              state.obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: const Color(0XFF329D9C),
                            )),
                        onChange: (value) {
                          admin.password = value;
                        },
                        validator: (String? password) {
                          if (password == null ||
                              password == '' ||
                              password.isEmpty) {
                            return "Can't be empty";
                          } else if (password.length < 7) {
                            return "Password must not be at least than 7 characters long";
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.text,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.singleLineFormatter
                        ],
                      );
                    },
                  ),
                  BlocBuilder<LoadingBloc, LoadingState>(
                    builder: (context, state) {
                      return state.isLoadnig
                          ? const CircularProgressIndicator(
                              color: Color(0XFF56C596))
                          : Box(
                              text: "Login",
                              onPress: () async {
                                if (_formKey.currentState!.validate()) {
                                  context.read<LoadingBloc>().add(LoadingOn());
                                  try {//*
                                    _helper.loginAdmin(admin);
                                    if (await _helper.loginAdmin(admin)) {
                                      Navigator.pushNamed(
                                          context, HomeScreen.id);
                                    } else if (await _helper
                                            .loginAdmin(admin) ==
                                        false) {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              backgroundColor:
                                                  const Color(0XFF205072),
                                              title: const Text(
                                                'Email or Password is incorrect',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              actions: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    context
                                                        .read<LoadingBloc>()
                                                        .add(LoadingOff());
                                                  },
                                                  child: const Text('OK'),
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all<Color>(
                                                      const Color(0XFF56C596),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          });
                                    }
                                  } catch (e) {
                                    print('this is error->$e');
                                  }
                                }
                              },
                            );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
