part of 'todo_bloc.dart';

sealed class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class LoadTodoEvent extends TodoEvent {
  final List<TodoModel> todos;
  const LoadTodoEvent({this.todos = const <TodoModel>[]});
  @override
  List<Object> get props => [todos];
}

class AddTodoEvent extends TodoEvent {
  final TodoModel todo;
  const AddTodoEvent({required this.todo});
  @override
  List<Object> get props => [todo];
}

class EditTodoEvent extends TodoEvent {
  final TodoModel todo;
  const EditTodoEvent({required this.todo});
  @override
  List<Object> get props => [todo];
}

class DeleteTodoEvent extends TodoEvent {
  final TodoModel todo;
  const DeleteTodoEvent({required this.todo});
  @override
  List<Object> get props => [todo];
}
