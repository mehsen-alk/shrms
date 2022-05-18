import 'package:shrms/data/firestore/paths.dart';
import 'package:shrms/models/admin.dart';

class AdminFirestoreHelper {
  Future<void> createAdmin(Admin admin) async {
    await AdminPaths.firebaseAuth.createUserWithEmailAndPassword(
        email: admin.email, password: admin.password);
    await AdminPaths.adminCollection.doc('1').set({'email': admin.email});
  }

  void loginAdmin(Admin admin) async {
    await AdminPaths.firebaseAuth.signInWithEmailAndPassword(
        email: admin.email, password: admin.password);
  }
}
