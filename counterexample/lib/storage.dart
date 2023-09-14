import "package:flutter/foundation.dart";

class CounterStorage {
  CounterStorage();

  Future<bool> writeCounter(int counter) async {
    try {} catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return false;
  }

  Future<int> readCounter() async {
    try {} catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return -1;
  }
}
