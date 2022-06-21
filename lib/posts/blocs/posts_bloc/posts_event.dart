part of 'posts_bloc.dart';

@immutable
abstract class PostsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetPostsEvent extends PostsEvent {
  GetPostsEvent();
}
