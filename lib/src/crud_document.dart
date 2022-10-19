import 'package:dart_console/dart_console.dart';
import 'package:firebaseapis/firestore/v1.dart';

class CRUDDocument {
  CRUDDocument({
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

  Future<Document> readDocument(String documentPath) async {
    return await firestoreApi.projects.databases.documents
        .get('$rootPath/$documentPath');
  }

  Future<List<Document>> readDocuments(String collectionPath) async {
    final result = await firestoreApi.projects.databases.documents
        .listDocuments(rootPath, collectionPath);
    return result.documents ?? [];
  }
}
