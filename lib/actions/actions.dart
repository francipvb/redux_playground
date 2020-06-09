class EditTodoListAction {}

class AddTodo implements EditTodoListAction {
  static const _baseHash = 35;

  final String text;

  const AddTodo(this.text) : assert(text != null);

  bool operator ==(other) =>
      other is AddTodo &&
      other.runtimeType == this.runtimeType &&
      other.text == this.text;

  @override
  int get hashCode => _baseHash + text.hashCode * _baseHash;
}

class DeleteTodo implements EditTodoListAction {
  static const _baseHash = 34;

  final int index;

  const DeleteTodo({this.index}) : assert(index != null);

  @override
  int get hashCode => _baseHash + this.index.hashCode * _baseHash;

  @override
  bool operator ==(other) =>
      other is DeleteTodo &&
      other.runtimeType == this.runtimeType &&
      other.index == index;
}

class CompleteTodo implements EditTodoListAction {
  final int index;

  const CompleteTodo({this.index}) : assert(index != null);

  @override
  int get hashCode => 37 + index.hashCode * 37;

  @override
  bool operator ==(other) =>
      other is CompleteTodo &&
      other.runtimeType == this.runtimeType &&
      other.index == index;
}

class UpdateTodo implements EditTodoListAction {
  final int index;
  final String text;

  const UpdateTodo(this.index, this.text);

  @override
  int get hashCode => 39 + text.hashCode * 39 + index.hashCode * 39;

  @override
  bool operator ==(other) =>
      other is UpdateTodo &&
      other.runtimeType == this.runtimeType &&
      other.index == index &&
      other.text == text;
}
