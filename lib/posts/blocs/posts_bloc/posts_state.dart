part of 'posts_bloc.dart';

@immutable
abstract class PostsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PostsInitialState extends PostsState {}

class PostsLoadingState extends PostsState {}

class PostsSuccessState extends PostsState {
  final List<Post> posts;

  PostsSuccessState({required this.posts});
  @override
  List<Object?> get props => [posts];
}

class PostsErrorState extends PostsState {
  final String message;

  PostsErrorState({required this.message});
  @override
  List<Object?> get props => [message];
}
