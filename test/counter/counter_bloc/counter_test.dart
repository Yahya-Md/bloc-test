import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import '../../../lib/counter/counter_bloc/counter_bloc.dart';

void main() {
  late CounterBloc counterBloc;
  setUp(() {
    counterBloc = CounterBloc();
  });
  group(
    'Counter Test',
    () {
      blocTest(
        'Counter bloc Exists',
        build: () => counterBloc,
        expect: () => <CounterState>[],
      );

      test('Initial state is CounterInitial with value 0', () {
        expect(counterBloc.state, CounterInitial(value: 0));
      });
      blocTest<CounterBloc, CounterState>(
        'Counter bloc increment',
        build: () => counterBloc,
        act: (CounterBloc bloc) => bloc.add(IncrementCounterEvent()),
        expect: () => <CounterState>[
          CounterStateSuccess(value: 1),
        ],
      );
      blocTest<CounterBloc, CounterState>(
        'Counter bloc decrement',
        build: () => counterBloc,
        act: (CounterBloc bloc) => bloc.add(DecrementCounterEvent()),
        expect: () => <CounterState>[
          CounterStateSuccess(value: -1),
        ],
      );

      blocTest<CounterBloc, CounterState>(
        'Counter bloc increment after a Value',
        build: () => counterBloc,
        seed: () {
          return CounterStateSuccess(value: 1);
        },
        act: (CounterBloc bloc) => bloc.add(IncrementCounterEvent()),
        expect: () => <CounterState>[
          CounterStateSuccess(value: 2),
        ],
      );
      blocTest<CounterBloc, CounterState>(
        'Counter bloc decrement after a Value',
        build: () => counterBloc,
        seed: () {
          return CounterStateSuccess(value: 1);
        },
        act: (CounterBloc bloc) => bloc.add(DecrementCounterEvent()),
        expect: () => <CounterState>[
          CounterStateSuccess(value: 0),
        ],
      );
    },
  );
}
