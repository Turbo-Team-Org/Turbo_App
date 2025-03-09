import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:turbo/authentication/authentication_repository/interface/authentication_interface.dart';
import 'package:turbo/authentication/authentication_repository/models/auth_user.dart';

class AuthenticationService implements AuthenticationInterface {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore firestore;

  AuthenticationService({
    FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firestore,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
       firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<AuthUser?> signInWithEmail({
    required String email,
    required String password,
  }) async {
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _userFromFirestore(userCredential.user);
  }

  @override
  Future<AuthUser?> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = userCredential.user;
    if (user != null) {
      final newUser = AuthUser(
        uid: user.uid,
        email: user.email!,
        displayName: user.displayName,
        photoUrl: user.photoURL,
        favorites: [],
        createdAt: DateTime.now(),
      );
      await firestore.collection('users').doc(user.uid).set(newUser.toJson());
      return newUser;
    }
    return null;
  }

  @override
  Future<AuthUser?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) return null;

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential = await _firebaseAuth.signInWithCredential(credential);
    return _userFromFirestore(userCredential.user);
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    await GoogleSignIn().signOut();
  }

  @override
  Stream<AuthUser?> get authStateChanges =>
      _firebaseAuth.authStateChanges().asyncMap(_userFromFirestore);

  Future<AuthUser?> _userFromFirestore(User? user) async {
    if (user == null) return null;
    final doc = await firestore.collection('users').doc(user.uid).get();
    if (doc.exists) {
      return AuthUser.fromJson(doc.data()!);
    } else {
      final newUser = AuthUser(
        uid: user.uid,
        email: user.email!,
        displayName: user.displayName,
        photoUrl: user.photoURL,
        favorites: [],
        createdAt: DateTime.now(),
      );
      await firestore.collection('users').doc(user.uid).set(newUser.toJson());
      return newUser;
    }
  }
}
