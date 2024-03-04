import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/model/todo.dart';

class TodoLocalServices {
  late Box<Todo> _todo;

  Future<void> init() async {
    _todo = await Hive.openBox('todoBox');
  }

  void writeTodoInLocalDB({required Todo todoData}) {
    _todo.add(todoData);
  }

  List<Todo> getAllTodo({required final String userId}) {
    try {
      List<Todo> todos = _todo.values
          .where(
            ((element) => element.userID == userId),
          )
          .toList();
      if (todos.isEmpty) {
        return [];
      }
      return todos;
    } on Exception {
      return [];
    }
  }

  Future updateTodo({required Todo todo}) async {
    final todoToUpdate = _todo.values.firstWhere(
        (element) => element.userID == todo.userID && element.id == todo.id);
    int index = todoToUpdate.key as int;
    await _todo.put(index, todo);
  }

  Future<void> removeTodo({required int userId, required String taskId}) async {
    final todoToRemove = _todo.values.firstWhere(
        (element) => element.userID == userId && element.id == taskId);
    await todoToRemove.delete();
  }
}
