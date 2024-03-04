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
    on<RegisterServicesEvent>(_registeringServicesEvent);
    on<LoadTodoEvent>(_onLoadTodo);
    on<AddTodoEvent>(_onAddTodo);
    on<DeleteTodoEvent>(_onDeleteTodo);
    on<EditTodoEvent>(_onEditTodo);
  }

  Future<void> _registeringServicesEvent(
      RegisterServicesEvent event, Emitter<TodoState> emit) async {
    await _todoLocalServices.init();
  }

  void _onLoadTodo(LoadTodoEvent event, Emitter<TodoState> emit) {
    emit(TodoLoading());
    try {
      final userTodo = _todoLocalServices.getAllTodo(userId: event.userId);
      emit(TodoLoaded(todoList: userTodo));
    } catch (e) {
      emit(TodoError());
    }
  }

  void _onAddTodo(AddTodoEvent event, Emitter<TodoState> emit) {
    final state = this.state;
    if (state is TodoLoaded) {
      emit(TodoLoaded(todoList: List.from(state.todoList)..add(event.todo)));
    }
  }

  void _onDeleteTodo(DeleteTodoEvent event, Emitter<TodoState> emit) {
    final state = this.state;
    if (state is TodoLoaded) {
      List<Todo> todosAfterDeletion =
          state.todoList.where((e) => e.id != event.todo.id).toList();
      emit(TodoLoaded(todoList: todosAfterDeletion));
    }
  }

  void _onEditTodo(EditTodoEvent event, Emitter<TodoState> emit) {
    final state = this.state;
    if (state is TodoLoaded) {
      List<Todo> editedTodoList = state.todoList.map((element) {
        return element.id == event.todo.id ? event.todo : element;
      }).toList();
      emit(TodoLoaded(todoList: editedTodoList));
    }
  }
}
