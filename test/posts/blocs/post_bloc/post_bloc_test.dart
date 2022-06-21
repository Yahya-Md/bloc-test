import 'package:bloc_test/bloc_test.dart';
import 'package:bloc_test_app/posts/blocs/post_bloc/post_bloc.dart';
import 'package:bloc_test_app/posts/model/post_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../repository/post_repository_test.dart';

void main() {
  late PostBloc postBloc;
  late MockPostRepository mockPostRepository;

  final post = Post.fromJason({
    "userId": 1,
    "id": 1,
    "title":
        "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
    "body":
        "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
  });

  setUp(
    () {
      mockPostRepository = MockPostRepository();
      postBloc = PostBloc(postRepository: mockPostRepository);
    },
  );
  group('Post Bloc', () {
    test("Post Initial State", () {
      expect(postBloc.state, equals(PostInitialState()));
    });

    blocTest(
      'Post Success State',
      build: () {
        when(() => mockPostRepository.getPost(any())).thenAnswer((_) async {
          return post;
        });
        return postBloc;
      },
      act: (PostBloc bloc) => bloc.add(const GetPostEvent(id: 1)),
      verify: (_) {
        verify(() => mockPostRepository.getPost(any())).called(1);
      },
      expect: () => [PostLoadingState(), PostSuccessState(post: post)],
    );
    blocTest(
      'Post Error State',
      build: () {
        when(() => mockPostRepository.getPost(any())).thenThrow(Error());
        return postBloc;
      },
      act: (PostBloc bloc) => bloc.add(const GetPostEvent(id: 1)),
      verify: (_) {
        verify(() => mockPostRepository.getPost(any())).called(1);
      },
      expect: () =>
          [PostLoadingState(), PostErrorState(message: Error().toString())],
    );
  });
}
