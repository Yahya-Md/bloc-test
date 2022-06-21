import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'counter/counter_bloc/counter_bloc.dart';
import 'counter/widget/counter_widget.dart';
import 'main.dart';
import 'posts/widget/posts_widget.dart';

class GenerateRoute {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case CounterWidget.route:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => CounterBloc(),
            child: const CounterWidget(),
          ),
        );
      // case LoginWidget.route:
      //   return MaterialPageRoute(
      //     builder: (context) => BlocProvider(
      //       create: (context) => LoginBloc(),
      //       child: const LoginWidget(),
      //     ),
      //   );
      case PostsWidget.route:
        return MaterialPageRoute(builder: (context) => const PostsWidget());
      default:
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
        );
    }
  }
}
