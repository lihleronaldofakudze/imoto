import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:imoto/models/CurrentUser.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CurrentUser? _userFromFirebase(User? user) {
    return user != null ? CurrentUser(uid: user.uid) : null;
  }

  Stream<CurrentUser?> get user {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  Future? register({required String email, required String password}) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      return _userFromFirebase(userCredential.user);
    } catch (error) {
      return null;
    }
  }

  Future? login({required String email, required String password}) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return _userFromFirebase(userCredential.user);
    } catch (error) {
      return null;
    }
  }

  Future? forgotPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return null;
    } catch (error) {
      return null;
    }
  }

  Future<CurrentUser?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication!.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final UserCredential? userCredential =
          await _auth.signInWithCredential(credential);
      return _userFromFirebase(userCredential!.user);
    } catch (error) {
      print(error.toString());
      return null;
    }
    return null;
  }

  Future? signOut() {
    try {
      return _auth.signOut();
    } catch (error) {
      return null;
    }
  }
}
