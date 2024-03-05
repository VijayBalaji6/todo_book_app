part of 'todo_bloc.dart';

sealed class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class RegisterTodoServicesEvent extends TodoEvent {
  const RegisterTodoServicesEvent();
  @override
  List<Object> get props => [];
}

class LoadTodoEvent extends TodoEvent {
  final String userId;

  const LoadTodoEvent({required this.userId});

  @override
  List<Object> get props => [userId];
}

class AddTodoEvent extends TodoEvent {
  final Todo todo;
  const AddTodoEvent({required this.todo});
  @override
  List<Object> get props => [todo];
}

class EditTodoEvent extends TodoEvent {
  final Todo todo;
  const EditTodoEvent({required this.todo});
  @override
  List<Object> get props => [todo];
}

class DeleteTodoEvent extends TodoEvent {
  final Todo todo;
  const DeleteTodoEvent({required this.todo});
  @override
  List<Object> get props => [todo];
}
