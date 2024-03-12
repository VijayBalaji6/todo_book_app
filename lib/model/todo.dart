// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hive/hive.dart';

part 'todo.g.dart';

enum TodoStatus { inActive, active, completed }

@HiveType(typeId: 1)
class Todo extends HiveObject {
  @HiveField(0)
  String userID;
  @HiveField(1)
  String title;
  @HiveField(2)
  String id;
  @HiveField(3)
  String content;
  @HiveField(4)
  String? note;
  @HiveField(5)
  DateTime? todoTime;
  @HiveField(6)
  TodoStatus todoStatus;

  Todo({
    required this.userID,
    required this.title,
    required this.id,
    required this.content,
    this.note,
    this.todoTime,
    required this.todoStatus,
  });

  Todo copyWith({
    required int userID,
    String? title,
    String? id,
    String? content,
    String? note,
    DateTime? todoTime,
    TodoStatus? todoStatus,
  }) {
    return Todo(
      userID: this.userID,
      title: title ?? this.title,
      id: id ?? this.id,
      content: content ?? this.content,
      note: note ?? this.note,
      todoTime: todoTime ?? this.todoTime,
      todoStatus: todoStatus ?? this.todoStatus,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userID': userID,
      'title': title,
      'id': id,
      'content': content,
      'note': note,
      'todoTime': todoTime?.millisecondsSinceEpoch,
      'todoStatus': _convertTodoStatus(todoStatus),
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      userID: map['userID'],
      title: map['title'] as String,
      id: map['id'] as String,
      content: map['content'] as String,
      note: map['note'] != null ? map['note'] as String : null,
      todoTime: map['todoTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['todoTime'] as int)
          : null,
      todoStatus: _parseTodoStatus(map['todoStatus']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Todo.fromJson(String source) =>
      Todo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TodoModel(title: $title, id: $id, content: $content, note: $note, todoTime: $todoTime, todoStatus: $todoStatus)';
  }

  static TodoStatus _parseTodoStatus(String status) {
    if (status == 'inActive') {
      return TodoStatus.inActive;
    } else if (status == 'active') {
      return TodoStatus.active;
    } else if (status == 'completed') {
      return TodoStatus.completed;
    }
    throw Exception('Unknown TodoStatus: $status');
  }

  static String _convertTodoStatus(TodoStatus status) {
    switch (status) {
      case TodoStatus.active:
        return 'active';
      case TodoStatus.completed:
        return 'completed';
      default:
        return 'inActive';
    }
  }
}

// TypeAdapter for TodoStatus enum
class TodoStatusAdapter extends TypeAdapter<TodoStatus> {
  @override
  final typeId = 2; // Unique ID for this TypeAdapter

  @override
  TodoStatus read(BinaryReader reader) {
    // Read enum value from binary
    return TodoStatus.values[reader.readByte()];
  }

  @override
  void write(BinaryWriter writer, TodoStatus obj) {
    // Write enum value to binary
    writer.writeByte(obj.index);
  }
}
