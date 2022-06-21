import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuthRepository {
  Stream<User?> get user;

  Future<User?> signIn({
    required String email,
    required String password,
  });

  Future<User?> signUp({
    required String email,
    required String password,
  });
}
