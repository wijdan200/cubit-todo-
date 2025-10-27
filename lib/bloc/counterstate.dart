// Base sealed class for counter states
sealed class CounterState {
  final int counterA;
  final int counterB;

  const CounterState(this.counterA, this.counterB);
}

class CounterInitial extends CounterState {
  const CounterInitial() : super(0, 0);
  
  CounterState copyWith({int? counterA, int? counterB}) {
    return CounterUpdated(
      counterA ?? this.counterA,
      counterB ?? this.counterB,
    );
  }
}

class CounterUpdated extends CounterState {
  const CounterUpdated(int counterA, int counterB) : super(counterA, counterB);
  
  CounterState copyWith({int? counterA, int? counterB}) {
    return CounterUpdated(
      counterA ?? this.counterA,
      counterB ?? this.counterB,
    );
  }
}
