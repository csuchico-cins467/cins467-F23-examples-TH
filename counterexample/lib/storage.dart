import "dart:io";

import "package:flutter/foundation.dart";
import "package:path_provider/path_provider.dart";

class CounterStorage {
  const CounterStorage();

  Future<String> _localPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> _localFile() async {
    final path = await _localPath();
    return File("$path/counter.txt");
  }

  Future<bool> writeCounter(int counter) async {
    try {
      final File file = await _localFile();
      await file.writeAsString("$counter");
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return false;
  }

  Future<int> readCounter() async {
    try {
      final File file = await _localFile();
      String contents = await file.readAsString();
      return int.parse(contents);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      bool writeSuccess = await writeCounter(0);
      if (writeSuccess) {
        return 0;
      }
    }
    return -1;
  }
}
