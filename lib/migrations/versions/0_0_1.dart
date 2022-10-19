import 'package:firebaseapis/firestore/v1.dart';
import 'package:dart_console/src/console.dart';
import 'package:firestore_migration/src/crud_document.dart';
import 'package:firestore_migration/src/crud_field.dart';
import 'package:version/version.dart';

import '../migration.dart';

class Migration_0_0_1 implements MigrationFunc {
  @override
  Version get version => Version(0, 0, 1);

  @override
  Future<void> execute(FirestoreApi firestoreApi, Console console) async {
    print('this is 0.0.1');
    final crudField = CRUDField(
      firestoreApi: firestoreApi,
      console: console,
      projectId: 'test-firebase-6680c',
    );
    final crudDocument = CRUDDocument(
      firestoreApi: firestoreApi,
      console: console,
      projectId: 'test-firebase-6680c',
    );
    final document =
        await crudDocument.readDocument('test/tMgqEWqTHzMLC0vy30Op');
    await crudField.createField(
        document, 'hello', Value(stringValue: 'world2'));
    console.writeLine('done!');
  }
}
