part of 'counter_bloc.dart';

@immutable
abstract class CounterState extends Equatable {
  @override
  List<Object> get props => [];
}

class CounterInitial extends CounterState {
  final int value;

  CounterInitial({required this.value});

  @override
  List<Object> get props => [value];
}

class CounterStateSuccess extends CounterState {
  final int value;

  CounterStateSuccess({required this.value});

  @override
  List<Object> get props => [value];
}

class CounterStateError extends CounterState {
  final String message;

  CounterStateError({this.message = ''});

  @override
  List<Object> get props => [message];
}
