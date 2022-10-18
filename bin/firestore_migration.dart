import 'dart:io';

import 'package:dart_console/dart_console.dart';
import 'package:dart_eval/dart_eval.dart';
import 'package:firestore_migration/src/arguments_parser.dart';
import 'package:firestore_migration/src/util.dart';

Future<void> main(List<String> arguments) async {
  final console = Console();

  // Parse command line arguments
  final argumentsResult = parseArguments(arguments);
  final command = argumentsResult.command;
  String? version = argumentsResult['version'];
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

  final migrationFiles = await getFilesWithVersion(Directory('migrations'));

  late File migrationFile;
  if (version == null) {
    // Find latest version
    version = migrationFiles.last.key.toString();
    migrationFile = migrationFiles.last.value;
  } else {
    // Check if version file exists
    final fileIndex =
        migrationFiles.indexWhere((entry) => entry.key.toString() == version);
    if (fileIndex >= 0) {
      migrationFile = migrationFiles[fileIndex].value;
    } else {
      throw Error();
    }
  }

  // Run migration script
  final rawString = migrationFile.readAsStringSync();
  eval(
    rawString,
    function: 'migrate_${version.replaceAll('.', '_')}',
    args: [],
  );

  // End Migration
  console.writeLine('\n');
  console.writeLine('Finish : Firestore Migration!');
}
