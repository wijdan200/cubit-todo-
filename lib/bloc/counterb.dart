import 'package:flutter_bloc/flutter_bloc.dart';
import 'counterevent.dart';
import 'counterstate.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterInitial()) {
    // Counter A events
    on<CounterIncrementA>((event, emit) {
      emit(CounterUpdated(state.counterA + 1, state.counterB));
    });

    on<CounterDecrementA>((event, emit) {
      emit(CounterUpdated(state.counterA - 1, state.counterB));
    });

    // Counter B events
    on<CounterIncrementB>((event, emit) {
      emit(CounterUpdated(state.counterA, state.counterB + 1));
    });

    on<CounterDecrementB>((event, emit) {
      emit(CounterUpdated(state.counterA, state.counterB - 1));
    });

    // Reset both counters
    on<CounterReset>((event, emit) {
      emit(const CounterUpdated(0, 0));
    });
  }
}
