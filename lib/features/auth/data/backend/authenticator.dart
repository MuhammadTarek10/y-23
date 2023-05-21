import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:y23/config/utils/constants.dart';
import 'package:y23/features/auth/data/models/auth_result.dart';

class Authenticator {
  const Authenticator();

  User? get user => FirebaseAuth.instance.currentUser;
  String? get userId => user?.uid;
  bool get isAlreadyLoggedIn => userId != null;
  String get displayName => user?.displayName ?? '';
  String? get email => user?.email;

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }

  Future<AuthResults> loginWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [Constants.emailScope],
    );
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      // User aborted login
      return AuthResults.aborted;
    }
    final googleAuth = await googleUser.authentication;
    final credentials = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );
    try {
      await FirebaseAuth.instance.signInWithCredential(credentials);
      return AuthResults.success;
    } on FirebaseAuthException catch (_) {
      return AuthResults.failure;
    }
  }
}
