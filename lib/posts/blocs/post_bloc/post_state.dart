part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostInitialState extends PostState {}

class PostLoadingState extends PostState {}

class PostSuccessState extends PostState {
  final Post post;

  const PostSuccessState({required this.post});
}

class PostErrorState extends PostState {
  final String message;

  const PostErrorState({required this.message});
}
