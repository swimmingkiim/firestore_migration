import 'package:dart_console/dart_console.dart';
import 'package:firebaseapis/firestore/v1.dart';

class CRUDField {
  CRUDField({
    required this.firestoreApi,
    required this.console,
    required this.projectId,
    this.databaseId = '(default)',
  });

  final FirestoreApi firestoreApi;
  final Console console;
  final String projectId;
  final String databaseId;
  late final rootPath = 'projects/$projectId/databases/$databaseId/documents';

  Future<void> createField(Document document, String key, Value value) async {
    final updatedDocument = Document(name: document.name, fields: {
      key: value,
    });
    await firestoreApi.projects.databases.documents.patch(
      updatedDocument,
      document.name!,
      currentDocument_exists: true,
      updateMask_fieldPaths: [key],
    );
  }
}
