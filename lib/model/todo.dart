class Todo {
  int _id;
  String _title;
  String _description;
  String _date;
  String _time;
  Todo(dynamic obj) {
    _id = obj['id'];
    _title = obj['title'];
    _description = obj['description'];
    _date = obj['date'];
    _time = obj['time'];
  }
  Todo.fromMap(Map<String, dynamic> data) {
    _id = data['id'];
    _title = data['title'];
    _description = data['description'];
    _date = data['date'];
    _time = data['time'];
  }
  Map<String, dynamic> toMap() => {
        'id': _id,
        'title': _title,
        'description': _description,
        'date': _date,
        'time': _time
      };

  int get id => _id;
  String get title => _title;
  String get description => _description;
  String get date => _date;
  String get time => _time;
}
