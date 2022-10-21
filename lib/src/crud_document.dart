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

  static String? getDocumentId(Document document) =>
      document.name?.split('/').last;

  Future<Document> readDocument(String documentPath) async {
    return await firestoreApi.projects.databases.documents
        .get('$rootPath/$documentPath');
  }

  Future<List<Document>> readDocuments(String collectionPath) async {
    final result = await firestoreApi.projects.databases.documents
        .listDocuments(rootPath, collectionPath);
    return result.documents ?? [];
  }

  /// ISSUE: https://github.com/invertase/dart_firebase_apis/issues/5
  Future<int> countDocuments(StructuredQuery structuredQuery) async {
    final request = RunAggregationQueryRequest(
      structuredAggregationQuery: StructuredAggregationQuery(
        aggregations: [
          Aggregation(
            alias: 'result',
            count: Count(),
          ),
        ],
        structuredQuery: structuredQuery,
      ),
    );
    final result =
        await firestoreApi.projects.databases.documents.runAggregationQuery(
      request,
      rootPath,
    );
    final count = int.parse(
        (result[0].result?.aggregateFields?['result'])?.integerValue ?? '0');
    return count;
  }
}
