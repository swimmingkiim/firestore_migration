import 'package:dart_console/dart_console.dart';
import 'package:firebaseapis/firestore/v1.dart';
import 'package:version/version.dart';

abstract class MigrationFunc {
  Version get version;
  Future<void> execute(FirestoreApi firestoreApi, Console console);
}
