import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shrms/data/firestore/admin_firestore_helper.dart';
import 'package:shrms/data/firestore/paths.dart';
import 'package:shrms/models/admin.dart';
import 'package:shrms/views/components/box_button.dart';
import 'package:shrms/views/components/employee_form_field.dart';
import 'package:shrms/views/screen/home_screen.dart';

class AdminScreen extends StatelessWidget {
  static const String id = 'AdminScreen';
  const AdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    Admin admin = Admin(password: '', email: '');
    AdminFirestoreHelper _helper = AdminFirestoreHelper();
    bool obscureText = true;
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
                    validator: (String? email) {},
                    keyboardType: TextInputType.text,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.singleLineFormatter
                    ],
                  ),
                  EmployeeFormField(
                    obscureText: obscureText,
                    labelText: 'Password',
                    prefixIcon: Icons.lock,
                    suffixIcon:
                        obscureText ? Icons.visibility_off : Icons.visibility,
                    onChange: (value) {
                      admin.password = value;
                    },
                    validator: (String? password) {},
                    keyboardType: TextInputType.text,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.singleLineFormatter
                    ],
                  ),
                  Box(
                      text: "Login",
                      onPress: () async {
                        try {
                          _helper.loginAdmin(admin);
                          Navigator.pushNamed(context, HomeScreen.id);
                        } catch (e) {
                          print('this is error->$e');
                        }
                      }),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
