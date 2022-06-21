import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterInitial(value: 0)) {
    on<IncrementCounterEvent>(_onIncrementCounterEvent);
    on<DecrementCounterEvent>(_onDecrementCounterEvent);
  }

  FutureOr<void> _onIncrementCounterEvent(IncrementCounterEvent event, Emitter<CounterState> emit) {
    final state = this.state;
    if (state is CounterInitial) {
      emit(CounterStateSuccess(value: state.value + 1));
    } else if (state is CounterStateSuccess) {
      emit(CounterStateSuccess(value: state.value + 1));
    }
  }

  FutureOr<void> _onDecrementCounterEvent(DecrementCounterEvent event, Emitter<CounterState> emit) {
    final state = this.state;
    if (state is CounterInitial) {
      emit(CounterStateSuccess(value: state.value - 1));
    } else if (state is CounterStateSuccess) {
      emit(CounterStateSuccess(value: state.value - 1));
    }
  }
}
