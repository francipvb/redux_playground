import 'package:collection/collection.dart';

const _equality = ListEquality();

class AppState {
  final TodoList todos;

  const AppState({
    this.todos,
  });

  @override
  int get hashCode => 13 + 13 * todos.hashCode;

  @override
  bool operator ==(other) =>
      other is AppState &&
      other.runtimeType == this.runtimeType &&
      other.todos == this.todos;
}

class TodoList {
  static const _baseHash = 19;
  final List<TodoItem> todoItems;
  final bool isInvalidated;
  final DateTime lastUpdate;

  const TodoList({
    this.todoItems = const [],
    this.isInvalidated = false,
    this.lastUpdate,
  });

  @override
  int get hashCode =>
      _baseHash +
      _baseHash * this.isInvalidated.hashCode +
      _baseHash *
          this
              .todoItems
              .map((e) => e.hashCode)
              .reduce((value, element) => element + value) +
      _baseHash * this.lastUpdate.hashCode;

  @override
  bool operator ==(other) =>
      other is TodoList &&
      other.runtimeType == this.runtimeType &&
      other.isInvalidated == this.isInvalidated &&
      _equality.equals(other.todoItems, this.todoItems);
}

class TodoItem {
  static const _baseHash = 23;

  final String text;
  final bool completed;
  final DateTime completionDate;

  const TodoItem({
    this.text,
    this.completed = false,
    this.completionDate,
  }) : assert(text != null);

  @override
  int get hashCode =>
      _baseHash +
      text.hashCode * _baseHash +
      completed.hashCode * _baseHash +
      completionDate.hashCode * _baseHash;

  @override
  bool operator ==(other) =>
      other is TodoItem &&
      other.runtimeType == this.runtimeType &&
      other.text == this.text &&
      other.completed == this.completed &&
      other.completionDate == this.completionDate;
}
