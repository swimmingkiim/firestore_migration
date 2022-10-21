import 'package:dart_console/dart_console.dart';
import 'package:firebaseapis/firestore/v1.dart';
import 'package:firestore_migration/config/config.dart';
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
      projectId: projectId,
    );
    final crudDocument = CRUDDocument(
      firestoreApi: firestoreApi,
      console: console,
      projectId: projectId,
    );
    // final document =
    //     await crudDocument.readDocument('test/8yQWiY1dzOsbAax0RZJi');
    // console.writeLine(CRUDDocument.getDocumentId(document));
    final count = await crudDocument.countDocuments(
      StructuredQuery(
        from: [
          CollectionSelector(
            collectionId: 'test',
          ),
        ],
        where: Filter(
          fieldFilter: FieldFilter(
            field: FieldReference(
              fieldPath: 'hello',
            ),
            op: 'EQUAL',
            value: Value(
              stringValue: 'world',
            ),
          ),
        ),
      ),
    );
    console.writeLine('count : $count');
    console.writeLine('done!');
  }
}
