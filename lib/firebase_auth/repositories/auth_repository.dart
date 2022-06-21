import 'package:firebase_auth/firebase_auth.dart';

import 'base_auth_repository.dart';

class AuthRepository extends BaseAuthRepository {
  final FirebaseAuth _firebaseAuth;

  AuthRepository({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Future<User?> signIn(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseException catch (e) {
      print(e);
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<User?> signUp(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print(e);
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Stream<User?> get user => _firebaseAuth.userChanges();
}
