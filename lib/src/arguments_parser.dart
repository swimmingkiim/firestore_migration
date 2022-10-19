import 'package:args/args.dart';

ArgResults parseArguments(List<String> arguments) {
  final argParser = ArgParser()
    ..addCommand('migrate')
    ..addOption('version', abbr: 'v')
    ..addOption('service-account', abbr: 's', mandatory: true)
    ..addFlag('help');
  final result = argParser.parse(arguments);
  return result;
}
