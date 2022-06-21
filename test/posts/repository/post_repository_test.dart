import 'dart:io';
import 'dart:math';

import 'package:bloc_test_app/posts/model/post_model.dart';
import 'package:bloc_test_app/posts/repository/post_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart';

class MockPostRepository extends Mock implements PostRepository {}

class MockClientHttp extends Mock implements Client {}

void main() {
  late MockClientHttp mockHttp;
  late String postsUrl;
  late PostRepository postRepository;
  int id = 1;
  String postsResponse =
      '[{"userId": 1,"id": 1,"title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit","body": "quia et suscipit suscipit recusandae consequuntur expedita et cumreprehenderit molestiae ut ut quas totamnostrum rerum est autem sunt rem eveniet architecto"}]';
  String postResponse =
      '{"userId": 1,"id": 1,"title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit","body": "quia et suscipit suscipit recusandae consequuntur expedita et cumreprehenderit molestiae ut ut quas totamnostrum rerum est autem sunt rem eveniet architecto"}';
  setUp(() {
    postsUrl = 'https://jsonplaceholder.typicode.com/posts';
    mockHttp = MockClientHttp();
    postRepository = PostRepository(mockHttp);
  });
  group('Post Repository Tests', () {
    group('All Posts', () {
      test('Get All Posts Success', () async {
        when(() => mockHttp.get(Uri.parse(postsUrl))).thenAnswer(
          (_) async => Response(postsResponse, 200),
        );
        final getPosts = await postRepository.getPosts();
        expect(getPosts, isA<List<Post>>());
        expect(getPosts.length, 1);
      });
      test('Get All Posts Failure 404', () async {
        when(() => mockHttp.get(Uri.parse(postsUrl))).thenAnswer(
          (_) async => Response('', 404),
        );
        expect(
            () async => await postRepository.getPosts(), throwsFormatException);
      });
      test('Get All Posts Failure Error', () async {
        when(() => mockHttp.get(Uri.parse(postsUrl))).thenThrow(Exception);
        expect(
            () async => await postRepository.getPosts(), throwsFormatException);
      });
    });
    group('One Posts based on Id', () {
      test('Get the Post with id 1 Success', () async {
        when(() => mockHttp.get(Uri.parse(postsUrl))).thenAnswer(
          (_) async => Response(postResponse, 200),
        );
        final getPosts = await postRepository.getPost(id);
        expect(getPosts, isA<Post>());
        expect(getPosts.id, id);
      });
      test('Get All Posts Failure 404', () async {
        when(() => mockHttp.get(Uri.parse(postsUrl))).thenAnswer(
          (_) async => Response('', 404),
        );
        expect(postRepository.getPost(id), throwsFormatException);
      });
      test('Get All Posts Failure Error', () async {
        when(() => mockHttp.get(Uri.parse(postsUrl))).thenThrow(Exception);
        expect(postRepository.getPost(id), throwsFormatException);
      });
    });
  });
}
