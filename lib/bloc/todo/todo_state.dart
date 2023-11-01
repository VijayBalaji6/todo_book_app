part of 'todo_bloc.dart';

sealed class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

class TodoLoading extends TodoState {}

class TodoLoaded extends TodoState {
  final List<TodoModel> todoList;
  const TodoLoaded({this.todoList = const <TodoModel>[]});
  @override
  List<Object> get props => [todoList];
}

class TodoError extends TodoState {}
