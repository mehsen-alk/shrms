import 'package:shrms/data/firestore/paths.dart';
import 'package:shrms/models/admin.dart';

class AdminFirestoreHelper {
  void loginAdmin(Admin admin) async {
    await AdminPaths.firebaseAuth.signInWithEmailAndPassword(
        email: admin.email, password: admin.password);
  }
}
