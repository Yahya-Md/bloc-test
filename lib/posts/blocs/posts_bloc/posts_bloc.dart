import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/post_model.dart';
import '../../repository/post_repository.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PostRepository postRepository;
  PostsBloc({required this.postRepository}) : super(PostsInitialState()) {
    on<GetPostsEvent>(_onGetPostsEvent);
  }

  FutureOr<void> _onGetPostsEvent(GetPostsEvent event, Emitter<PostsState> emit) async {
    try {
      emit(PostsLoadingState());
      List<Post> posts = await postRepository.getPosts();
      emit(PostsSuccessState(posts: posts));
    } catch (e) {
      emit(PostsErrorState(message: e.toString()));
    }
  }
}
