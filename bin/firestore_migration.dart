import 'dart:convert';
import 'dart:io';

import 'package:dart_console/dart_console.dart';
import 'package:firestore_migration/firestore_migration.dart';
import 'package:firebaseapis/firestore/v1.dart' as firestore;

Future<void> main(List<String> arguments) async {
  final console = Console();

  // Parse command line arguments
  final argumentsResult = parseArguments(arguments);
  final command = argumentsResult.command;
  String? version = argumentsResult['version'];
  final serviceAccount = argumentsResult['service-account'];
  final isHelp = argumentsResult['help'];

  // Check isHelp is true
  if (isHelp) {
    printHelperText(console);
    return;
  }

  // Check if a command exists
  if (command == null) {
    console.writeLine(
        'If you want to run migration make sure you add "migrate" command');
    return;
  }

  // Start Migration
  console.writeLine('Start : Firestore Migration...');
  console.writeLine('\n');

  final migrationFiles =
      await getFilesWithVersion(Directory('lib/migrations/versions'));

  if (version == null) {
    // Find latest version
    version = migrationFiles.last.key.toString();
  } else {
    // Check if version file exists
    final fileIndex =
        migrationFiles.indexWhere((entry) => entry.key.toString() == version);
    if (fileIndex < 0) {
      throw Error();
    }
  }

  // Get Firestore API
  final authClient = await getAuthClient(
    jsonDecode(File(serviceAccount).readAsStringSync()),
  );
  final firestoreApi = firestore.FirestoreApi(authClient);

  // Run migration script from lib/migrations
  await migrations
      .firstWhere((migration) => migration.version.toString() == version)
      .execute(firestoreApi, console);

  // End Migration
  console.writeLine('\n');
  console.writeLine('Finish : Firestore Migration!');
  exit(0);
}
