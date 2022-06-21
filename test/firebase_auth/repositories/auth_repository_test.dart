import 'package:bloc_test_app/firebase_auth/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFireBaseAuth extends Mock implements FirebaseAuth {}

class MockUserCredential extends Mock implements UserCredential {
  final String? _email;
  MockUserCredential({String? email}) : _email = email;
  @override
  User? get user => MockUser(email: _email);
}

class MockUser extends Mock implements User {
  final String? _email;
  MockUser({String? email}) : _email = email;
  @override
  String? get email => _email;
}

void main() {
  late AuthRepository authRepository;
  late MockFireBaseAuth mockFireBaseAuth;
  setUp(() {
    mockFireBaseAuth = MockFireBaseAuth();
    authRepository = AuthRepository(firebaseAuth: mockFireBaseAuth);
  });

  Map<String, String> credential = {
    'email': 'example@email.com',
    'password': 'password'
  };
  group(
    'Authentication Repository Test',
    () {
      group("Sign In Functionalities", () {
        test(
          'Sign in with email and password success',
          () async {
            when(() => mockFireBaseAuth.signInWithEmailAndPassword(
                    email: credential['email']!,
                    password: credential['password']!))
                .thenAnswer((invocation) => Future.value(MockUserCredential()));
            final user = await authRepository.signIn(
                email: credential['email']!, password: credential['password']!);

            expect(user, isA<User>());
          },
        );
        test(
          'Sign in with email and password Failure',
          () async {
            when(() => mockFireBaseAuth.signInWithEmailAndPassword(
                    email: credential['email']!,
                    password: credential['password']!))
                .thenThrow(FirebaseAuthException);

            final user = await authRepository.signIn(
                email: credential['email']!, password: credential['password']!);

            expect(user, null);
          },
        );
      });

      group(
        'Sign Up Functionalities',
        () {
          test(
            'Sign Up with email and password Success',
            () async {
              when(
                () => mockFireBaseAuth.createUserWithEmailAndPassword(
                    email: credential['email']!,
                    password: credential['password']!),
              ).thenAnswer((invocation) =>
                  Future.value(MockUserCredential(email: credential['email'])));
              final user = await authRepository.signUp(
                  email: credential['email']!,
                  password: credential['password']!);
              expect(user, isA<User>());
              expect(user!.email, equals(credential['email']));
            },
          );

          test(
            'Sign Up with email and password Failure',
            () async {
              when(
                () => mockFireBaseAuth.createUserWithEmailAndPassword(
                    email: credential['email']!,
                    password: credential['password']!),
              ).thenThrow(FirebaseException);
              final user = await authRepository.signUp(
                  email: credential['email']!,
                  password: credential['password']!);
              expect(user, isNull);
            },
          );
        },
      );
    },
  );
}
