import 'package:dart_console/dart_console.dart';
import 'package:firestore_migration/src/arguments_parser.dart';

void main(List<String> arguments) {
  final console = Console();
  console.writeLine('Start : Firestore Migration...');
  console.writeLine('\n');

  final argumentsResult = parseArguments(arguments);
  console.writeLine('command : ${argumentsResult.command?.name}');
  console.writeLine('version : ${argumentsResult['version']}');
  console.writeLine('help : ${argumentsResult['help']}');

  console.writeLine('\n');
  console.writeLine('Finish : Firestore Migration!');
}
