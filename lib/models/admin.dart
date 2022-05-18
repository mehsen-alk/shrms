import 'package:shrms/data/firestore/paths.dart';

class Admin {
  String email;
  String password;
  Admin({required this.email, required this.password});

  Future<void> createAdmin(Admin admin) async {
    AdminPaths.firebaseAuth.createUserWithEmailAndPassword(
        email: admin.email, password: admin.password);
    AdminPaths.adminCollection.doc('1').set({'email': admin.email});
  }

  Future<void> loginAdmin(Admin admin) async {
    AdminPaths.firebaseAuth.signInWithEmailAndPassword(
        email: admin.email, password: admin.password);
  }
}
