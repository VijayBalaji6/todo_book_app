part of 'todo_bloc.dart';

sealed class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

/// Tod.s
class TodoLoading extends TodoState {
  @override
  List<Object> get props => [];
}

class TodoLoaded extends TodoState {
  final List<TodoModel> todoList;
  const TodoLoaded({this.todoList = const <TodoModel>[]});
  @override
  List<Object> get props => [todoList];
}

class TodoError extends TodoState {
  @override
  List<Object> get props => [];
}
