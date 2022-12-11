import 'dart:io';

String fixture(String name) => File('test/testdata/$name').readAsStringSync();

String get fixtureForUrl => File('assets/api/config.json').readAsStringSync();
