import "package:flutter/foundation.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:firebase_core/firebase_core.dart";
import 'firebase_options.dart';

class CounterStorage {
  bool _initialized = false;

  CounterStorage();

  Future<void> initializeDefault() async {
    FirebaseApp app = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    _initialized = true;
    if (kDebugMode) {
      print("Initialized default app $app");
    }
  }

  bool get isInitialized => _initialized;

  Future<bool> writeCounter(int counter) async {
    try {
      if (!isInitialized) {
        await initializeDefault();
      }
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      firestore.collection("example").doc("counter").set({
        "count": counter,
      }).then((value) {
        if (kDebugMode) {
          print("writeCounter: $counter");
        }
        return true;
      }).catchError((error) {
        if (kDebugMode) {
          print("writeCounter: $error");
        }
        return false;
      });
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return false;
  }

  Future<int> readCounter() async {
    try {
      if (!isInitialized) {
        await initializeDefault();
      }
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentSnapshot ds =
          await firestore.collection("example").doc("counter").get();
      if (ds.exists && ds.data() != null) {
        Map<String, dynamic> data = (ds.data() as Map<String, dynamic>);
        if (data.containsKey("count")) {
          return data["count"];
        }
      }
      bool writeSuccess = await writeCounter(0);
      if (writeSuccess) {
        return 0;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return -1;
  }
}
