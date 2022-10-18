import 'package:args/args.dart';

ArgResults parseArguments(List<String> arguments) {
  final argParser = ArgParser()
    ..addCommand('migrate')
    ..addOption('version', abbr: 'v')
    ..addFlag('help');
  final result = argParser.parse(arguments);
  return result;
}
