// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

enum TodoStatus { inActive, active, completed }

class TodoModel {
  String title;
  String id;
  String content;
  String? note;
  DateTime? todoTime;
  TodoStatus todoStatus;
  TodoModel({
    required this.title,
    required this.id,
    required this.content,
    this.note,
    this.todoTime,
    required this.todoStatus,
  });

  TodoModel copyWith({
    String? title,
    String? id,
    String? content,
    String? note,
    DateTime? todoTime,
    TodoStatus? todoStatus,
  }) {
    return TodoModel(
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
      'title': title,
      'id': id,
      'content': content,
      'note': note,
      'todoTime': todoTime?.millisecondsSinceEpoch,
      'todoStatus': _convertTodoStatus(todoStatus),
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
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

  factory TodoModel.fromJson(String source) =>
      TodoModel.fromMap(json.decode(source) as Map<String, dynamic>);

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
      case TodoStatus.inActive:
        return 'inActive';
      case TodoStatus.active:
        return 'active';
      case TodoStatus.completed:
        return 'completed';
    }
  }
}
