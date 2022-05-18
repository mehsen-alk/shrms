import 'package:shrms/data/firestore/paths.dart';
import 'package:shrms/models/admin.dart';

class AdminFirestoreHelper {
  Future<bool> loginAdmin(Admin admin) async {
    try {
      await AdminPaths.firebaseAuth.signInWithEmailAndPassword(
          email: admin.email, password: admin.password);
      return true;
    } catch (e) {
      return false;
    }
  }
}
