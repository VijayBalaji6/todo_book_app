// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo/model/todo.dart';
import 'package:todo/services/local_db/todo_local_services.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoLocalServices _todoLocalServices;

  TodoBloc(
    this._todoLocalServices,
  ) : super(RegisterTodoService()) {
    on<RegisterTodoServicesEvent>(_registeringServicesEvent);
    on<LoadTodoEvent>(_onLoadTodo);
    on<AddTodoEvent>(_onAddTodo);
    on<DeleteTodoEvent>(_onDeleteTodo);
    on<EditTodoEvent>(_onEditTodo);
  }

  Future<void> _registeringServicesEvent(
      RegisterTodoServicesEvent event, Emitter<TodoState> emit) async {
    await _todoLocalServices.init();
  }

  void _onLoadTodo(LoadTodoEvent event, Emitter<TodoState> emit) {
    emit(TodoLoading());
    try {
      final List<Todo> userTodo =
          _todoLocalServices.getAllTodo(userId: event.userId);
      emit(TodoLoaded(todoList: userTodo));
    } catch (e) {
      emit(TodoError());
    }
  }

  Future<void> _onAddTodo(AddTodoEvent event, Emitter<TodoState> emit) async {
    emit(TodoLoading());
    try {
      await _todoLocalServices.addTodoInLocalDB(todoData: event.todo);
    } catch (e) {
      emit(TodoError());
    } finally {
      emit(TodoLoaded(
          todoList: _todoLocalServices.getAllTodo(userId: event.todo.userID)));
    }
  }

  void _onDeleteTodo(DeleteTodoEvent event, Emitter<TodoState> emit) async {
    emit(TodoLoading());
    try {
      await _todoLocalServices.removeTodo(todoData: event.todo);
    } catch (e) {
      emit(TodoError());
    } finally {
      emit(TodoLoaded(
          todoList: _todoLocalServices.getAllTodo(userId: event.todo.userID)));
    }
  }

  void _onEditTodo(EditTodoEvent event, Emitter<TodoState> emit) async {
    emit(TodoLoading());
    try {
      await _todoLocalServices.updateTodo(todoData: event.todo);
    } catch (e) {
      emit(TodoError());
    } finally {
      emit(TodoLoaded(
          todoList: _todoLocalServices.getAllTodo(userId: event.todo.userID)));
    }
  }
}
