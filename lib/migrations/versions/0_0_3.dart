import 'package:firebaseapis/firestore/v1.dart';
import 'package:dart_console/src/console.dart';
import 'package:version/version.dart';
import '../migration.dart';

class Migration_0_0_3 implements MigrationFunc {
  @override
  Version get version => Version(0, 0, 3);

  @override
  Future<void> execute(FirestoreApi firestoreApi, Console console) async {
    print('this is 0.0.3');
  }
}
