import 'package:bloc_test/bloc_test.dart';
import 'package:bloc_test_app/posts/blocs/posts_bloc/posts_bloc.dart';
import 'package:bloc_test_app/posts/model/post_model.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';
import '../../repository/post_repository_test.dart';

void main() {
  late PostsBloc postsBloc;
  late MockPostRepository mockPostRepository;
  final post = Post.fromJason({
    "userId": 1,
    "id": 1,
    "title":
        "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
    "body":
        "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
  });
  final posts = [
    post,
  ];
  setUp(
    () {
      mockPostRepository = MockPostRepository();
      postsBloc = PostsBloc(postRepository: mockPostRepository);
    },
  );

  group(
    'Posts Bloc',
    () {
      test('Posts Initial State', () {
        expect(postsBloc.state, PostsInitialState());
      });

      blocTest(
        'Posts Success State',
        build: () {
          when(
            mockPostRepository.getPosts,
          ).thenAnswer((_) async {
            return posts;
          });
          return postsBloc;
        },
        verify: (_) {
          verify(() => mockPostRepository.getPosts()).called(1);
        },
        act: (PostsBloc bloc) => bloc.add(GetPostsEvent()),
        expect: () => [PostsLoadingState(), PostsSuccessState(posts: posts)],
      );
      blocTest(
        'Posts Error State',
        build: () {
          when(
            mockPostRepository.getPosts,
          ).thenThrow(Error());
          return postsBloc;
        },
        verify: (_) {
          verify(() => mockPostRepository.getPosts()).called(1);
        },
        act: (PostsBloc bloc) => bloc.add(GetPostsEvent()),
        expect: () =>
            [PostsLoadingState(), PostsErrorState(message: Error().toString())],
      );
    },
  );
}
