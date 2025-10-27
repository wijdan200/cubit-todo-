abstract class TaskEvent {}

class TaskTextUpdate extends TaskEvent {
  final String text;
  TaskTextUpdate(this.text);
}

class TaskAdd extends TaskEvent {
  // final String text;
  // TaskAdd(this.text);
}

class TaskRemove extends TaskEvent {
  final int id;
  TaskRemove(this.id);
}

class TaskToggle extends TaskEvent {
  final int id;
  TaskToggle(this.id);
}
