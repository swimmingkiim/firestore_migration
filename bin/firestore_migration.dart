import 'package:dart_console/dart_console.dart';
import 'package:firestore_migration/src/arguments_parser.dart';
import 'package:firestore_migration/src/util.dart';

void main(List<String> arguments) {
  final console = Console();

  // Parse command line arguments
  final argumentsResult = parseArguments(arguments);
  final command = argumentsResult.command;
  final version = argumentsResult['version'];
  final isHelp = argumentsResult['help'];

  // Check isHelp is true
  if (isHelp) {
    printHelperText(console);
    return;
  }

  console.writeLine('Start : Firestore Migration...');
  console.writeLine('\n');

  console.writeLine('\n');
  console.writeLine('Finish : Firestore Migration!');
}
