import 'package:equatable/equatable.dart';

class TaskModel extends Equatable {
  final int id;
  final String title;
  final bool isDone;

  const TaskModel({
    required this.id,
    required this.title,
    required this.isDone,
  });
  // لحتى استخدمها في التعديل على المهمة واغير اذا دن او لا 
  TaskModel copyWith({int? id, String? title, bool? isDone}) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
    );
  }
  @override
  List<Object?> get props => [id, title, isDone];


}
