import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/post_model.dart';
import '../../repository/post_repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepository;
  PostBloc({required this.postRepository}) : super(PostInitialState()) {
    on<GetPostEvent>(_onGetPostEvent);
  }

  FutureOr<void> _onGetPostEvent(GetPostEvent event, Emitter<PostState> emit) async {
    try {
      emit(PostLoadingState());
      Post post = await postRepository.getPost(event.id);
      emit(PostSuccessState(post: post));
    } catch (e) {
      emit(PostErrorState(message: e.toString()));
    }
  }
}
