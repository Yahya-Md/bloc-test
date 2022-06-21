import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

import '../blocs/posts_bloc/posts_bloc.dart';
import '../model/post_model.dart';
import '../repository/post_repository.dart';

class PostsWidget extends StatelessWidget {
  static const String name = 'Posts';
  static const String route = '/posts';
  const PostsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => Client(),
      child: RepositoryProvider(
        create: (context) => PostRepository(context.read<Client>()),
        child: MultiBlocProvider(providers: [
          BlocProvider<PostsBloc>(
            create: (context) =>
                PostsBloc(postRepository: context.read<PostRepository>())
                  ..add(GetPostsEvent()),
          )
        ], child: const PostListWidget()),
      ),
    );
  }
}

class PostListWidget extends StatelessWidget {
  const PostListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostsBloc, PostsState>(
      builder: (context, state) {
        if (state is PostsLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PostsSuccessState) {
          List<Post> posts = state.posts;
          return ListView.separated(
              itemBuilder: (context, i) {
                return ListTile(
                  title: Text(posts[i].title),
                  subtitle: Text(
                    posts[i].body,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemCount: posts.length);
        } else if (state is PostsErrorState) {
          return Center(
            child: Text(state.message),
          );
        }
        return Container();
      },
    );
  }
}
