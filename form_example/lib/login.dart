import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _initialized = false;
  UserCredential? _userCredential;
  GoogleSignInAccount? googleUser;

  Future<void> initializeDefault() async {
    FirebaseApp app = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    _initialized = true;
    if (kDebugMode) {
      print("Initialized default app $app");
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    if (!_initialized) {
      await initializeDefault();
    }
    // Trigger the authentication flow
    googleUser = await GoogleSignIn().signIn();

    if (kDebugMode) {
      if (googleUser != null) {
        print(googleUser!.displayName);
      }
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    _userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    setState(() {});
    return _userCredential!;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: getBody(),
        ),
      ),
    );
  }

  List<Widget> getBody() {
    List<Widget> body = [];
    if (googleUser == null) {
      body.add(ElevatedButton(
          child: const Text('Login with Google'),
          onPressed: () {
            signInWithGoogle();
            // Navigate to second route when tapped.
          }));
    } else {
      body.add(ListTile(
        leading: GoogleUserCircleAvatar(identity: googleUser!),
        title: Text(googleUser!.displayName ?? ""),
        subtitle: Text(googleUser!.email ?? ""),
      ));
      body.add(Text(FirebaseAuth.instance.currentUser!.uid));
      body.add(ElevatedButton(
          child: const Text('Logout'),
          onPressed: () {
            FirebaseAuth.instance.signOut();
            GoogleSignIn().signOut();
            setState(() {
              googleUser = null;
            });
          }));
    }
    return body;
  }
}
