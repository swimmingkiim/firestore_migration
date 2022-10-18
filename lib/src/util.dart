import 'dart:io';

import 'package:dart_console/dart_console.dart';
import 'package:version/version.dart';

void printHelperText(Console console) {
  console.writeLine('firestore_migration');
  console.writeLine('\n');
  console.writeLine('A Dart console application for firestore migration');
  console.writeLine('\n');

  console.writeLine('\n');
  console.writeLine('[Commands]');
  console.writeLine('\n');
  console.writeAligned(' ', 4);
  console.writeLine('${'migration'.padRight(15)} : Start migration work');

  console.writeLine('\n');
  console.writeLine('[Options]');
  console.writeLine('\n');
  console.writeAligned(' ', 4);
  console.writeLine('--version, -v'.padRight(15));
  console.writeAligned(' ', 4);
  console.writeAligned(' ', 15);
  console.writeLine(
      ' : Specify migration file version to run. Format should be match to semver(x.y.z) Default is latest.');

  console.writeLine('\n');
  console.writeLine('[Flags]');
  console.writeLine('\n');
  console.writeAligned(' ', 4);
  console
      .writeLine('${'--help'.padRight(15)} : Display helper text on terminal');
}

Future<List<MapEntry<Version, File>>> getFilesWithVersion(
    Directory directory) async {
  final files = await directory.list().toList();
  return files.whereType<File>().map((file) {
    final rawVersion = file.path
        .split('/')
        .last
        .replaceFirst('.dart', '')
        .split('_')
        .map((number) => int.parse(number))
        .toList();
    final version = Version(rawVersion[0], rawVersion[1], rawVersion[2]);
    return MapEntry(version, file);
  }).toList()
    ..sort((a, b) => a.key.compareTo(b.key));
}
