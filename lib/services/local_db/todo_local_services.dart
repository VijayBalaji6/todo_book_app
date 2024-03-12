import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/model/todo.dart';

class TodoLocalServices {
  TodoLocalServices._internal();
  static final TodoLocalServices _instance = TodoLocalServices._internal();

  static TodoLocalServices get instance => _instance;

  late Box<Todo> _todo;

// Init todo services box
  Future<void> init() async {
    _todo = await Hive.openBox('todoBox');
  }

// Add to new todo to hive DB
  Future<void> addTodoInLocalDB({required Todo todoData}) async {
    try {
      await _todo.put(todoData.id, todoData);
    } catch (e) {
      rethrow;
    }
  }

// get all todo from hive DB of user
  List<Todo> getAllTodo({required final String userId}) {
    List<Todo> todos = [];
    try {
      for (int i = _todo.length - 1; i >= 0; i--) {
        Todo? userMap = _todo.getAt(i);
        if (userMap != null) {
          todos.add(userMap);
        }
      }
      return todos;
    } on Exception {
      rethrow;
    }
  }

// Update a particular todo from hive DB
  Future<void> updateTodo({required Todo todoData}) async {
    try {
      await _todo.put(todoData.id, todoData);
    } catch (e) {
      rethrow;
    }
  }

// Remove a particular todo from hive DB
  Future<void> removeTodo({required Todo todoData}) async {
    try {
      final todoToRemove = _todo.values.firstWhere((element) =>
          element.userID == todoData.userID && element.id == todoData.id);
      await todoToRemove.delete();
    } catch (e) {
      rethrow;
    }
  }
}
